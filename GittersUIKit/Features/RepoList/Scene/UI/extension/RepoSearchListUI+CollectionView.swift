//
//  PokeListUI+CollectionView.swift
//
//  Created by Ilham Hadi Prabawa on 10/20/21.
//

import Foundation
import UIKit

extension RepoSearchListUI: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let interactor = interactor else { return 0 }
    return (interactor.getCount() == 0 && !interactor.isLoadingState()) ? 1 : interactor.getCount()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if interactor!.getCount() == 0 && !interactor!.isLoadingState() {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCell.identifier, for: indexPath) as? ErrorCell
      else { return UICollectionViewCell() }
      cell.data = ErrorData(imageName: "octo",
                            title: "Search",
                            message: "searching repository")
      return cell
    }else {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell,
            let items = interactor?.getLists()
      else { return UICollectionViewCell() }
      cell.item = items[indexPath.row]
      cell.imageTapped = { url in
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
      }
      return cell
    }
    
  }
  
  //  func collectionView(_ collectionView: UICollectionView,
  //                      viewForSupplementaryElementOfKind kind: String,
  //                      at indexPath: IndexPath) -> UICollectionReusableView {
  //
  //    guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
  //                                                                     withReuseIdentifier: FooterView.identifier,
  //                                                                     for: indexPath) as? FooterView
  //    else { return UICollectionReusableView() }
  //
  //    view.addSubview(loadingIndicator)
  //    loadingIndicator.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 60)
  //
  //    return view
  //  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if interactor?.getCount() == 0 {
      return .init(width: collectionView.frame.width - (8+8+16), height: collectionView.frame.width)
    }
    
    return .init(width: collectionView.frame.width, height: 200)
    
  }
  
}

extension RepoSearchListUI: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    
    guard let interactor = interactor else { return }
    if interactor.getCount() > 0 {
      let items = interactor.getLists()
      coordinator?.card = items[indexPath.row]
      coordinator?.gotoPokeDetailCard()
    }
    
  }

}

extension RepoSearchListUI: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int) -> CGSize {
    
    return .init(width: collectionView.frame.width, height: 60)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return .init(top: 16, left: 16, bottom: 16, right: 16)
  }
  
}
