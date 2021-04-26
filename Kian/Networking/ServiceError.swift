//
//  ServiceError.swift
//  Telma
//
//  Created by Amir Tutunchi on 3/15/20.
//  Copyright © 2020 kasra. All rights reserved.
//

import Foundation
enum ServiceError : LocalizedError{
    case badHTTPStatus(status : Int , message : String?)
    case badToken(message : String?)
    case invalidResponse
}
