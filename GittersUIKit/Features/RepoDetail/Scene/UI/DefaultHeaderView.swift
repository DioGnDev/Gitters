//
//  DefaultHeaderView.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/19/21.
//

import UIKit

class DefaultHeaderView: UICollectionReusableView {
  
  static let identidier = String(describing: DefaultHeaderView.self)
  
  var didSetupConstraints = false
  
  //MARK: - View
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(titleLabel)
    
    setNeedsUpdateConstraints()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    if !didSetupConstraints {
      //setup constraint
      
      titleLabel.snp.makeConstraints { make in
        make.leading.equalTo(self).inset(16)
      }
      
      didSetupConstraints = true
    }
    
    super.updateConstraints()
  }
}
