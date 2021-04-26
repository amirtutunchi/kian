//
//  ShadowView.swift
//  Atency
//
//  Created by Parinaz Khatami on 12/12/18.
//  Copyright © 2018 Pari . All rights reserved.
//

import UIKit
extension UIView {
    func ShadowView() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2641802226)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
  
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.shadowRadius = 5
        clipsToBounds = true
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    // OUTPUT 2
    func dropShadow(color: UIColor,
                    opacity: Float,
                    offSet: CGSize,
                    radius: CGFloat,
                    scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }
}
