//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

import Foundation

protocol RepoDetailPresenterLogic: BasePresenter {
  func presentRepoDetail(model: RepoDetailModel)
  func presentRepoDetail()
}

class RepoDetailPresenter: RepoDetailPresenterLogic {
  
  weak var viewController: RepoDetailDisplayLogic?
  
  func presentError(_ errorMessage: String?) {
    viewController?.displayError(errorMessage)
  }
  
  func presentRepoDetail(model: RepoDetailModel) {
    viewController?.displayRepoDetail(viewModel: model)
  }
  
  func presentRepoDetail() {
    viewController?.displayRepoDetail()
  }

}
