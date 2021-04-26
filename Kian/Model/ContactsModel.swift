//
//  ContactsModel.swift
//  Kian
//
//  Created by Amir Tutunchi on 4/26/21.
//

import Foundation
struct ContactModel : Codable{
    let id : String
    let createdAt : Date
    let name : String
    let avatar : String
    let family : String
    let phoneNumber : String
    
    var fullName : String {
        return name + " " + family
    }
    
    static func GetContacts(completion : @escaping (([ContactModel]?) -> Void)){
        ServiceLayer.sharedInstance.request(router: .getContacts) {(result :Result<[ContactModel], Error>)  in
            switch result{
            case .success(let contacts):
                completion(contacts)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
    
}
