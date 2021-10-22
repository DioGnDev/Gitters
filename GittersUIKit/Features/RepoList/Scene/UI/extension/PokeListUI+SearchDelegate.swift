//
//  PokeListUI+SearchDelegate.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/20/21.
//

import Foundation
import UIKit

extension PokeListUI: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    interactor?.filterCards(searchText: searchText)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    interactor?.filterCards(searchText: "")
  }
}
