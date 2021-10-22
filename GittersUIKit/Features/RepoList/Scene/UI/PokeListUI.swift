//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.


import Foundation
import UIKit
import SnapKit
import Alamofire
import RxCocoa
import RxSwift

protocol RepoListDisplayLogic: BaseDisplayLogic{
  func displayPokeList()
}

class PokeListUI: UIViewController{
  
  //coordinator
  weak var coordinator: MainCoodinator?
  
  //dependency
  var interactor: PokeListInteractorLogic?
  
  //state
  var param = PokeListModel.Request()
  
  //MARK: - View
  
  var didSetupConstraints = false
  
  let snackbar = Snackbar()
  
  var pendingRequestWorkItem: DispatchWorkItem?
  
  lazy var searchController: UISearchController = {
    let sc = UISearchController()
    sc.searchBar.barStyle = .black
    sc.searchBar.delegate = self
    return sc
  }()
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .backgroudColor
    cv.showsVerticalScrollIndicator = false
    cv.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
    cv.register(FooterView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: FooterView.identifier)
    cv.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.identifier)
    //    cv.refreshControl = refreshControl
    return cv
  }()
  
  lazy var refreshControl: UIRefreshControl = {
    let rc = UIRefreshControl()
    rc.tintColor = .white
    rc.addTarget(self, action: #selector(paginateMore), for: .valueChanged)
    return rc
  }()
  
  var loadingIndicator: UIActivityIndicatorView = {
    let aci = UIActivityIndicatorView()
    aci.color = .white
    aci.hidesWhenStopped = true
    return aci
  }()
  
  lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 20))
  
  @objc
  func paginateMore() {
    refreshControl.beginRefreshing()
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    PokeListInjector.inject(dependencyFor: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard let navController = navigationController as? CustomNavigationController else { return }
    navController.tintColor = .white
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    searchBar.placeholder = "Search Repository"
    let leftNavBarButton = UIBarButtonItem(customView: searchBar)
    self.navigationItem.leftBarButtonItem = leftNavBarButton
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    view.addSubview(collectionView)
    searchBar.delegate = self
    
    updateViewConstraints()
    
    //listen network status
    NetworkManager.sharedInstance.lister = { [unowned self] status in
      switch status {
      case .active:
        debug("connection", "Online")
        break
      case .innactive:
        self.snackbar
          .setMessage("No internet connection!")
          .setParent(self).show()
        break
      }
    }
    
  }
  
  override func updateViewConstraints() {
    if !didSetupConstraints {
      
      collectionView.snp.makeConstraints { make in
        make.size.equalTo(self.view)
      }
      
      didSetupConstraints = true
    }
    
    super.updateViewConstraints()
  }
  
  deinit{
    debug("deinit", String(describing: PokeListUI.self))
  }
  
}
