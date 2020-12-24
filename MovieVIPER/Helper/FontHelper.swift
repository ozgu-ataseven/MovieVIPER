//
//  FontHelper.swift
//  MovieVIPER
//
//  Created by Özgü Ataseven on 2.11.2020.
//  Copyright © 2020 Özgü Ataseven. All rights reserved.
//

import UIKit

protocol Font {
    func of(size: CGFloat) -> UIFont?
}

extension Font where Self: RawRepresentable, Self.RawValue == String {
    func of(size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }
}

enum Avenir: String, Font {
    case bold = "AvenirNext-Bold"
    case demibold = "AvenirNext-DemiBold"
    case heavy = "AvenirNext-Heavy"
    case medium = "AvenirNext-Medium"
    case regular = "AvenirNext-Regular"
}
