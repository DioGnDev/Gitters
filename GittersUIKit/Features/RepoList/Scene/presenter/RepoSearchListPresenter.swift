//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.

import Foundation

protocol RepoSearchListPresenterLogic: BasePresenter {
  func presentPokeList()
  func presentLoading(_ state: Bool)
}

class RepoSearchListPresenter: RepoSearchListPresenterLogic {
  
  weak var viewController: RepoListDisplayLogic?
  
  init(viewController: RepoListDisplayLogic) {
    self.viewController = viewController
  }
  
  func presentPokeList() {
    viewController?.displayPokeList()
  }
  
  func presentError(_ errorMessage: String?) {
    viewController?.displayError(errorMessage)
  }
  
  func presentLoading(_ state: Bool) {
    viewController?.shouldShowProgress(state)
  }
  
}
