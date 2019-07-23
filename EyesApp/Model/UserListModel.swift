//
//  UserList.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

struct UserListModel: CoreServiceCodable {
    var users: [User]?
}

struct User: CoreServiceCodable {
    var id: Int?
    var name, userName: String?
    var profileImage: String?
    var createdDate: String?
}


