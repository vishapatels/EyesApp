//
//  UserListManager.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
extension DispatchQueue {
    static let network = DispatchQueue(label: "com.eyes.network")
    static let episodeManager = DispatchQueue(label: "com.eyes.episodeManager", attributes: .concurrent, target: .network)
}

protocol UserListManagerProtocol {
    func getUserInfoList(completionHandler complete: @escaping(ServiceResult<[UserListDataProvider]>) -> Void)
}


final class UserListManager: UserListManagerProtocol {

    func getUserInfoList(completionHandler complete: @escaping(ServiceResult<[UserListDataProvider]>) -> Void) {
        var logger: NetworkLogger = NetworkLogger()
        DispatchQueue.episodeManager.async {
            APIService.shared.performRequest(router: .getUserList(), completionHandler: { result in
                switch result {
                case .success(let data):
                    if let data = data, let userList: UserListModel = UserListModel.from(data: data) {
                        DispatchQueue.main.async {
                            complete(.success(userList.users!.userListProviders))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        complete(.failure(error))
                    }
                }
            })
        }
    }
}

