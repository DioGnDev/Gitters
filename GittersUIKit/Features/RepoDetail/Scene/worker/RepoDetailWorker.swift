//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation
import Alamofire

protocol RepoDetailtRemoteDataSource {
  
  func fetchRepoDetail(id: String, completion: @escaping(Result<(RepoDetailModel, [RepositoryModel]), NError>) -> Void)
  
}

class RepoDetailRemoteDataSourceImpl: RepoDetailtRemoteDataSource{
  
  let apiService: ApiService
  
  init(apiService: ApiService) {
    self.apiService = apiService
  }
  
  func fetchRepoDetail(id: String, completion: @escaping (Result<(RepoDetailModel, [RepositoryModel]), NError>) -> Void) {
    
    var model = RepoDetailModel(name: "",
                                avatar: URL(string: ""),
                                repoURL: "",
                                company: "",
                                location: "",
                                blog: "",
                                cratedAt: "")
    var repositories: [RepositoryModel] = []
    var detailError: NError? = nil
    var repoError: NError? = nil
    
    let group = DispatchGroup()
    
    group.enter()
    apiService.request(of: RepoDetailResponse.self, with: "users/\(id)") { result in
      switch result {
      case .failure(let error):
        detailError = error
      case .success(let response):
        model = RepoDetailModel(name: response.name ?? "",
                                     avatar: URL(string: response.avatarURL ?? ""),
                                     repoURL: response.reposURL ?? "",
                                     company: response.company ?? "",
                                     location: response.location ?? "",
                                     blog: response.blog ?? "",
                                     cratedAt: response.createdAt ?? "")
      }
      
      group.leave()
    }
    
    
    group.enter()
    apiService.request(of: UserRepoResponse.self, with: "users/\(id)/repos") { result in
      switch result {
      case .failure(let error):
        repoError = error
        break
      case .success(let response):
       repositories = response.map{ RepositoryModel(id: $0.id ?? 0,
                                                          owner: $0.owner?.login ?? "",
                                                          repo: $0.fullName ?? "",
                                                          avatarURL: URL(string: $0.owner?.avatarURL ?? ""),
                                                          url: URL(string: $0.url ?? ""),forkCount: $0.forksCount ?? 0,
                                                          issueCount: $0.openIssuesCount ?? 0,
                                                          watcherCount: $0.watchersCount ?? 0) }
        
      }
      group.leave()
    }
    
    
    group.notify(queue: DispatchQueue.global()) {
      
      if let detailError = detailError {
        DispatchQueue.main.async {
          completion(.failure(detailError))
        }
        return
      }
      
      if let repoError = repoError {
        DispatchQueue.main.async {
          completion(.failure(repoError))
        }
        return
      }
      
      DispatchQueue.main.async {
        let result = (model, repositories)
        completion(.success(result))
      }
      
    }
    
  }
  
}
