//
//  APIService.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

enum ServiceResult<T> {
    case success(T)
    case failure(Error?)
}

struct EyesError: CoreServiceCodable {
    var statusCode: Int?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case error
    }
}


class APIService: NSObject {
    private var logger: NetworkLogger = NetworkLogger()
    static let shared = APIService()
    var baseURL = "https://eyes-technical-test.herokuapp.com"
    func performRequest(router: Router, completionHandler complete: @escaping (ServiceResult<Data?>) -> Void) {
        let urlRequest = router.urlRequest(baseUrl: URL(string: baseURL)!)
        logger.log(request: urlRequest)
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if error == nil {
                if let urlResponse = response as? HTTPURLResponse {
                    self?.logger.log(response: urlResponse, data: data)
                    if urlResponse.isSuccess {
                        complete(.success(data))
                    } else {
                        if let data = data {
                            let commonError: EyesError? = EyesError.from(data: data)
                        } else {
                            complete(.failure(error))
                        }
                    }
                }
            }
            }.resume()
    }
}

extension HTTPURLResponse {
    
    var isSuccess: Bool {
        return 200 ... 299 ~= statusCode
    }
}

