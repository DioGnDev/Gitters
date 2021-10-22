//
//  MainCoordinator.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/19/21.
//

import Foundation
import UIKit

protocol Coordinator{
  var childCoordinators: [Coordinator] { get set }
  var navigationController: CustomNavigationController { get set }
  
  func start()
}

class MainCoodinator: Coordinator {
  var childCoordinators: [Coordinator] = [Coordinator]()
  var navigationController: CustomNavigationController
  
  lazy var card: RepositoryModel? = nil
  
  init(navigationController: CustomNavigationController){
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = PokeListUI()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }
  
  func gotoPokeDetailCard(){
    let vc = PokeDetailUI()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }
  
}
