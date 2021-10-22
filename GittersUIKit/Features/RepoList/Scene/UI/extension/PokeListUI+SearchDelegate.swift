//
//  PokeListUI+SearchDelegate.swift
//
//  Created by Ilham Hadi Prabawa on 10/20/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension PokeListUI: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //    interactor?.filterCards(searchText: searchText)
    pendingRequestWorkItem?.cancel()
    
    // Wrap our request in a work item
    let requestWorkItem = DispatchWorkItem { [weak self] in
      
      if searchText.isEmpty {
        self?.interactor?.removeData()
        return
      }
      
      self?.param.query = searchText
      self?.interactor?.fetchPokeList(param: self?.param)
    }
    
    // Save the new work item and execute it after 300 ms
    pendingRequestWorkItem = requestWorkItem
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300),
                                  execute: requestWorkItem)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    //    interactor?.filterCards(searchText: "")
  }
}
