
//
//  UserDetailManaget.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
protocol UserDetailManagerProtocol {
    func getUserDetail(id:String, completionHandler complete: @escaping(ServiceResult<[UserDetailDataProvider]>) -> Void)
    
    func getUserDetailFromCached() -> [UserDetailDataProvider]?
}


final class UserDetailManager: UserDetailManagerProtocol, ManagerInjected {
    
    func getUserDetailFromCached() -> [UserDetailDataProvider]? {
        return coreDataManager.fetchUsersContent()?.userDetailProviders
    }
    
    func getUserDetail(id:String, completionHandler complete: @escaping(ServiceResult<[UserDetailDataProvider]>) -> Void) {
        DispatchQueue.episodeManager.async {
            APIService.shared.performRequest(router: .getUserDetailInfo(id: id), completionHandler: { [weak self] result in
                switch result {
                case .success(let data):
                    if let data = data, let viewContext = self?.coreDataManager.persistentContainer.viewContext, let userDetail: UserDetailModel = UserDetailModel.from(data: data, managedObjectContext: viewContext) {
                        DispatchQueue.main.async {
                            if let userDetailProviders: [UserDetailDataProvider] = userDetail.content?.userDetailProviders {
                                complete(.success(userDetailProviders))
                            }
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

