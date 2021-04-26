//
//  ServerDecoder.swift
//  Telma
//
//  Created by kdeveloper1 on 1/26/20.
//  Copyright © 2020 kasra. All rights reserved.
//

import Foundation
class ServerEncoder{
    private init(){
        
    }
    
    static var shared : JSONEncoder {
       let a = JSONEncoder()
        a.dateEncodingStrategy = .custom({ (date, encoder) in
            let stringDate = date.toString()
            var container = encoder.singleValueContainer()
            try! container.encode(stringDate)
        })
        return a
    }
}
