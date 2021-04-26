//
//  NetworkErrorHandler.swift
//  Telma
//
//  Created by kdeveloper1 on 1/20/20.
//  Copyright © 2020 kasra. All rights reserved.
//

import Foundation
class NetworkErrorHandler{
    static func HandleError(data : Data?){
        do{
            let json = try JSONSerialization.jsonObject(with: data ?? Data() , options: [])
            if let dic  = json as? [String : Any]{
                if let message = dic["Message"] as? String{
                    print(message)
                }
            }
        }catch{
            print("cant show message")
        }
    }
}
struct ErrorResponse : Codable{
    let message : String
    enum CodingKeys : String , CodingKey{
        case message = "Message"
    }
}
