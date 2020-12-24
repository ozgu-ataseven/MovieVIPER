//
//  SearchPresenter.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchPresenter: ViewToPresenterSearchProtocol {
    
    
    // MARK: Properties
    weak var view: PresenterToViewSearchProtocol?
    var interactor: PresenterToInteractorSearchProtocol?
    var router: PresenterToRouterSearchProtocol?

    var nowPlayingMovies: [Movie]?
    var upcomingMovies: [Movie]?
    var filteredMovies: [Movie]?
    
    func fetchMovie() {
        SVProgressHUD.show()
        interactor?.loadNowPlayingMovies()
        interactor?.loadUpcomingMovies()
    }
    
    // MARK: NowPlayingCollectionView
    func cellNowPlayingMovie() -> [Movie]? {
        guard let movies = self.nowPlayingMovies else {
            return nil
        }
        
        return movies
    }
    
    // MARK: UpcomingTable
    func cellUpcomingMovie(indexPath: IndexPath) -> Movie? {
        guard let movies = self.upcomingMovies else {
            return nil
        }
        
        return movies[indexPath.row]
    }
    
    func numberOfRowsInSection() -> Int {
        guard let movies = self.upcomingMovies else {
            return 0
        }
        
        return movies.count
    }
    
    // MARK: SearchTable
    func searchMovie(searchController: UISearchController) {
        interactor?.loadMovieWith(searchController: searchController)
    }
    
    
    func cellSearchedMovie(indexPath: IndexPath) -> Movie? {
        guard let movies = self.filteredMovies else {
            return nil
        }
        
        return movies[indexPath.row]
    }
    
    
    func searchedNumberOfRowsInSection() -> Int {
        guard let movies = self.filteredMovies else {
            return 0
        }
        return movies.count
    }
    
    // MARK: Navigation
    func navigateToDetailFromSearched(with indexPath: IndexPath) {
        if let movieId = self.filteredMovies?[indexPath.row].id{
            self.router?.pushToMovieDetail(on: self.view!, movieID: movieId)
        }
    }
    
    
    func navigateToDetail(with indexPath: IndexPath) {
        if let movieId = self.upcomingMovies?[indexPath.row].id{
            self.router?.pushToMovieDetail(on: self.view!, movieID: movieId)
        }
    }
    
    func navigateToDetail(with movieId: Int) {
        self.router?.pushToMovieDetail(on: self.view!, movieID: movieId)
    }
}

// MARK: - Outputs to view
extension SearchPresenter: InteractorToPresenterSearchProtocol {
    func getFethedNowPlayingMovies(movies: [Movie]) {
        SVProgressHUD.dismiss()
        self.nowPlayingMovies = movies
        self.view?.onFetchNowPlayingSuccess()
    }
    
    func getFethedUpcomingPlayingMovies(movies: [Movie]) {
        SVProgressHUD.dismiss()
        self.upcomingMovies = movies
        self.view?.onFetchUpcomingPlayingSuccess()
    }
    
    func getSearchedMovies(movies: [Movie]) {
        self.filteredMovies = movies
        view?.getSearchFilteredMovies(movies: movies)
    }
}

