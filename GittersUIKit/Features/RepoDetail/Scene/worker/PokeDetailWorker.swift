//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation
import Alamofire

protocol PokeDetailtRemoteDataSource {
  
  func fetchRepoDetail(id: String, completion: @escaping(Result<RepoDetailModel, NError>) -> Void)
  func fetchUserRepo(user: String, completion: @escaping(Result<[RepositoryModel], NError>) -> Void)
  
}

class PokeDetailRemoteDataSourceImpl: PokeDetailtRemoteDataSource{
  
  let apiService: ApiService
  
  init(apiService: ApiService) {
    self.apiService = apiService
  }
  
  func fetchRepoDetail(id: String, completion: @escaping (Result<RepoDetailModel, NError>) -> Void) {
    
    apiService.request(of: RepoDetailResponse.self, with: "users/\(id)") { result in
      switch result {
      case .failure(let error):
        completion(.failure(error))
      case .success(let response):
        let model = RepoDetailModel(name: response.name ?? "",
                                    avatar: URL(string: response.avatarURL ?? ""),
                                    repoURL: response.reposURL ?? "",
                                    company: response.company ?? "",
                                    location: response.location ?? "",
                                    blog: response.blog ?? "",
                                    cratedAt: response.createdAt ?? "")
        
        completion(.success(model))
      }
    }
    
  }
  
  func fetchUserRepo(user: String, completion: @escaping (Result<[RepositoryModel], NError>) -> Void) {
    
    apiService.request(of: UserRepoResponse.self, with: "users/\(user)/repos") { [weak self] result in
      switch result {
      case .failure(let error):
        completion(.failure(error))
        break
      case .success(let response):
        let repositories = response.map{ RepositoryModel(id: $0.id ?? 0,
                                                         owner: $0.owner?.login ?? "",
                                                         repo: $0.fullName ?? "",
                                                         avatarURL: URL(string: $0.owner?.avatarURL ?? ""),
                                                         url: URL(string: $0.url ?? "")) }
        completion(.success(repositories))
        
        break
      }
    }
  }
  
}
