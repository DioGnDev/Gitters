//
//  SceneModule.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

struct SceneModule{
  static func provideApiService() -> ApiService {
    return ApiService()
  }
  
  static func provideListWorker() -> PokeListRemoteDataSource {
    return RepoSearchListRemoteDataSourceImpl(apiService: provideApiService())
  }
  
  static func provideNetworkManager() -> NetworkManagerProtocol {
    return NetworkManager.sharedInstance
  }
  
}
