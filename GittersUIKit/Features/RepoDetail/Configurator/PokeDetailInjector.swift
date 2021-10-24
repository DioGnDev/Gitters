//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

struct PokeDetailInjector{
  
  static func inject(dependencyFor viewController: RepoDetailUI) {
    
    let worker = RepoDetailRemoteDataSourceImpl(apiService: SceneModule.provideApiService())
    let interactor = PokeDetailInteractor(worker: worker, listWorker: SceneModule.provideListWorker())
    
    let presenter = RepoDetailPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
    
  }
}
