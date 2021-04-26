//
//  MainCoordinator.swift
//  Jouritm
//
//  Created by Amir Tutunchi on 5/23/20.
//  Copyright © 2020 jouritm. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject , Coordinator  , UINavigationControllerDelegate{
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
   
    func hideNavigationBar(){
        navigationController.isNavigationBarHidden = true
    }
    func showNavigationBar(){
        navigationController.isNavigationBarHidden = false
    }
   
   
    func start() {
        navigationController.setNavigationBarHidden(true, animated: true)
        let homeController = HomeController.instantiate()
        homeController.coordinator = self
        navigationController.pushViewController(homeController, animated: true)
    }
   
}
