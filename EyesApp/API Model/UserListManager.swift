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
    
    func getUserInfoFromCached() -> [UserListDataProvider]?
    
    func getUserInfoList(completionHandler complete: @escaping(ServiceResult<[UserListDataProvider]>) -> Void)
}


final class UserListManager: UserListManagerProtocol, ManagerInjected {

    func getUserInfoFromCached() -> [UserListDataProvider]? {
        return coreDataManager.fetchUsers()?.userListProviders
    }
    
    func getUserInfoList(completionHandler complete: @escaping(ServiceResult<[UserListDataProvider]>) -> Void) {
        var logger: NetworkLogger = NetworkLogger()
        DispatchQueue.episodeManager.async {
            APIService.shared.performRequest(router: .getUserList(), completionHandler: { [weak self] result in
                switch result {
                case .success(let data):
                    if let data = data, let viewContext = self?.coreDataManager.persistentContainer.viewContext, let userList: UserListModel = UserListModel.from(data: data, managedObjectContext: viewContext) {
                        
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

