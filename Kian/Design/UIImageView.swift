//
//  UIImageView.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/26/21.
//

import Foundation
import UIKit
extension UIImageView {
    
    func changeColor(color : UIColor){
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
