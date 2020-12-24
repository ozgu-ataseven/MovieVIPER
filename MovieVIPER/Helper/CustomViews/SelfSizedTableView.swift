//
//  SelfSizedTableView.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 3.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height {
        didSet { self.invalidateIntrinsicContentSize() }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: self.bounds.width, height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
}
