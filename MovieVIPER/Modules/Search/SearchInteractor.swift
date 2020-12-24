//
//  SearchInteractor.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

class SearchInteractor: PresenterToInteractorSearchProtocol {
    
    var presenter: InteractorToPresenterSearchProtocol?
    
    func loadNowPlayingMovies() {
        APIRequestHelper.sharedInstance.performRequest(req: NowPlayingRequest()) { [weak self] (responseModel) in
            guard let movies = responseModel.results else { return }
            self?.presenter?.getFethedNowPlayingMovies(movies: movies)
        }
    }
    
    func loadUpcomingMovies() {
        APIRequestHelper.sharedInstance.performRequest(req: UpcomingRequest()) { [weak self] (responseModel) in
            guard let movies = responseModel.results else { return }
            self?.presenter?.getFethedUpcomingPlayingMovies(movies: movies)
        }
    }
    
    
    func loadMovieWith(searchController: UISearchController) {
        let keyword = searchController.searchBar.text ?? ""
        
        if searchController.isActive{
            if keyword.count >= 2{
                APIRequestHelper.sharedInstance.performRequest(req: SearchMovieRequest(filterParams: ["query":keyword])) { [weak self] (responseModel) in
                    guard let movies = responseModel.results else { return }
                    self?.presenter?.getSearchedMovies(movies: movies)
                }
            }
        } else { 
            self.presenter?.getSearchedMovies(movies: [])
        }
    }
}
