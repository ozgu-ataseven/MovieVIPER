//
//  ImageHelper.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 29.10.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import Foundation 
import Kingfisher

extension UIImageView {
    
    static let fadeAnimation = KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))
    
    func set(_ url: String, placeholder: UIImage? = nil, showActivityIndicator: Bool = false) {
        self.kf.setImage(with: URL(string: url), placeholder: placeholder, options: [UIImageView.fadeAnimation])
    }
    
    func setFromApi(_ url: String, placeholder: UIImage? = nil, showActivityIndicator: Bool = false) {
        set(APIManager.shared.imageBaseUrl + url, placeholder: placeholder, showActivityIndicator: showActivityIndicator)
    }
}
