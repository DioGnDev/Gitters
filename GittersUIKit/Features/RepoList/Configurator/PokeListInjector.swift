//
//  PokeListInjector.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

struct PokeListInjector{
  static func inject(dependencyFor viewController: PokeListUI) {
    
    let presenter = PokeListPresenter(viewController: viewController)
    let worker = PokeListRemoteDataSourceImpl(apiService: SceneModule.provideApiService())
    let interactor = PokeListInteractor(worker: worker, presenter: presenter)
    
    viewController.interactor = interactor
  }
}

