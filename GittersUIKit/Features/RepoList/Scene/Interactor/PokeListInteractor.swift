//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.

import Foundation

protocol PokeListInteractorLogic: BaseInteractorLogic {
  func fetchPokeList(param: PokeListModel.Request?)
  func loadMorePokeList(param: PokeListModel.Request)
  func getLists() -> [RepositoryModel]
  func hasError() -> Bool
  func filterCards(searchText: String)
  func isLoadingState() -> Bool
  func removeData()
}

class PokeListInteractor: PokeListInteractorLogic {
  
  var currentPage: Int = 0
  var count: Int = 0
  var lists: [RepositoryModel] = []
  var filteredItems: [RepositoryModel] = []
  var isLoading = false
  var isError = false
  var searchText = ""
  
  //presenter
  var presenter: PokeListPresenterLogic?
  let worker: PokeListRemoteDataSource
  
  init(worker: PokeListRemoteDataSource, presenter: PokeListPresenterLogic?) {
    self.worker = worker
    self.presenter = presenter
  }
  
  func fetchPokeList(param: PokeListModel.Request?) {
    isLoading = true
    worker.fetchPokeList(param: param?.toParam() ?? [:]) { [weak self] result in
      switch result {
      case let .failure(error):
        self?.isLoading = false
        self?.isError = true
        self?.presenter?.presentError(error.description)
      case let .success(response):
        guard let self = self else { return }
        self.isLoading = false
        self.lists = response
        
        DispatchQueue.main.async {
          self.presenter?.presentPokeList()
        }
        
      }
    }
  }
  
  func loadMorePokeList(param: PokeListModel.Request) {
    
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
  
  func filterCards(searchText: String) {
    self.searchText = searchText
    filteredItems = self.lists.filter{ $0.repo.lowercased().contains(searchText.lowercased()) }
    debug("filter", filteredItems)
    presenter?.presentPokeList()
  }
  
  func removeData() {
    lists = []
    isError = true
    presenter?.presentPokeList()
  }
  
}
