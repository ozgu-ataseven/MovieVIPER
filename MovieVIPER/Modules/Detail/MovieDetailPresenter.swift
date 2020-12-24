//
//  MovieDetailPresenter.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 1.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import Foundation
import SVProgressHUD

class MovieDetailPresenter: ViewToPresenterMovieDetailProtocol {
    
    var view: PresenterToViewMovieDetailProtocol?
    var interactor: PresenterToInteractorMovieDetailProtocol?
    var router: PresenterToRouterMovieDetailProtocol?
    
    var movieDetail: MovieDetail?
    var similarMovies: [Movie]?
    
    func getMovieDetailModel() -> MovieDetail? {
        guard let movieDetail = self.movieDetail else {
            return nil
        } 
        return movieDetail
    }
    
    func getSimilarMovies() -> [Movie]? {
        guard let movies = self.similarMovies else {
            return nil
        }
        return movies
    }
    
    func fetchMovieDetail(movieID: Int) {
        SVProgressHUD.show()
        interactor?.loadMovieDetail(movieID: movieID)
        interactor?.loadSimilarMovieDetail(movieID: movieID)
    }
    
    func navigateToDetail(with movieId: Int) {
        self.router?.pushToMovieDetail(on: self.view!, movieID: movieId)
    }
}

// MARK: - Outputs to view
extension MovieDetailPresenter: InteractorToPresenterMovieDetailProtocol {
    func getFethedMovieDetail(movieDetail: MovieDetail) {
        SVProgressHUD.dismiss()
        self.movieDetail = movieDetail
        self.view?.onFetchMovieDetailSucces()
    }
    
    func getFethedSimilarMovies(movies: [Movie]) {
        SVProgressHUD.dismiss()
        self.similarMovies = movies
        self.view?.onFetchSimilarMoviesSucces()
    } 
}

