//
//  PresentModel.swift
//  Telma
//
//  Created by Amir Tutunchi on 11/30/19.
//  Copyright © 2019 kasra. All rights reserved.
//

import Foundation
import UIKit
class PresentSubController{
    static func presentModally(controller : UIViewController,storyboardId: String ,storyboardName: String , completion: ((_ targetController : UIViewController) -> Void)? = nil){
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName , bundle: nil)
        let popupVC = storyboard.instantiateViewController(withIdentifier: storyboardId )
        popupVC.modalPresentationStyle = .popover
        popupVC.preferredContentSize = CGSize(width: 300, height: 300)
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
        if let completion = completion{
            completion(popupVC)
        }
        controller.present(popupVC, animated: true, completion: nil)
    }
    
}
