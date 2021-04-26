//
//  ContactHeaderTableView.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/26/21.
//

import UIKit
class ContactHeaderTableView : UIView{
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ContactsHeaderTableView", owner: self, options: nil)
        contentView.fixInView(self)
    }
}
