//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.

import Foundation

protocol RepoSearchListInteractorLogic: BaseInteractorLogic {
  func searchRepoList(param: RepoSearchListModel.Request?)
  func getLists() -> [RepositoryModel]
  func hasError() -> Bool
  func isLoadingState() -> Bool
  func removeData()
}

class PokeListInteractor: RepoSearchListInteractorLogic {
  
  var currentPage: Int = 0
  var count: Int = 0
  var lists: [RepositoryModel] = []
  var filteredItems: [RepositoryModel] = []
  var isLoading = false
  var isError = false
  var searchText = ""
  
  //presenter
  var presenter: RepoSearchListPresenterLogic?
  let worker: PokeListRemoteDataSource
  
  init(worker: PokeListRemoteDataSource, presenter: RepoSearchListPresenterLogic?) {
    self.worker = worker
    self.presenter = presenter
  }
  
  func searchRepoList(param: RepoSearchListModel.Request?) {
    isLoading = true
    presenter?.presentLoading(true)
    worker.sarchRepoList(param: param?.toParam() ?? [:]) { [weak self] result in
      switch result {
      case let .failure(error):
        self?.presenter?.presentLoading(false)
        self?.isLoading = false
        self?.isError = true
        self?.presenter?.presentError(error.description)
      case let .success(response):
        guard let self = self else { return }
        self.presenter?.presentLoading(false)
        self.isLoading = false
        self.lists = response
        
        DispatchQueue.main.async {
          self.presenter?.presentPokeList()
        }
        
      }
    }
  }

  func isLoadingState() -> Bool {
    return isLoading
  }
  
  func getCount() -> Int {
    return filteredItems.count == 0 ? lists.count : filteredItems.count
  }
  
  func getPage() -> Int {
    return currentPage
  }
  
  func getLists() -> [RepositoryModel] {
    return lists
  }
  
  func hasError() -> Bool {
    return isError
  }
  
  func removeData() {
    lists = []
    isError = true
    isLoading = false
    presenter?.presentPokeList()
  }
  
}
