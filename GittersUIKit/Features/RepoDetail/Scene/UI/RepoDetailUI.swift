//

//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation
import UIKit
import MBProgressHUD

protocol RepoDetailDisplayLogic: BaseDisplayLogic{
  func displayRepoDetail(viewModel: RepoDetailModel)
  func displayRepoDetail()
  func showProgress()
  func hideProgress()
  func shouldDisplayProgress(_ state: Bool)
}

class RepoDetailUI: UIViewController{
  
  //coordinator
  weak var coordinator: MainCoodinator?
  
  //dependency
  var interactor: PokeDetailInteractorLogic?
  
  //Request param
  var param: RepoSearchListModel.Request?
  
  var didSetupConstraints = false
  
  //MARK: - View
  
  lazy var collectionView: UICollectionView = {
    let layout = StrechyHeaderLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .backgroudColor
    cv.showsVerticalScrollIndicator = false
    cv.register(HeaderView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HeaderView.identidier)
    cv.register(DefaultHeaderView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: DefaultHeaderView.identidier)
    cv.register(RecommendationContinerCell.self,
                forCellWithReuseIdentifier: RecommendationContinerCell.identifier)
    cv.register(DetailInfoCell.self, forCellWithReuseIdentifier: DetailInfoCell.identifier)
    cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default_cell")
    return cv
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    RepoDetailInjector.inject(dependencyFor: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //setup view
    self.view.backgroundColor = .white
    
    guard let card = coordinator?.card else { return }
    interactor?.fetchDetailRepo(user: card.owner)
    
    view.addSubview(collectionView)
    view.setNeedsUpdateConstraints()
    
    //show progress
    showProgress()
  }
  
  override func updateViewConstraints() {
    
    if !didSetupConstraints {
      //setup constraint
      
      collectionView.snp.makeConstraints { make in
        make.edges.equalToSuperview()
      }
      
      didSetupConstraints = true
    }
    
    super.updateViewConstraints()
  }
  
  deinit{
    coordinator = nil
    interactor = nil
    param = nil
    
    debug("deinit", String(describing: RepoDetailUI.self))
  }
  
}

extension RepoDetailUI: RepoDetailDisplayLogic {
  
  func shouldDisplayProgress(_ state: Bool) {
    state == true ? showProgress() : hideProgress()
  }
  
  
  func displayRepoDetail(viewModel: RepoDetailModel) {
    collectionView.reloadData()
  }
  
  func displayError(_ errorMessage: String?) {
    //    debug("error", errorMessage!)
    collectionView.reloadData()
  }
  
  func displayRepoDetail() {
    collectionView.reloadData()
  }
  
  func showProgress() {
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.mode = .indeterminate
    hud.label.text = "Please wait..."
  }
  
  func hideProgress() {
    MBProgressHUD.hide(for: self.view, animated: true)
  }
  
}

extension RepoDetailUI: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.section == 0 {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailInfoCell.identifier,
                                                          for: indexPath) as? DetailInfoCell,
            let interactor = interactor
      else { return UICollectionViewCell() }
      
      cell.data = interactor.getDetailModel()
      
      return cell
      
    }else if indexPath.section == 1 {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationContinerCell.identifier,
                                                          for: indexPath) as? RecommendationContinerCell,
            let interactor = interactor
      else { return UICollectionViewCell() }
      
      cell.repoList = interactor.getLists()
      
      return cell
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default_cell", for: indexPath)
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    
    if indexPath.section == 0 {
      guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: HeaderView.identidier,
                                                                       for: indexPath) as? HeaderView
      else { return  UICollectionReusableView() }
      
      view.avatar = interactor?.getDetailModel().avatar
      
      return view
      
    }else {
      guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: DefaultHeaderView.identidier,
                                                                       for: indexPath) as? DefaultHeaderView
      else { return UICollectionReusableView() }
      
      view.titleLabel.text = "User Repositories"
      
      return view
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {
    if section == 0 {
      return CGSize(width: collectionView.frame.width, height: 300)
    }else {
      return .init(width: collectionView.frame.width, height: 30)
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    guard let interactor = interactor else { return .zero}
    
    if indexPath.section == 0 {
      let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
      let dummyCell = DetailInfoCell(frame: frame)
      
      dummyCell.data = interactor.getDetailModel()
      dummyCell.layoutIfNeeded()
      
      let targetSize = CGSize(width: view.frame.width, height: 1000)
      let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
      
      return .init(width: collectionView.frame.width, height: estimatedSize.height)
      
    }else if indexPath.section == 1{
      return .init(width: view.frame.width, height: 200)
    }
    
    return .zero
    
  }
}

extension RepoDetailUI :UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 0, bottom: 16, right: 0)
  }
}
