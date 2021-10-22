//
//  Snackbar.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/20/21.
//

import Foundation
import UIKit

class Snackbar {
  
  weak var bottomConstraint: NSLayoutConstraint!
  weak var parent: UIViewController?
  
  var isShowing = false
  var message: String = ""
  
  lazy var label: UILabel = {
    let label = UILabel()
    label.text = message
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .white
    return label
  }()
  
  var snackView: UIView = {
    let snackView = UIView()
    snackView.translatesAutoresizingMaskIntoConstraints = false
    snackView.backgroundColor = .red
    snackView.layer.cornerRadius = 5
    return snackView
  }()
  
  func show(){
    guard let parent = parent else { return }
    
    if !parent.view.subviews.contains(snackView) {
      parent.view.addSubview(snackView)
      snackView.addSubview(label)
      
      label.snp.makeConstraints { make in
        make.center.equalTo(snackView)
      }
      
      snackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
      snackView.widthAnchor.constraint(equalTo: parent.view.widthAnchor, multiplier: 0.7).isActive = true
      snackView.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor).isActive = true
      bottomConstraint = snackView.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor, constant: 100)
      self.bottomConstraint.isActive = true
      
      parent.view.layoutIfNeeded()
    }
    
    if !isShowing {
      isShowing = true
      UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut) { [unowned self] in
        self.bottomConstraint.constant = -50
        parent.view.layoutIfNeeded()
      } completion: { [unowned self] _ in
        UIView.animate(withDuration: 0.5, delay: 2) {
          self.bottomConstraint.constant = 100
          parent.view.layoutIfNeeded()
        } completion: { [unowned self] _ in
          isShowing = false
        }
      }
    }
    
  }
  
  func setParent(_ vc: UIViewController) -> Snackbar{
    self.parent = vc
    return self
  }
  
  func setMessage(_ message: String) -> Snackbar{
    self.message = message
    return self
  }
  
}
