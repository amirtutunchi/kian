//
//  AppDelegate.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/25/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navController = UINavigationController.init()
        navController.isNavigationBarHidden = true
        coordinator = MainCoordinator.init(navigationController: navController)
        coordinator?.start()
        
        // create a basic uiwindow and activate it here
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }



}

