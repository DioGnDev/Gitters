//
//  PokeListRemoteDataSource.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/18/21.

import Foundation
import Alamofire

protocol PokeListRemoteDataSource {
  
  func fetchPokeList(param: [String: Any],
                     completion: @escaping(Result<[RepositoryModel], NError>) -> Void)
  
  
}

class PokeListRemoteDataSourceImpl: PokeListRemoteDataSource{
  
  let apiService: ApiService
  
  init(apiService: ApiService) {
    self.apiService = apiService
  }
  
  func fetchPokeList(param: [String : Any],
                     completion: @escaping (Result<[RepositoryModel], NError>) -> Void) {
    
    apiService.request(of: RepositoryResponse.self, with: "repositories", withParameter: param) { result in
      switch result {
      case .failure(let error):
        completion(.failure(error))
        break
      case .success(let response):
        let repositories = response.map{ RepositoryModel(id: $0.id ?? 0,
                                                         owner: $0.owner?.login ?? "",
                                                         repo: $0.name ?? "",
                                                         avatarURL: URL(string: $0.owner?.avatarURL ?? ""),
                                                         url: URL(string: $0.htmlURL ?? "")) }
        completion(.success(repositories))
        
        break
      }
    }
    
  }
  
}
