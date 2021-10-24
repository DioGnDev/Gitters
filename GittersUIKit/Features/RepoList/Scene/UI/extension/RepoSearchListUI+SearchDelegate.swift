//
//
//  Created by Ilham Hadi Prabawa on 10/20/21.
//

import Foundation
import UIKit

extension RepoSearchListUI: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    pendingRequestWorkItem?.cancel()
    
    // Wrap our request in a work item
    let requestWorkItem = DispatchWorkItem { [weak self] in
      
      if searchText.isEmpty {
        self?.interactor?.removeData()
        return
      }
      
      self?.param.query = searchText
      self?.interactor?.searchRepoList(param: self?.param)
    }
    
    // Save the new work item and execute it after 200 ms
    pendingRequestWorkItem = requestWorkItem
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200),
                                  execute: requestWorkItem)
  }
  
}
