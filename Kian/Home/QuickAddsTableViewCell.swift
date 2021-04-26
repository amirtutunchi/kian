//
//  QuickAddsTableViewCell.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/26/21.
//

import UIKit

class QuickAddsTableViewCell: UITableViewCell {
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var centerView: UIView!
    static let nib = "QuickAddsTableViewCell"
    
    /// this index path is just for demo purpose and for showing cached image dont take it siriously :D
    var indexPath : IndexPath?
    var model : ContactModel?{
        didSet{
            guard let model = model else { return  }
            nameLbl.text = model.fullName
            DispatchQueue.global().async {
                ///Fix : here in url string we should use model.avatar but it has some problem so i decided use another endpoint for demo purpeses
                ImageDownloader.sharedInstance.downloadImage(urlString:"https://picsum.photos/200?random=\(self.indexPath?.row ?? 0)") { (image) in
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBtn.layer.cornerRadius = 20
    }

   

}
