//
//  UIAlertControllerExtension.swift
//  Atency
//
//  Created by macbook on 1/30/19.
//  Copyright © 2019 Pari . All rights reserved.
//

import Foundation
import UIKit
extension UIAlertController {

    func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
        let windowAlertPresentationController = WindowAlertPresentationController(alert: self)
        windowAlertPresentationController.present(animated: animated, completion: completion)
    }
}

class Alerts {
    static func ShowAlert(title: String, message: String, closeTitle: String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: closeTitle, style: .cancel, handler: nil))
        alertController.presentInOwnWindow(animated: true, completion: {
            print("completed")
        })
    }
    static func ShowAlert(title: String, message: String, closeTitle: String , controller : UIViewController ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: closeTitle, style: .cancel, handler: nil))
        controller.present(alertController, animated: true, completion: nil)
    }
}
class WindowAlertPresentationController: UIViewController {

    // MARK: - Properties

    private lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    private let alert: UIAlertController

    // MARK: - Initialization

    init(alert: UIAlertController) {

        self.alert = alert
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("This initializer is not supported")
    }

    // MARK: - Presentation

    func present(animated: Bool, completion: (() -> Void)?) {

        window?.rootViewController = self
        window?.windowLevel = UIWindow.Level.alert + 1
        window?.makeKeyAndVisible()
        present(alert, animated: animated, completion: completion)
    }

    // MARK: - Overrides

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {

        super.dismiss(animated: flag) {
            self.window = nil
            completion?()
        }
    }
}
