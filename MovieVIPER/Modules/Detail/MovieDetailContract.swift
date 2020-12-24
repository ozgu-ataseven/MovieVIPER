//
//  MovieDetailContract.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 1.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMovieDetailProtocol: class {
    
    var view: PresenterToViewMovieDetailProtocol? { get set }
    var interactor: PresenterToInteractorMovieDetailProtocol? { get set }
    var router: PresenterToRouterMovieDetailProtocol? { get set }
    
    var movieDetail: MovieDetail? { get set }
    var similarMovies: [Movie]? { get set }
    
    func fetchMovieDetail(movieID: Int)
    
    func getMovieDetailModel() -> MovieDetail?
    func getSimilarMovies() -> [Movie]?
    
    func navigateToDetail(with movieId: Int)
}


/// MARK: View Output (Presenter -> View)
protocol PresenterToViewMovieDetailProtocol: class {
    func onFetchMovieDetailSucces()
    func onFetchSimilarMoviesSucces()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMovieDetailProtocol: class {
    var presenter: InteractorToPresenterMovieDetailProtocol? { get set }
    
    func loadMovieDetail(movieID: Int)
    func loadSimilarMovieDetail(movieID: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMovieDetailProtocol: class {
    func getFethedMovieDetail(movieDetail: MovieDetail)
    func getFethedSimilarMovies(movies: [Movie])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMovieDetailProtocol: class {
    static func createModule(movieID: Int) -> UIViewController
    func pushToMovieDetail(on view: PresenterToViewMovieDetailProtocol, movieID: Int)
}
