//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.

import Foundation
import Alamofire

protocol PokeListRemoteDataSource {
  
  func sarchRepoList(param: [String: Any],
                     completion: @escaping(Result<[RepositoryModel], NError>) -> Void)
  
  
}

class RepoSearchListRemoteDataSourceImpl: PokeListRemoteDataSource{
  
  let apiService: ApiService
  
  init(apiService: ApiService) {
    self.apiService = apiService
  }
  
  func sarchRepoList(param: [String : Any],
                     completion: @escaping (Result<[RepositoryModel], NError>) -> Void) {
    
    apiService.request(of: SearchRepoResponse.self, with: "search/repositories", withParameter: param) { result in
      switch result {
      case .failure(let error):
        completion(.failure(error))
        break
      case .success(let response):
        let repositories = response.items?.map{ RepositoryModel(id: $0.id ?? 0,
                                                                owner: $0.owner?.login ?? "",
                                                                repo: $0.name ?? "",
                                                                avatarURL: URL(string: $0.owner?.avatarURL ?? ""),
                                                                url: URL(string: $0.htmlURL ?? ""),
                                                                forkCount: $0.forksCount ?? 0,
                                                                issueCount: $0.openIssuesCount ?? 0,
                                                                watcherCount: $0.watchersCount ?? 0) } ?? []
        completion(.success(repositories))
        
        break
      }
    }
    
  }
  
}
