//
//  Requestable.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import Foundation


protocol Requestable {
    
    associatedtype ResponseType: Codable
    
    var endpoint: String { get }
    var method: APIClient.Method { get }
    var parameter: String? { get set }
    var headers: [String: String]? { get }
    var bodyParameters: [String: Any]? { get set}
    var filterParameters: [String: Any]? { get set}
    
    // We did not have to add these variables (timeout and cachePolicy) to protocol but i like to have control while coding to make codebase scalable
    var timeout : TimeInterval { get }
    var cachePolicy : NSURLRequest.CachePolicy { get }
}

extension Requestable {
    
    var defaultJSONHeader : [String: String] {
        return ["accept" : "application/json" ,"Content-Type" : "application/json"]
    }
    
    var authorizationHeader: [String: String] {
        return ["accept": "application/json", "Content-Type" : "application/json", "Authorization": "Bearer " + ""]
    }
}
