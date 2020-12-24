//
//  MovieDetialSimilarMoviesCollectionCell.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 1.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

class MovieDetialSimilarMoviesCollectionCell: UICollectionViewCell, ReusableCell{
    
    // MARK: Views
    lazy var cellImage: UIImageView = {
        let imageView: UIImageView = UIImageView.newAutoLayout() 
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    lazy var titleTextLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.demibold.of(size: 12.0)
        label.numberOfLines = 2
        label.textColor = UIColor.gray
        return label
    }()
    
    lazy var yearTextLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.demibold.of(size: 12.0)
        label.numberOfLines = 1
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImage)
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(yearTextLabel)
        makeLayout()
    }
    
    public func loadCell(movie: Movie?){
        if let movie = movie{
            if let imagePath = movie.posterPath{
                self.cellImage.setFromApi(imagePath, placeholder: nil, showActivityIndicator: true)
            }
            titleTextLabel.text = movie.title
            yearTextLabel.text = String(format: "(%@)", (movie.releaseDate ?? ""))
        }
    }
    
    
    func makeLayout() {
        cellImage.autoSetDimension(.height, toSize: 110)
        cellImage.autoSetDimension(.width, toSize: 110)
        cellImage.autoPinEdge(toSuperviewEdge: .top) 
        
        titleTextLabel.autoPinEdge(.top, to: .bottom, of: cellImage, withOffset: 5)
        titleTextLabel.autoPinEdge(.left, to: .left, of: cellImage)
        titleTextLabel.autoPinEdge(.right, to: .right, of: cellImage)
        
        yearTextLabel.autoPinEdge(.top, to: .bottom, of: titleTextLabel)
        yearTextLabel.autoPinEdge(.left, to: .left, of: cellImage)
        yearTextLabel.autoPinEdge(.right, to: .right, of: cellImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
}
