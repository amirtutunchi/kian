//
//  HomeController.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/25/21.
//

import UIKit

class HomeController: UIViewController , Storyboarded {
    weak var coordinator : MainCoordinator?
    var contactsArray = [ContactModel](){
        didSet{
            quickAddArray = Array(contactsArray.prefix(5))
            restOfConatactsArray = contactsArray.filter { oldItem in !quickAddArray.contains(where: { (item) -> Bool in
                if item.id == oldItem.id{
                    return true
                }
                return false
            }
            )}
        }
    }
    var quickAddArray = [ContactModel](){
        didSet{
            contactsTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    var restOfConatactsArray = [ContactModel](){
        didSet{
            contactsTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var centerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    func setupUI(){
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.tableFooterView = UIView.init()
        centerView.layer.cornerRadius = 12
        centerView.clipsToBounds = true
    }
    func fetchData(){
        self.startLoading()
        ContactModel.GetContacts { (contacts) in
            self.stopLoading()
            self.contactsArray = contacts ?? []
        }
    }
}

