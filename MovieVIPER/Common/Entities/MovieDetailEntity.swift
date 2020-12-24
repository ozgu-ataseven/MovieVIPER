//
//  MovieDetailEntity.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 1.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import Foundation

// MARK: - MovieDetail
final class MovieDetailRequest: Requestable {
    
    typealias ResponseType = MovieDetail
    
    init(param: Int) {
        self.parameter = String(param)
    }
    
    var endpoint: String {
        return Endpoints.MOVIE_DETAIL
    }
    
    
    var method: APIClient.Method {
        return .get
    }
    
    var parameter: String?
    var bodyParameters: [String : Any]?
    var filterParameters: [String : Any]?
    
    var headers: [String : String]? {
        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 20.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
    
}


final class SimilarMovieRequest: Requestable {
    
    typealias ResponseType = MovieListEntity
    
    init(param: Int) { 
        self.parameter = String(param)
    }
    
    var endpoint: String {
        return Endpoints.MOVIE_DETAIL_SIMILAR
    }
    
    var method: APIClient.Method {
        return .get
    }
    
    var parameter: String?
    var bodyParameters: [String : Any]?
    var filterParameters: [String : Any]?
    
    var headers: [String : String]? {
        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 20.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}


class MovieDetail: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdbID
        case originalLanguage = "originalLanguage"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount
    }
    
}

// MARK: - Genre
class Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
class ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
class ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1
        case name
    }
}

// MARK: - SpokenLanguage
class SpokenLanguage: Codable {
    let iso639_1: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso639_1
        case name
    }
}
