//
//  UserDetailViewModel.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

enum MediaType {
    case text
    case image
    case video
}

struct UserDetailDataProvider {
    
    var type: String
    var data: String
    
    init(type: String, data: String) {
        self.type = type
        self.data = data
    }
}

final class UserDetailViewModel {
    
    private var userDetail: [UserDetailDataProvider]?
    
}
// Internal
extension UserDetailViewModel: ManagerInjected {
    
    func usersDetailAtIndex(atIndex index: Int) -> UserDetailDataProvider? {
        return userDetail?[index]
    }
    
    var numberOfRows: Int {
        return userDetail?.count ?? 0
    }
    
    func getUserDetail(id: Int64, ignoreCache: Bool, completion complete: @escaping (ServiceResult<Bool>) -> Void) {
        let dataExist = !ignoreCache && !(userDetailManager.getUserDetailFromCached(id: id)?.isEmpty ?? true)
        if dataExist {
            userDetail = userDetailManager.getUserDetailFromCached(id: id)
            complete(.success(true))
            
        } else {
            userDetailManager.getUserDetail(id: String(id)) { [weak self] result in
                guard let self = self else {
                    complete(.success(false))
                    return
                }
                switch result {
                case .success(let userDetail):
                    self.userDetail = userDetail
                    complete(.success(true))
                case .failure(let error):
                    complete(.failure(error!))
                }
            }
        }
    }
}
