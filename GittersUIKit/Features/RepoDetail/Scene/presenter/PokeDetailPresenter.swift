//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

import Foundation

protocol PokeDetailPresenterLogic: BasePresenter {
  func presentRepoDetail(model: RepoDetailModel)
  func presentRecommendationCards()
}

class PokeDetailPresenter: PokeDetailPresenterLogic {
  
  weak var viewController: PokeDetailDisplayLogic?
  
  func presentError(_ errorMessage: String?) {
    viewController?.displayError(errorMessage)
  }
  
  func presentRepoDetail(model: RepoDetailModel) {
    viewController?.displayRepoDetail(viewModel: model)
  }
  
  func presentRecommendationCards() {
    viewController?.displayRecommendationCards()
  }

}
