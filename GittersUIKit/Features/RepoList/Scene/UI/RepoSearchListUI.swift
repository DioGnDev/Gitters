
//  Created by Ilham Hadi Prabawa on 10/18/21.


import Foundation
import UIKit
import SnapKit
import Alamofire
import MBProgressHUD

protocol RepoListDisplayLogic: BaseDisplayLogic{
  func displayPokeList()
  func showProgress()
  func hideProgress()
  func shouldShowProgress(_ state: Bool)
}

class RepoSearchListUI: UIViewController{
  
  //coordinator
  weak var coordinator: MainCoodinator?
  
  //dependency
  var interactor: RepoSearchListInteractorLogic?
  
  //state
  var param = RepoSearchListModel.Request()
  
  //MARK: - View
  
  var didSetupConstraints = false
  
  let snackbar = Snackbar()
  
//  let progressHUD: MBProgressHUD = {
//    let hud = MBProgressHUD()
//    hud.mode = .indeterminate
//    hud.label.text = "Loading..."
//    return hud
//  }()
  
  var pendingRequestWorkItem: DispatchWorkItem?
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .backgroudColor
    cv.showsVerticalScrollIndicator = false
    cv.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
    cv.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.identifier)
    return cv
  }()
  
  var loadingIndicator: UIActivityIndicatorView = {
    let aci = UIActivityIndicatorView()
    aci.color = .white
    aci.hidesWhenStopped = true
    return aci
  }()
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 20))
    searchBar.barStyle = .black
    searchBar.delegate = self
    searchBar.placeholder = "Search Repository"
    return searchBar
  }()
  
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
  
  func showProgress() {
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.mode = .indeterminate
    hud.label.text = "Please wait..."
  }
  
  func hideProgress() {
    MBProgressHUD.hide(for: self.view, animated: true)
  }
  
  func shouldShowProgress(_ state: Bool) {
    state ? showProgress() : hideProgress()
  }
  
  deinit{
    debug("deinit", String(describing: RepoSearchListUI.self))
  }
  
}
