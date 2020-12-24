//
//  SearchViewController.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit
import PureLayout 


class SearchViewController: UIViewController{
    
    // MARK: - Properties
    var presenter: ViewToPresenterSearchProtocol?
    var search: UISearchController?
     
    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.register(SearchMoviePagerCell.self)
        tableView.register(SearchMovieCell.self)
        return tableView
    }()
    
    lazy var blackView: UIView = {
        let view = UIView.newAutoLayout()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var searchTableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView.newAutoLayout()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .gray
        tableView.bounces = false
        return tableView
    }()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.fetchMovie()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        search?.isActive = false
    }
}


extension SearchViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        view.addSubview(tableView)
        view.addSubview(blackView)
        view.addSubview(searchTableView) 
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.autoPinEdgesToSuperviewEdges()
        blackView.autoPinEdgesToSuperviewEdges()
        
        searchTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive=true
        searchTableView.autoPinEdge(toSuperviewEdge: .left)
        searchTableView.autoPinEdge(toSuperviewEdge: .right)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        search = UISearchController(searchResultsController: nil)
        search?.searchResultsUpdater = self
        search?.obscuresBackgroundDuringPresentation = false
        search?.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        
        title = "Movies"
    }
}


extension SearchViewController: PresenterToViewSearchProtocol {
    
    func onFetchNowPlayingSuccess() {
        self.tableView.reloadData()
    }
    
    func onFetchUpcomingPlayingSuccess() {
        self.tableView.reloadData()
    }
    
    func getSearchFilteredMovies(movies: [Movie]) {
        if movies.count > 0{
            blackView.isUserInteractionEnabled = true
            blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        } else {
            blackView.isUserInteractionEnabled = false
            blackView.backgroundColor = UIColor.clear
        }
        self.searchTableView.reloadData()
    }
}


// MARK: - UITableView Delegate & Data Source
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == searchTableView{
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchTableView{
            return presenter?.searchedNumberOfRowsInSection() ?? 0
        } else {
            if section == 0{
                return presenter?.cellNowPlayingMovie() == nil ? 0 : 1
            } else {
                return presenter?.numberOfRowsInSection() ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section: Int = indexPath.section
        
        if tableView == searchTableView{
            let cell = searchTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = presenter?.cellSearchedMovie(indexPath: indexPath)?.title
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            if section == 0 {
                let cell: SearchMoviePagerCell = self.tableView.dequeueReusableCell(for: indexPath)
                cell.loadCell(movies: presenter?.cellNowPlayingMovie())
                cell.delegate = self
                return cell
            } else  {
                let cell: SearchMovieCell = self.tableView.dequeueReusableCell(for: indexPath)
                cell.loadCell(movie: presenter?.cellUpcomingMovie(indexPath: indexPath))
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchTableView{
            return 44
        } else {
            if indexPath.section == 0{
                return 300
            } else {
                return 110
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchTableView{
            presenter?.navigateToDetailFromSearched(with: indexPath)
        } else {
            presenter?.navigateToDetail(with: indexPath)
        }
    }
}


extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.searchMovie(searchController: searchController)
    }
}


extension SearchViewController: SearchMoviePagerCellProtocol{
    func navigateMovieDetail(with movieID: Int) {
        presenter?.navigateToDetail(with: movieID) 
    }
}
