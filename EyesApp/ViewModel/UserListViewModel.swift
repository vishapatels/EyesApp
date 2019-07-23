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
    var id: Int64
    
    init(name: String, image: String, id:Int64 ) {
        self.name = name
        self.image = image
        self.id = id 
    }
}




final class UserListViewModel {
     private var userInfos: [UserListDataProvider]?
    
    var numberOfRows: Int {
        return userInfos?.count ?? 0
    }
    
    func usersAtIndex(atIndex index: Int) -> UserListDataProvider? {
        return userInfos?[index]
    }
}
    
extension UserListViewModel: ManagerInjected {
    
    func getUserList(ignoreCache: Bool, completion complete: @escaping(ServiceResult<Bool>) -> Void) {
        let dataExist = !ignoreCache && !(userListManager.getUserInfoFromCached()?.isEmpty ?? true)
        if dataExist {
            self.userInfos = userListManager.getUserInfoFromCached()
            complete(.success(true))
            
        } else {
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
}

