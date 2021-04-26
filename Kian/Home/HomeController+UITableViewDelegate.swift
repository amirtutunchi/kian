//
//  HomeController+UITableViewDelegate.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/26/21.
//

import Foundation
import UIKit
extension HomeController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return quickAddArray.count
        }else{
            return restOfConatactsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: QuickAddsTableViewCell.nib, for: indexPath) as! QuickAddsTableViewCell
            cell.indexPath = indexPath
            cell.model = quickAddArray[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.nib, for: indexPath) as! ContactsTableViewCell
            cell.indexPath = indexPath
            cell.model = restOfConatactsArray[indexPath.row]
            return cell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius : CGFloat = 12.0
        if indexPath.row == 0 {
            if let cell = cell as? QuickAddsTableViewCell{
                if cell.model?.id == quickAddArray.first?.id{
                    cell.centerView.roundCorners(corners: [.topLeft , .topRight], radius: cornerRadius)
                }
            }
            if let cell = cell as? ContactsTableViewCell{
                if cell.model?.id == restOfConatactsArray.first?.id{
                    cell.centerView.roundCorners(corners: [.topLeft , .topRight], radius: cornerRadius)
                }
            }
        }else{
            if indexPath.section == 0 {
                if indexPath.row == quickAddArray.count - 1{
                    if let cell = cell as? QuickAddsTableViewCell{
                        cell.centerView.roundCorners(corners: [.bottomLeft , .bottomRight ], radius: cornerRadius)
                        cell.clearSeperator()
                    }
                }
            }else{
                if indexPath.row == restOfConatactsArray.count - 1{
                    if let cell = cell as? ContactsTableViewCell{
                        cell.centerView.roundCorners(corners: [.bottomLeft , .bottomRight ], radius: cornerRadius)
                        cell.clearSeperator()
                    }
                }

            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ContactHeaderTableView()
        if section == 0 {
            header.nameLbl.text = "Quick Adds"
        }else{
            header.nameLbl.text = "In Your Contacts"
        }
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
