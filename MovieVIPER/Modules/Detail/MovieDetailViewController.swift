//
//  MovieDetailViewController.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 1.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController{
    
    var presenter: ViewToPresenterMovieDetailProtocol?
    var movieID: Int?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.register(MovieDetailCell.self)
        tableView.register(MovieDetailSimilarMoviesCell.self)
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let movieID = movieID{
            presenter?.fetchMovieDetail(movieID: movieID)
        } 
    }
}


extension MovieDetailViewController {
    func setupUI() { 
        title = "Movie Detail"
        overrideUserInterfaceStyle = .light
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.autoPinEdgesToSuperviewEdges()
    }
}

// MARK: - UITableView Delegate & Data Source
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else {
            if presenter?.getSimilarMovies()?.count ?? 0 > 0{
                return 1
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        if section == 0{
            let cell: MovieDetailCell = self.tableView.dequeueReusableCell(for: indexPath)
            cell.loadCell(movieDetail: presenter?.getMovieDetailModel())
            return cell
        } else {
            let cell: MovieDetailSimilarMoviesCell = self.tableView.dequeueReusableCell(for: indexPath)
            cell.loadCell(movies: presenter?.getSimilarMovies())
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        if section == 0{
            return UITableView.automaticDimension
        } else {
            return 220
        }
    }
}


extension MovieDetailViewController: PresenterToViewMovieDetailProtocol {
    func onFetchMovieDetailSucces() {
        self.tableView.reloadData()
    }
    
    func onFetchSimilarMoviesSucces() {
        self.tableView.reloadData()
    } 
}


extension MovieDetailViewController: MovieDetailSimilarMoviesCellProtocol{
    func navigateMovieDetail(with movieID: Int) {
        presenter?.navigateToDetail(with: movieID)
    }
}
