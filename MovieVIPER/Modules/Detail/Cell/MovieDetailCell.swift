//
//  MovieDetailCell.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 1.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell, ReusableCell {
    
    // MARK: Views
    lazy var cellImage: UIImageView = {
        let imageView: UIImageView = UIImageView.newAutoLayout()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleTextLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.demibold.of(size: 20.0)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var titleDescLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.demibold.of(size: 14.0)
        label.numberOfLines = 0
        label.textColor = UIColor.gray
        return label
    }()
    
    lazy var starImage: UIImageView = {
        let imageView: UIImageView = UIImageView.newAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "starfilled.png")
        return imageView
    }()
    
    lazy var starVoteLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.regular.of(size: 14.0)
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var relaseDateLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.regular.of(size: 14.0)
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var imdbImage: UIImageView = {
        let imageView: UIImageView = UIImageView.newAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "imdb.jpg")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellImage)
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(titleDescLabel)
        contentView.addSubview(starImage)
        contentView.addSubview(starVoteLabel)
        contentView.addSubview(relaseDateLabel)
        contentView.addSubview(imdbImage)
        makeLayout()
    }
    
    public func loadCell(movieDetail: MovieDetail?){
        if let movie = movieDetail{
            if let imagePath = movie.posterPath{
                self.cellImage.setFromApi(imagePath, placeholder: nil, showActivityIndicator: true)
            }
            self.titleTextLabel.text = movie.title
            self.titleDescLabel.text = movie.overview
            self.starVoteLabel.text = movie.voteAverage?.description
            self.relaseDateLabel.text = movie.releaseDate
        }
    }
    
    func makeLayout() {
        cellImage.autoPinEdge(toSuperviewEdge: .top)
        cellImage.autoPinEdge(toSuperviewEdge: .left)
        cellImage.autoPinEdge(toSuperviewEdge: .right)
        cellImage.autoSetDimension(.height, toSize: 300.0)
        
        titleTextLabel.autoPinEdge(.top, to: .bottom, of: cellImage, withOffset: 20.0)
        titleTextLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
        titleTextLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        
        titleDescLabel.autoPinEdge(.top, to: .bottom, of: titleTextLabel, withOffset: 20.0)
        titleDescLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
        titleDescLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)
        titleDescLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 50.0)
        
        imdbImage.autoSetDimension(.height, toSize: 25)
        imdbImage.autoSetDimension(.width, toSize: 50)
        imdbImage.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        imdbImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        
        relaseDateLabel.autoPinEdge(.right, to: .left, of: imdbImage, withOffset: -10)
        relaseDateLabel.autoAlignAxis(.horizontal, toSameAxisOf: imdbImage)
        
        starVoteLabel.autoPinEdge(.right, to: .left, of: relaseDateLabel, withOffset: -10)
        starVoteLabel.autoAlignAxis(.horizontal, toSameAxisOf: imdbImage)
        
        starImage.autoPinEdge(.right, to: .left, of: starVoteLabel, withOffset: -5)
        starImage.autoAlignAxis(.horizontal, toSameAxisOf: imdbImage)
        starImage.autoSetDimension(.height, toSize: 20)
        starImage.autoSetDimension(.width, toSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
