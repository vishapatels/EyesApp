//
//  UserDetailViewModel.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

struct UserDetailDataProvider {
    
    var type: String
    var data: String
    
    init(type: String, data: String ) {
        self.type = type
        self.data = data
    }
}
class UserDetailViewModel {
    private var userDetail: [UserDetailDataProvider]?
    
    func usersDetailAtIndex(atIndex index: Int) -> UserDetailDataProvider? {
        return userDetail?[index]
    }
    var numberOfRows: Int {
        return userDetail?.count ?? 0
    }
    
}
extension UserDetailViewModel: ManagerInjected {
    
    func getUserDetail(id: Int64 ,ignoreCache: Bool, completion complete: @escaping(ServiceResult<Bool>) -> Void) {
        let dataExist = !ignoreCache && userDetailManager.getUserDetailFromCached(id: id) != nil
        if dataExist {
            self.userDetail = userDetailManager.getUserDetailFromCached(id: id)
            complete(.success(true))
            
        }
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

