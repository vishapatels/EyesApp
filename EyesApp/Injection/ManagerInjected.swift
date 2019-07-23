//
//  ManagerInjected.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
protocol ManagerInjected  {}

extension ManagerInjected {
    
    var userListManager: UserListManagerProtocol {
        return ManagerInjector.userListManager
    }
    var userDetailManager: UserDetailManagerProtocol {
        return ManagerInjector.userDetailManager
    }
}

struct ManagerInjector {
    static var userListManager: UserListManagerProtocol = UserListManager()
    static var userDetailManager: UserDetailManagerProtocol = UserDetailManager()
}
