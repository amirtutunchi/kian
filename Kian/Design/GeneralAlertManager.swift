//
//  GeneralAlertManager.swift
//  Telma
//
//  Created by kdeveloper1 on 1/20/20.
//  Copyright © 2020 kasra. All rights reserved.
//

import Foundation
import UIKit
class GenearalAlertManager{
    static func showAlert(title : String , message : String){
        DispatchQueue.main.async {
              let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //        //...
            alertController.addAction(UIAlertAction.init(title: "close", style: .default, handler: { (r) in
                
            }))
            UIApplication.topMostViewController?.present(alertController, animated: true, completion: nil)
        }
      
    }
}

extension UIApplication {
    /// The top most view controller
    static var topMostViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.visibleViewController
    }
}

extension UIViewController {
    /// The visible view controller from a given view controller
    var visibleViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.visibleViewController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleViewController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController
        } else {
            return self
        }
    }
}
