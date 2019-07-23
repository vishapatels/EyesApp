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
   //  private var userInfos = UserDetailModel()
}
extension UserDetailViewModel: ManagerInjected {
    
    func getUserDetail(id: String , completion complete: @escaping(ServiceResult<Bool>) -> Void) {
        userDetailManager.getUserDetail(id: "1") { [weak self] result in
            guard let self = self else {
                complete(.success(false))
                return
            }
            switch result {
            case .success(let userDetail):
             //   self.userInfos = userInfos
                complete(.success(true))
            case .failure(let error):
                complete(.failure(error!))
            }
        }
    }
}

