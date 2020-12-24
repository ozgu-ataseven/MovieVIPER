//
//  SearchMovieCell.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 31.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

class SearchMovieCell: UITableViewCell, ReusableCell {
    
    // MARK: Variables
    private var movie: Movie?
    
    // MARK: Views
    lazy var titleTextLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.demibold.of(size: 18.0)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var titleDescLabel: UILabel = {
        let label: UILabel = UILabel.newAutoLayout()
        label.font = Avenir.medium.of(size: 14.0)
        label.numberOfLines = 2
        label.textColor = UIColor.gray
        return label
    }()
    
    lazy var cellImage: UIImageView = {
        let imageView: UIImageView = UIImageView.newAutoLayout() 
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(titleDescLabel)
        contentView.addSubview(cellImage)
        accessoryType = .disclosureIndicator
        makeLayout()
    }
    
    public func loadCell(movie: Movie?){
        if let imagePath = movie?.posterPath{
            self.cellImage.setFromApi(imagePath, placeholder: nil, showActivityIndicator: true)
        }
        self.titleTextLabel.text = movie?.title
        self.titleDescLabel.text = movie?.overview
    }
    
    func makeLayout() {
        cellImage.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
        cellImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15.0)
        cellImage.autoPinEdge(toSuperviewEdge: .top, withInset: 15.0)
        cellImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        cellImage.autoSetDimension(.width, toSize: 80.0)
        
        titleTextLabel.autoPinEdge(.left, to: .right, of: cellImage, withOffset: 15.0)
        titleTextLabel.autoPinEdge(toSuperviewEdge: .right,withInset: 30.0)
        titleTextLabel.autoPinEdge(.top, to: .top, of: cellImage, withOffset: 10)
        
        titleDescLabel.autoPinEdge(.left, to: .right, of: cellImage, withOffset: 15.0)
        titleDescLabel.autoPinEdge(toSuperviewEdge: .right,withInset: 30.0)
        titleDescLabel.autoPinEdge(.top, to: .bottom, of: titleTextLabel)
        
        self.updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
