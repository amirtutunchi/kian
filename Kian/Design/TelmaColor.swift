//
//  TelmaColor.swift
//  Telma
//
//  Created by Parinaz Khatami on 10/6/19.
//  Copyright © 2019 kasra. All rights reserved.
//

import UIKit
import CoreLocation

//Most Common Colors in App

enum AssetsColor: String {
    case MagentaPallete
    case OrangePallete
    case PurplePallete
    case SunnyPallete
    case YellowPallete
    case WhitePallete
    case LightGrayPallete
    case GrayBackgroundPallete
    case DarkGrayPallete
    case GrayPallete
    case IndigoPallete
    case MediumGrayPallete
}

extension UIColor {
    
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
