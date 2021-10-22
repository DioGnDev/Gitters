//
//  PokeListPresenter.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/18/21.

import Foundation

protocol PokeListPresenterLogic: BasePresenter {
  func presentPokeList()
}

class PokeListPresenter: PokeListPresenterLogic {
  
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
  
}
