//
//  Router.swift
//  ManualNetworking
//
//  Created by Amir Tutunchi on 9/29/19.
//  Copyright © 2019 kasra. All rights reserved.
//

import Foundation
enum Router {
    case getContacts
   
    var scheme: String {
        return "https"
    }

    var host: String {
        return "60859fb1d14a8700175780be.mockapi.io"
    }
    
    var port : Int?{
        return nil
    }
    
    var path: String {
        switch self {
       
        case .getContacts:
            return "/api/users"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getContacts:
            return []
        }
    }
    
    var bodyParams : Data? {
        switch self {
        case .getContacts:
            return nil
        }
        
    }

    var method: String {
        switch self {
        case .getContacts:
            return "GET"
        }
    }
    
}

