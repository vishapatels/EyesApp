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
    
    var data: String {
        return userDetail![0].data
    }
    var type: String {
        return userDetail![0].type
    }
    
}
extension UserDetailViewModel: ManagerInjected {
    
    func getUserDetail(id: String ,ignoreCache: Bool, completion complete: @escaping(ServiceResult<Bool>) -> Void) {
        let dataExist = !ignoreCache && userDetailManager.getUserDetailFromCached() != nil
        if dataExist {
            self.userDetail = userDetailManager.getUserDetailFromCached()
            complete(.success(true))
            
        }
        userDetailManager.getUserDetail(id: "1") { [weak self] result in
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

