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
    var seperatorView : UIView?
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
        drawSeperator()
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layer.mask = nil
        avatarImageView.image = nil
    }
    func drawSeperator(){
        let view = UIView.init(frame: CGRect.init(x: 0, y: centerView.bounds.height - 1 , width: centerView.bounds.width, height: 1))
        view.backgroundColor = #colorLiteral(red: 0.8501740098, green: 0.8791047931, blue: 0.9002857208, alpha: 1)
        seperatorView = view
        centerView.addSubview(view)
    }
    func clearSeperator(){
        if let view = seperatorView{
            view.removeFromSuperview()
        }
    }

}
