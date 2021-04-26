//
//  CoordinatorProtocol.swift
//  Jouritm
//
//  Created by Amir Tutunchi on 5/23/20.
//  Copyright © 2020 jouritm. All rights reserved.
//


import UIKit
protocol Coordinator : AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    var navigationController: UINavigationController { get set }

    func start()
}
