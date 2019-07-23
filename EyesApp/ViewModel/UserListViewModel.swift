//
//  UserListViewModel.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import UIKit

struct UserListDataProvider {
    
    var name: String
    var image: String
    
    init(name: String, image: String ) {
        self.name = name
        self.image = image
    }
}


enum ServerError: Error {
    
    case invalidData
    case invalidResponse
    case networkError
    case apiError(statusCode: String)
    
    //    var description: String {
    //
    //        switch self {
    //        case .apiError(let statusCode):
    //
    //        }
    //    }
    
}
class UserListViewModel {
     private var userInfos: [UserListDataProvider] = []
    
    var numberOfRows: Int {
        return userInfos.count
    }
    
    func usersAtIndex(atIndex index: Int) -> UserListDataProvider? {
        return userInfos[index]
    }
}
    
extension UserListViewModel: ManagerInjected {
    
    func getUserList(completion complete: @escaping(ServiceResult<Bool>) -> Void) {
        userListManager.getUserInfoList { [weak self] result in
            guard let self = self else {
                complete(.success(false))
                return
            }
            switch result {
            case .success(let userInfos):
                self.userInfos = userInfos
                complete(.success(true))
            case .failure(let error):
                complete(.failure(error!))
            }
        }
    }
}

