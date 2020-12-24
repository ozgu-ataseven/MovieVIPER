//
//  SearchRouter.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

class SearchRouter: PresenterToRouterSearchProtocol {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        let viewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterSearchProtocol & InteractorToPresenterSearchProtocol = SearchPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SearchRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SearchInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    
    // MARK: - Navigation
    func pushToMovieDetail(on view: PresenterToViewSearchProtocol, movieID: Int) {
        let movieDetailViewController = MovieDetailRouter.createModule(movieID: movieID)
        
        let viewController = view as! SearchViewController
        viewController.navigationController?
            .pushViewController(movieDetailViewController, animated: true)
    }
}

