//
//  Storyboarded.swift
//  CoordinatorSample
//
//  Created by Amir Tutunchi on 9/15/19.
//  Copyright © 2019 jaycom. All rights reserved.
//

import Foundation
import UIKit
protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self : UIViewController{
    static func instantiate() -> Self{
        let id = String(describing: self)
        /// next line of code is kind of standard that i have ... every controller in the naming should end with word controller i know it sounds wired :D
        let storyboard = UIStoryboard(name: String(id.dropLast(10)), bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: String(id.dropLast(10)) ) as! Self
    }
}
