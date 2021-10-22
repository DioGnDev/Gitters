//
//  RecommendationContinerCell.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/19/21.
//

import UIKit
import SnapKit

protocol RecommendationDelegate: AnyObject{
  func loadMore()
}

class RecommendationContinerCell: UICollectionViewCell {
  
  static let identifier = String(describing: RecommendationContinerCell.self)
  
  var didSetupConstraints = false
  
  weak var delegate: RecommendationDelegate?
  
  var model: RepoDetailModel? {
    didSet{
      isError ? indicator.stopAnimating() : indicator.startAnimating()
      collectionView.isScrollEnabled = !isError
      collectionView.reloadData()
    }
  }

  var isLoading = false
  var isError = false
  var repoList: [RepositoryModel] = [] {
    didSet{
      collectionView.reloadData()
    }
  }
  
  //MARK: - View
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .backgroudColor
    cv.showsHorizontalScrollIndicator = false
    cv.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    cv.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
    cv.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.identifier)
    cv.register(FooterView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: FooterView.identifier)
    return cv
  }()
  
  var indicator: UIActivityIndicatorView = {
    let aci = UIActivityIndicatorView()
    aci.color = .white
    aci.hidesWhenStopped = true
    return aci
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(collectionView)
    setNeedsUpdateConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    if !didSetupConstraints {
      
      collectionView.snp.makeConstraints { make in
        make.size.equalTo(self)
      }
      
      didSetupConstraints = true
    }
    
    super.updateConstraints()
  }
  
}

extension RecommendationContinerCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return repoList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell
    else { return UICollectionViewCell() }
    
    cell.item = repoList[indexPath.row]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    
    guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                     withReuseIdentifier: FooterView.identifier,
                                                                     for: indexPath) as? FooterView
    else { return UICollectionReusableView() }
    
    view.addSubview(indicator)
    indicator.frame = CGRect(x: 0, y: 0, width: 50, height: collectionView.frame.height)
    
    return view
  }
  
}

extension RecommendationContinerCell: UICollectionViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetX = scrollView.contentOffset.x
    let rightBounds = scrollView.contentSize.width - scrollView.frame.size.width
    
    if offsetX > rightBounds {
      indicator.startAnimating()
      delegate?.loadMore()
    }
    
  }
  
}

extension RecommendationContinerCell: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return .init(width: frame.width - 30, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int) -> CGSize {
    
    return .init(width: 50, height: collectionView.frame.height)
  }
}
