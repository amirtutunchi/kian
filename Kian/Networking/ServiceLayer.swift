//
//  ServiceLayer.swift
//  ManualNetworking
//
//  Created by Amir Tutunchi on 9/29/19.
//  Copyright © 2019 kasra. All rights reserved.
//

import Foundation
import UIKit

struct ResponseModel<X : Codable> : Codable{
    let data : X
    let message : String
    let success : Bool
}
typealias Parameters = [String: String]

struct RequestModel <X : Codable> : Codable {
    let data : [X]
}
class ServiceLayer  {
    private var session : URLSession!
    internal let decoder : JSONDecoder
    static let sharedInstance = ServiceLayer()
    private init() {
        /// create and config urlsession configuration
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        /// create and config urlsession
        self.session = URLSession(configuration: config, delegate: nil, delegateQueue: .main)
        
        /// create and config json decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "en_US")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: dateString){
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
        })
        self.decoder = decoder
    }
    
   
    
   
    /// this function is used to validate server response and check whether every thing is ok or not
    private func validate(response : HTTPURLResponse? , data : Data?) throws -> Data{
        let errorResponse = data.flatMap( {try? decoder.decode(ErrorResponse.self, from: $0)})
        let a = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        print(a)
        guard let response = response else {
            throw ServiceError.invalidResponse
        }
        switch  response.statusCode {
        case 401:
            throw  ServiceError.badToken(message: errorResponse?.message)
        case 400...600:
//            GenearalAlertManager.showAlert(title: "Error", message: errorResponse?.message ?? "")
            throw ServiceError.badHTTPStatus(status: response.statusCode, message: errorResponse?.message)
        default:
            break
        }
        guard let data = data else {
            throw ServiceError.invalidResponse
        }
        return data
    }
    /// this function is for creating UrlComponents object
    private func createBaseURLComponent(router : Router ) -> URLComponents{
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        
        if router.port != 80{
            components.port = router.port
        }
        components.queryItems = router.parameters
        return components
    }
    /// this function creates URLRequest object for every request we need
    private func createUrlRequest(router : Router , components : URLComponents)-> URLRequest{
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = router.method
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        if router.method != "GET"{
            urlRequest.httpBody = router.bodyParams
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        }
//        switch router {
//        case .refreshToken:
//            if RefreshToken != ""{
//                urlRequest.addValue("Bearer " + RefreshToken, forHTTPHeaderField: "Authorization")
//            }
//        default:
//            if Token != ""{
//                urlRequest.addValue("Bearer " + Token, forHTTPHeaderField: "Authorization")
//            }
//        }
       
        return urlRequest
    }
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
        let components = createBaseURLComponent(router : router)
        let urlRequest = createUrlRequest(router: router, components: components)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            do{
                if let error = error {throw error}
                let data = try self.validate(response: response as? HTTPURLResponse, data: data)
                let result =  try  self.decoder.decode(T.self, from: data)
                completion(.success(result))
            }
            catch{
            
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        session.dataTask(with: url, completionHandler: completion).resume()
    }
    func uploadImage(image : UIImage ,imageUrl : String , completion: @escaping (Result<Any, Error>) -> ()){
        let parameters = ["image" : "\(arc4random()).jpeg"]
        let boundary = "Boundary-\(UUID().uuidString)"       
        
        var request = URLRequest(url: URL(string: "https://api.jouritm.com/upload/db")!,timeoutInterval: Double.infinity)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        guard let mediaImage = Media(withImage: image, forKey: "image") else { return }

        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)

        request.httpBody = dataBody
        
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                if let error = error {throw error}
                let data = try self.validate(response: response as? HTTPURLResponse, data: data)
                let result =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init())
                completion(.success(result))
            }catch(let err){
                print(err)
                completion(.failure(err))
            }
            
        }
        task.resume()
    }
   
    func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
    func requestWithJsonResponse(router: Router, completion: @escaping (Result<Any, Error>) -> ()) {
           let components = createBaseURLComponent(router : router)
           let urlRequest = createUrlRequest(router: router, components: components)
           let dataTask = session.dataTask(with: urlRequest) { data, response, error in
               do{
                   if let error = error {throw error}
                   let data = try self.validate(response: response as? HTTPURLResponse, data: data)
                   let result =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init())
                   completion(.success(result))
               }
               catch{
                   completion(.failure(error))
               }
           }
           dataTask.resume()
       }

}

extension URLRequest {
    
    private func percentEscapeString(_ string: String) -> String {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return string
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    mutating func encodeParameters(parameters: [String : String]) {
        httpMethod = "POST"
        
        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
    mutating func encodeParametersData(parameters : Data){
        let json = try? JSONSerialization.jsonObject(with: parameters , options: []) as? [String : String]
        if let json = json{
            encodeParameters(parameters: json)
        }
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "\(arc4random()).jpg"
        
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        self.data = data
    }
    
}
