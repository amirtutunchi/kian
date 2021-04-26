//
//  ImageDownloader.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/26/21.
//

import Foundation
import UIKit
class ImageDownloader{
    static let sharedInstance = ImageDownloader()
    let imageCache = NSCache<AnyObject , AnyObject>()
    private init() {
    }
    func downloadImage(urlString : String , completion : @escaping ((UIImage?) -> Void)) {
        let url = URL.init(string: urlString)
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            completion(imageFromCache)
            return
        }
        if let url = url{
            ServiceLayer.sharedInstance.getImage(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                let newImage = UIImage(data: data)
                if let newImage = newImage{
                    self.imageCache.setObject(newImage, forKey: urlString as AnyObject)
                    completion(newImage)
                }else{
                    completion(nil)
                }
            }
        }else{
            completion(nil)
        }
        
    }
}
