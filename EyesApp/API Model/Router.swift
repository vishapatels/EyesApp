//
//  Router.swift
//  EyesApp
//
//  Created by Smitesh Patel on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

enum HeaderField : String {
    case contentType = "Content-Type"
}

enum Router {
    
    case getUserList()
    case getUserDetailInfo(id: String)
    
    func urlRequest(baseUrl: URL) -> URLRequest {
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = getData
        urlRequest.allHTTPHeaderFields = httpHeaders
        return urlRequest
    }
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
    }
    
    var httpMethod: String {
        return HTTPMethod.get.rawValue
    }
    
    var getData: Data? {
        switch self {
        case .getUserList():
            return nil
        case .getUserDetailInfo(let id):
            return nil
        }
    }
    
    var httpHeaders: [String: String] {
        let headers: [String: String] = [HeaderField.contentType.rawValue : "application/json"]
        return headers
    }
    
    var path: String {
        switch self {
        case .getUserList():
            return "/users"
            
        case .getUserDetailInfo(let id):
            return "content?userId=" + id
        }
    }
    
}

