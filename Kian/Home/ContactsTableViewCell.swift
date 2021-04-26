//
//  ContanctsTableViewCell.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/26/21.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    static let nib = "ContactsTableViewCell"
    
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var centerView: UIView!
    /// this index path is just for demo purpose and for showing cached image dont take it siriously :D
    var indexPath : IndexPath?
    
    var model : ContactModel?{
        didSet{
            guard let model = model else { return  }
            nameLbl.text = model.fullName
            mobileLbl.text = model.phoneNumber
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
        addBtn.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        addBtn.imageView!.changeColor(color: #colorLiteral(red: 0.7450664043, green: 0.7692024708, blue: 0.7861205935, alpha: 1))
        
        addBtn.layer.borderWidth = 1
        addBtn.layer.borderColor = #colorLiteral(red: 0.7450664043, green: 0.7692024708, blue: 0.7861205935, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
