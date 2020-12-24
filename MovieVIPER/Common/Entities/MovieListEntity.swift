//
//  MovieListEntity.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//
import Foundation

// MARK: - MoviesEntity
final class NowPlayingRequest: Requestable {
    
    typealias ResponseType = MovieListEntity 
    
    var endpoint: String {
        return Endpoints.NOW_PLAYING
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


final class UpcomingRequest: Requestable {
    
    
    
    typealias ResponseType = MovieListEntity
    
    var endpoint: String {
        return Endpoints.UPCOMING
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


final class SearchMovieRequest: Requestable {
    
    typealias ResponseType = MovieListEntity
    
    init(filterParams: [String: Any]) {
        self.filterParameters = filterParams
    }
    
    var endpoint: String {
        return Endpoints.MOVIE_SEARCH
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


class MovieListEntity: Codable { 
    
    let results: [Movie]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults
        case dates
        case totalPages
    }
    
    init(results: [Movie]?, page: Int?, totalResults: Int?, dates: Dates?, totalPages: Int?) {
        self.results = results
        self.page = page
        self.totalResults = totalResults
        self.dates = dates
        self.totalPages = totalPages
    }
}

class Dates: Codable {
    let maximum, minimum: String?
    
    init(maximum: String?, minimum: String?) {
        self.maximum = maximum
        self.minimum = minimum
    }
}

class Movie: Codable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
}
