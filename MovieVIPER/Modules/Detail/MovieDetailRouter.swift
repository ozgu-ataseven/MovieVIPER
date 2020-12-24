//
//  MovieDetailRouter.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 1.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit


class MovieDetailRouter: PresenterToRouterMovieDetailProtocol { 
    // MARK: Static methods
    static func createModule(movieID: Int) -> UIViewController {
        let viewController = MovieDetailViewController()
        
        let presenter: ViewToPresenterMovieDetailProtocol & InteractorToPresenterMovieDetailProtocol = MovieDetailPresenter()
        
        viewController.movieID = movieID
        viewController.presenter = presenter
        viewController.presenter?.router = MovieDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MovieDetailInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Navigation
    func pushToMovieDetail(on view: PresenterToViewMovieDetailProtocol, movieID: Int) {
        let movieDetailViewController = MovieDetailRouter.createModule(movieID: movieID)
            
        let viewController = view as! MovieDetailViewController
        viewController.navigationController?
            .pushViewController(movieDetailViewController, animated: true)
    }
}
