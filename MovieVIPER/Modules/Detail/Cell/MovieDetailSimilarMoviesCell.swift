//
//  MovieDetailSimilarMoviesCell.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 1.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

protocol MovieDetailSimilarMoviesCellProtocol {
    func navigateMovieDetail(with movieID: Int)
}

class MovieDetailSimilarMoviesCell: UITableViewCell, ReusableCell{
    
    // MARK: Variables
    var movies: [Movie]?
    var delegate: MovieDetailSimilarMoviesCellProtocol?
    
    // MARK: Views
    lazy var cellCollectionView: UICollectionView = {
        var collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 15
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(MovieDetialSimilarMoviesCollectionCell.self)
        
        return collectionView
    }()
    
    lazy var titleTextLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.demibold.of(size: 16.0)
        label.text = "Benzer Filmler"
        label.numberOfLines = 1
        label.textColor = UIColor.gray
        return label
    }()
    
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellCollectionView)
        contentView.addSubview(titleTextLabel)
        makeLayout()
    }
    
    public func loadCell(movies: [Movie]?){
        if let movies = movies{
            self.movies = movies
            self.cellCollectionView.reloadData()
        } 
    }
    
    
    func makeLayout() {
        titleTextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
        titleTextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
        titleTextLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20.0)
        
        cellCollectionView.autoPinEdge(toSuperviewEdge: .left)
        cellCollectionView.autoPinEdge(toSuperviewEdge: .right)
        cellCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
        cellCollectionView.autoSetDimension(.height, toSize: 170.0)
        self.updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MovieDetailSimilarMoviesCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
}

extension MovieDetailSimilarMoviesCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieDetialSimilarMoviesCollectionCell = cellCollectionView.dequeueReusableCell(for: indexPath)
        cell.loadCell(movie: movies?[indexPath.row])
        return cell
    }
}


extension MovieDetailSimilarMoviesCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movies?[indexPath.row], let movieID = movie.id{
            delegate?.navigateMovieDetail(with: movieID)
        }
    }
}
