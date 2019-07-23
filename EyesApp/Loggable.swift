//
//  Loggable.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

extension Data {
    
    var stringValue: String? {
        return String(data: self, encoding: .utf8)
    }
}

extension String {
    
    var removedSpaces: String {
        return trimmingCharacters(in: .whitespaces)
    }
}

protocol Loggable {
    
    var logFileName: String { get }
    var items: [String] { get set }
}

extension Loggable {
    
    func log(message: String) {
        // TODO:- Enable/Disable logging based on flag
        print(message)
    }
    
    func save() -> String? {
        do {
            let url = try logFileURL()
            try items.joined(separator: "\r\n").write(to: url, atomically: false, encoding: .utf8)
            
            return url.absoluteString
        } catch {
            return nil
        }
    }
    
    func remove() {
        do {
            let url = try logFileURL()
            try FileManager.default.removeItem(at: url)
        } catch {}
    }
    
    private func logFileURL() throws -> URL {
        let documentsDirectory = try FileManager.default.url(for: .documentDirectory,
                                                             in: .userDomainMask,
                                                             appropriateFor: nil,
                                                             create: false)
        return documentsDirectory.appendingPathComponent(logFileName)
    }
}

class NetworkLogger: Loggable {
    
    var logFileName: String { return "network.log" }
    var items: [String] = []
    
    func log(request: URLRequest) {
        log(heading: "REQUEST", url: request.url?.absoluteString, method: request.httpMethod, headers: request.allHTTPHeaderFields, data: request.httpBody)
    }
    
    func log(response: HTTPURLResponse, data: Data?) {
        log(heading: "RESPONSE", url: response.url?.absoluteString, status: response.statusCode, headers: response.allHeaderFields, data: data)
    }
    
    private func log(heading: String, url: String?, method: String? = nil, status: Int? = nil, headers: [AnyHashable: Any]?, data: Data?) {
        #if !DEBUG
        return
        #endif
        
        var message = """
        =========================\(heading)=========================\r\n
        URL: \t\t\(url ?? "")\r\n
        """
        
        if let status = status {
            message += "STATUS:\t\(status)\r\n"
        }
        
        if let method = method {
            message += "METHOD:\t\(method)\r\n"
        }
        
        if let headers = headers, !headers.isEmpty {
            message += "HEADERS:\r\n"
            headers.forEach {
                message += "\t\t\t\($0.key): \($0.value)\r\n"
            }
        }
        
        if let data = data, let stringValue = data.stringValue {
            message += "DATA: \r\n\(stringValue.removedSpaces)\r\n"
        }
        
        log(message: message)
        items.append(message)
    }
}

