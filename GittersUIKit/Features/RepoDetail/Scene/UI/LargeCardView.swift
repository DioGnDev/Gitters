//
//  LargeCardView.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/21/21.
//

import Foundation
import UIKit

class LargeCardView: UIView {
  
  var didSetupConstraints = false
  
  var outsideTapped: (() -> Void)?
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.transform = CGAffineTransform(scaleX: 0, y: 0)
    iv.layer.cornerRadius = 5
    iv.clipsToBounds = true
    return iv
  }()
  
  lazy var containerView: UIView = {
    let cv = UIView()
    cv.backgroundColor = UIColor(white: 0, alpha: 0.63)
    cv.isUserInteractionEnabled = true
    cv.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(tapped)))
    return cv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(containerView)
    containerView.addSubview(imageView)
    
    setNeedsUpdateConstraints()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    
    if !didSetupConstraints {
      
      containerView.snp.makeConstraints { make in
        make.edges.equalTo(self)
      }
      
      imageView.snp.makeConstraints { make in
        make.centerX.equalTo(containerView.snp.centerX)
        make.height.equalTo(containerView.snp.height).multipliedBy(0.76)
        make.leading.equalTo(containerView).inset(16)
        make.trailing.equalTo(containerView).inset(16)
        make.bottom.equalTo(containerView).inset(24)
      }
      
      didSetupConstraints = true
    }
    
    super.updateConstraints()
  }
  
  func animate() {
    let fadein = CABasicAnimation(keyPath: "opacity")
    fadein.fromValue = 0
    fadein.toValue = 1.0
    fadein.duration = 0.1
    
    let scale = CABasicAnimation(keyPath: "transform.scale")
    scale.fromValue = 0
    scale.toValue = 1
    scale.duration = 0.2
    scale.beginTime = CACurrentMediaTime() + 0.3
    scale.fillMode = .both
    scale.isRemovedOnCompletion = false
    
    containerView.layer.add(fadein, forKey: "")
    imageView.layer.add(scale, forKey: "")
  }
  
  @objc
  func tapped(){
    outsideTapped?()
  }
}
