//
//  CustomNavigationController.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/19/21.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
  
  var backImage = UIImage(named: "ic_back")
  
  var tintColor: UIColor = .white
  
  var barStyle: UIBarStyle = .black
  
  var barColor: UIColor = .navigationColor
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return  (barColor == .white) ? .default : .lightContent
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setupNavBarAppearance()
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    setupNavBarAppearance()
  }
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    
    setupNavBarAppearance()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupNavBarAppearance(){
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithDefaultBackground()
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
      navBarAppearance.backgroundColor = barColor
      navBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
      
      navigationBar.barStyle = barStyle
      navigationBar.tintColor = tintColor
      navigationBar.standardAppearance = navBarAppearance
      navigationBar.scrollEdgeAppearance = navBarAppearance
      
      return
    }
    
    //MARK: iOS 12 navigation setup
    let navControl = UINavigationBar.appearance()
    navControl.tintColor = .white
    navControl.barTintColor = barColor
    
    navigationBar.barStyle = barStyle
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationBar.tintColor = tintColor
    navigationBar.backIndicatorImage = backImage
    navigationBar.backIndicatorTransitionMaskImage = backImage
    
  }
  
  func toggleTabBar(shouldShow: Bool){
    self.tabBarController?.tabBar.isHidden = !shouldShow
  }
}
