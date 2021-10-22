//
//  PokeListUI+Display.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/20/21.
//

import Foundation
import UIKit

extension PokeListUI: RepoListDisplayLogic {
  
  func displayPokeList(){
    setupSearchController()
    loadingIndicator.stopAnimating()
    collectionView.reloadData()
    refreshControl.endRefreshing()
  }
  
  func displayError(_ errorMessage: String?) {
    //display error
    loadingIndicator.stopAnimating()
    self.snackbar
      .setMessage(errorMessage!)
      .setParent(self)
      .show()
    collectionView.reloadData()
  }

}
