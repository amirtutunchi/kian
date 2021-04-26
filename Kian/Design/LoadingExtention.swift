//
//  LoadingExtention.swift
//  PastilIOS
//
//  Created by macbook on 1/15/1397 AP.
//  Copyright © 1397 AP macbook. All rights reserved.
//

import Foundation
import UIKit

class SharedActivityIndicator {
    private init() {
    }
     static let sharedInstance: UIActivityIndicatorView = {
        let indicator1 = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
           indicator1.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
           indicator1.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           indicator1.hidesWhenStopped = true
           return indicator1
       }()
}

extension UIViewController {
    var indicator: UIActivityIndicatorView {
            SharedActivityIndicator.sharedInstance.center = view.center
            self.view.addSubview(SharedActivityIndicator.sharedInstance)
        self.view.bringSubviewToFront(SharedActivityIndicator.sharedInstance)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            return SharedActivityIndicator.sharedInstance
    }
    func startLoading() {
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = #colorLiteral(red: 0.2384076209, green: 0.2384076209, blue: 0.2384076209, alpha: 0.5)
        container.tag = 13
        self.view.addSubview(container)
        indicator.startAnimating()
    }
    func stopLoading () {
        for UiItem in self.view.subviews where UiItem.tag == 13 {
                UiItem.removeFromSuperview()
        }
        if SharedActivityIndicator.sharedInstance.isAnimating {
            SharedActivityIndicator.sharedInstance.stopAnimating()
            SharedActivityIndicator.sharedInstance.removeFromSuperview()
        }
    }
}
