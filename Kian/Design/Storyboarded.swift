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
        let storyboard = UIStoryboard(name: String(id.dropLast(10)), bundle: Bundle.main)
        print(id , "id " , storyboard , " storyboard")
        return storyboard.instantiateViewController(withIdentifier: String(id.dropLast(10)) ) as! Self
    }
}
