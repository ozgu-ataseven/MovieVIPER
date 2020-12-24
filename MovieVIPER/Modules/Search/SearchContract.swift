//
//  SearchContract.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchProtocol: class { 
    
    var view: PresenterToViewSearchProtocol? { get set }
    var interactor: PresenterToInteractorSearchProtocol? { get set }
    var router: PresenterToRouterSearchProtocol? { get set }
    
    func fetchMovie()
    func searchMovie(searchController: UISearchController)
    
    var nowPlayingMovies: [Movie]? { get set }
    var upcomingMovies: [Movie]? { get set }
    
    func numberOfRowsInSection() -> Int
    func cellNowPlayingMovie() -> [Movie]?
    func cellUpcomingMovie(indexPath: IndexPath) -> Movie?
    func cellSearchedMovie(indexPath: IndexPath) -> Movie? 
    func searchedNumberOfRowsInSection() -> Int
    
    func navigateToDetail(with indexPath: IndexPath)
    func navigateToDetailFromSearched(with indexPath: IndexPath)
    func navigateToDetail(with movieId: Int)
}


/// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchProtocol: class {
    func onFetchNowPlayingSuccess()
    func onFetchUpcomingPlayingSuccess() 
    func getSearchFilteredMovies(movies: [Movie])
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchProtocol: class {
    var presenter: InteractorToPresenterSearchProtocol? { get set }
    func loadNowPlayingMovies()
    func loadUpcomingMovies()
    func loadMovieWith(searchController: UISearchController)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSearchProtocol: class {
    func getFethedNowPlayingMovies(movies: [Movie])
    func getFethedUpcomingPlayingMovies(movies: [Movie])
    func getSearchedMovies(movies: [Movie]) 
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSearchProtocol: class { 
    static func createModule() -> UINavigationController
    func pushToMovieDetail(on view: PresenterToViewSearchProtocol, movieID: Int)
}

