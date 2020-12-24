//
//  ApiManager.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import Foundation 

class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "https://api.themoviedb.org/"
    }()
    
    lazy var apiKey: String = {
        return "?api_key=fae0e5cfd0f72bb1e8fbae9ea88e8057"
    }()
    
    lazy var imageBaseUrl: String = {
        return "https://image.tmdb.org/t/p/w500/"
    }()
}
