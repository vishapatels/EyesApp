//
//  UserDetailModel.swift
//  EyesApp
//
//  Created by Smitesh Patel on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
struct UserDetailModel: CoreServiceCodable {
    let content: [Content]?
}

struct Content: CoreServiceCodable {
    let id: Int?
    let type: String?
    let width, height: Int?
    let data: String?
    let createdDate: String?
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, type, width, height, data, createdDate
        case userID = "userId"
    }
}
