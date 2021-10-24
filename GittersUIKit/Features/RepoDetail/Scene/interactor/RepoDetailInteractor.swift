//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

protocol PokeDetailInteractorLogic: BaseInteractorLogic {
  func fetchRecommendationCards(user: String, param: RepoSearchListModel.Request?)
  func getErrorState() -> Bool
  func fetchDetailRepo(user: String)
  func getDetailModel() -> RepoDetailModel
  func getLists() -> [RepositoryModel]
}

class PokeDetailInteractor: PokeDetailInteractorLogic {
  
  //presenter
  var presenter: RepoDetailPresenterLogic?
  
  //worker
  let worker: RepoDetailtRemoteDataSource
  let listWorker: PokeListRemoteDataSource
  
  //state
  private(set) var currentPage: Int = 0
  private(set) var count: Int = 0
  private(set) var model: RepoDetailModel = RepoDetailModel(name: "",
                                                            avatar: URL(string: ""),
                                                            repoURL: "",
                                                            company: "",
                                                            location: "",
                                                            blog: "",
                                                            cratedAt: "")
  private(set) var lists: [RepositoryModel] = []
  private(set) var isLoading = false
  private(set) var isError = false
  
  init(worker: RepoDetailtRemoteDataSource, listWorker: PokeListRemoteDataSource) {
    self.worker = worker
    self.listWorker = listWorker
  }
  
  func fetchDetailRepo(user: String) {
    worker.fetchRepoDetail(id: user) { [weak self] result in
      switch result {
      case let .failure(error):
        self?.isLoading = false
        self?.isError = true
        DispatchQueue.main.async {
          self?.presenter?.presentError(error.description)
        }
      case let .success(response):
        guard let self = self else { return }
        self.isLoading = false
        self.isError = false

        let (detail, repos) = response
        self.model = detail
        self.lists = repos
        
        DispatchQueue.main.async {
          self.presenter?.presentRepoDetail()
        }
        
      }
    }
  }

  func fetchRecommendationCards(user: String, param: RepoSearchListModel.Request?) {
    isLoading = true
    
    worker.fetchUserRepo(user: user) { [weak self] result in
      switch result {
      case let .failure(error):
        self?.isLoading = false
        self?.isError = true
        self?.presenter?.presentError(error.description)
      case let .success(response):
        guard let self = self else { return }
        self.isLoading = false
        self.isError = false
        self.lists = response
        DispatchQueue.main.async {
          self.presenter?.presentRecommendationCards()
        }
        
      }
    }
  }
  
  func getDetailModel() -> RepoDetailModel{
    return model
  }
  
  func getPage() -> Int {
    return self.currentPage
  }
  
  func getCount() -> Int {
    return self.count
  }

  func getErrorState() -> Bool {
    return isError
  }
  
  func getLists() -> [RepositoryModel] {
    return lists
  }
  
}
