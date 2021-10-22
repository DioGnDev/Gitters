//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

struct PokeDetailInjector{
  
  static func inject(dependencyFor viewController: PokeDetailUI) {
    
    let worker = PokeDetailRemoteDataSourceImpl(apiService: SceneModule.provideApiService())
    let interactor = PokeDetailInteractor(worker: worker, listWorker: SceneModule.provideListWorker())
    
    let presenter = PokeDetailPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
    
  }
}
