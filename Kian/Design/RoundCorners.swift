//
//  RoundCorners.swift
//  Telma
//
//  Created by Amir Tutunchi on 11/3/19.
//  Copyright © 2019 kasra. All rights reserved.
//

import UIKit
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), alpha: 0.05, x: 0, y: 4, blur: 0, spread: 20)
        layer.mask = mask
    }
}
