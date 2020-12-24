//
//  APIRequestHelper.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 4.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

open class APIRequestHelper {
    static let sharedInstance = APIRequestHelper()
    
    private init(){}
    
    func performRequest<T: Requestable>(req: T, completionHandler: @escaping (T.ResponseType) -> ()){
        APIClient.shared.request(req: req) { (response) in
            switch response{
            case .success(let model):
                completionHandler(model)
            case .failure(_):
                 AlertHelper.alert("Error", message: "Some Error Occured", buttonTitle: "OK")
            case .failObject(let obj):
                if let failObj = obj, let failMessage = failObj.statusMessage{
                    AlertHelper.alert("Error", message: failMessage, buttonTitle: "OK")
                }
            }
        }
    }
}
