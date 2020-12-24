//
//  ApiClient.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import Foundation
import Alamofire


enum APIResult<T> {
    case success(T)
    case failure(Error?)
    case failObject(ErrorEntity?)
}

class APIClient {
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    var baseURL: String = APIManager.shared.baseURL
    var apiKey: String = APIManager.shared.apiKey
    
    static let shared = APIClient()
    
    private init(){}
    
    @discardableResult
    func request<T: Requestable>(req: T, completionHandler: @escaping (APIResult<T.ResponseType>) -> Void) -> DataRequest? {
        
        let appendingUrl = baseURL + req.endpoint
        let checkurl = appendingUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        guard let appendedUrl = checkurl else { return nil }
        
        let request = prepareRequest(for: appendedUrl, req: req)
        
        print("******** REQUEST URL ******** \n" + (request.url?.absoluteString ?? "") + "\n")
        
        return AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let failObject = try decoder.decode(ErrorEntity.self, from: data)
                        if let isSucces = failObject.success{
                            if !isSucces{
                                print("-------- REQUEST FAIL ----------")
                                completionHandler(APIResult.failObject(failObject))
                                break
                            }
                        }
                        let object = try decoder.decode(T.ResponseType.self, from: data)
                        print("-------- REQUEST SUCCES ----------")
                        completionHandler(APIResult.success(object))
                    } catch  let error {
                        print("-------- REQUEST FAIL ----------")
                        completionHandler(APIResult.failure(error))
                    }
                }
            //                }
            case .failure(let err):
                print("-------- REQUEST FAIL ----------")
                completionHandler(APIResult.failure(err))
            }
        }
    }
}

extension APIClient {
    
    private func prepareRequest<T: Requestable>(for urlString: String, req: T) -> URLRequest {
        
        var request : URLRequest? = nil
        
        if let req = parameterCheck(req: req) {
            request = req
        }
        
        request!.allHTTPHeaderFields = req.headers
        request!.httpMethod = req.method.rawValue
        
        return request!
    }
    
    private func parameterCheck<T: Requestable>(req: T) -> URLRequest?{
        if req.method == .get{
            return addParamtersForGet(req: req)
        } else if req.method == .post{
            return addParametersForPost(req: req)
        }
        return nil
    }
    
    private func addParamtersForGet<T: Requestable>(req: T) -> URLRequest{
        var filterQueryParameters: String = ""
        var request: URLRequest? = nil
        var urlString: String = baseURL + req.endpoint
        if req.parameter != nil || req.filterParameters != nil{
            if let param = req.parameter{ 
                urlString = String(format: urlString, param)
            }
            
            if let params = req.filterParameters{
                for key in params.keys{
                    filterQueryParameters += "&" + key + "=" + ((params[key] as? String) ?? "")
                }
            }
            
            let appliedUrl = (urlString + apiKey + filterQueryParameters).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            
            request = URLRequest(url: URL(string: appliedUrl!)!, cachePolicy: req.cachePolicy, timeoutInterval: req.timeout)
        } else {
            request = URLRequest(url: URL(string: urlString + apiKey)!, cachePolicy: req.cachePolicy, timeoutInterval: req.timeout)
        }
        return request!
    }
    
    private func addParametersForPost<T: Requestable>(req: T) -> URLRequest{
        var body: Data?
        let urlString: String = baseURL + req.endpoint
        var request: URLRequest = URLRequest(url: URL(string: urlString + apiKey)!, cachePolicy: req.cachePolicy, timeoutInterval: req.timeout)
        if let params = req.bodyParameters{
            do {
                body = try JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = body
            } catch {
                
            }
        }
        return request
    }
}
