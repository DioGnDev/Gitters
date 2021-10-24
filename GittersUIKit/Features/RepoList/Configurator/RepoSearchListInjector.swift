//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

struct PokeListInjector{
  static func inject(dependencyFor viewController: RepoSearchListUI) {
    
    let presenter = RepoSearchListPresenter(viewController: viewController)
    let worker = RepoSearchListRemoteDataSourceImpl(apiService: SceneModule.provideApiService())
    let interactor = PokeListInteractor(worker: worker, presenter: presenter)
    
    viewController.interactor = interactor
  }
}

