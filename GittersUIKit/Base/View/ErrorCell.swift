//
//  ErrorCell.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/20/21.
//

import UIKit
import SnapKit

final class ErrorData: ErrorAttribute {
  
  var imageName: String? = ""
  
  var title: String = ""
  
  var message: String = ""
  
  init(imageName: String = "", title: String, message: String){
    self.imageName = imageName
    self.title = title
    self.message = message
  }
  
  deinit {
    imageName = ""
    title = ""
    message = ""
    debug("deinit", "error data")
  }
  
}

class ErrorCell: UICollectionViewCell {
  
  static let identifier = String(describing: ErrorCell.self)
  
  var didSetupConstraints = false
  
  var tapAction: (() -> Void)?
  
  var data: ErrorAttribute? {
    didSet{
      guard let data = data else { return }
      imageView.image = UIImage(named: data.imageName ?? "")
      titleLabel.text = data.title
      descriptionLabel.text = data.message
          
      layoutIfNeeded()
    }
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleToFill
    return iv
  }()
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  var descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  lazy var button: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
    let attributedString = NSAttributedString(string: "Retry",
                                              attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                                           NSAttributedString.Key.foregroundColor: UIColor.red])
    button.setAttributedTitle(attributedString, for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.layer.cornerRadius = 3
    contentView.layer.masksToBounds = true
    
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(button)
    
    setNeedsUpdateConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    if !didSetupConstraints {
      
      imageView.snp.makeConstraints { make in
        if imageView.image == nil{
          make.size.equalTo(CGSize(width: 0, height: 0))
        }else {
          make.height.equalTo(150)
          make.width.equalTo(150)
          make.center.equalTo(self)
        }
      }
      
      titleLabel.snp.makeConstraints { make in
        make.top.equalTo(imageView.snp.bottom).inset(-8)
        make.leading.equalTo(self).inset(16)
        make.trailing.equalTo(self).inset(16)
      }
      
      descriptionLabel.snp.makeConstraints { make in
        make.top.equalTo(titleLabel.snp.bottom).inset(-8)
        make.leading.equalTo(self).inset(16)
        make.trailing.equalTo(self).inset(16)
      }
      
      button.snp.makeConstraints { make in
        make.top.equalTo(descriptionLabel.snp.bottom).inset(-8)
        make.size.equalTo(CGSize(width: 100, height: 30))
        make.centerX.equalTo(self)
      }
      
      didSetupConstraints = true
    }
    
    super.updateConstraints()
  }
  
  @objc
  func didTap(_ : UIButton){
    tapAction?()
  }
  
}
