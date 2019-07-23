//
//  Collection+Extension.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
extension Collection where Element == User {
    
    var userListProviders: [UserListDataProvider] {
        return compactMap { result in
            UserListDataProvider(name: result.name!, image: result.profileImage!)
        }
    }
}

extension Collection where Element == Content {
    
    var userDetailProviders: [UserDetailDataProvider] {
        return compactMap { result in
            UserDetailDataProvider(type: result.type!, data: result.data!)
        }
    }
}
