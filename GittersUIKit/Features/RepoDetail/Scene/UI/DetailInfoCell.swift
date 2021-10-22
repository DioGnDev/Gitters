//
//  DetailCell.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/19/21.
//

import UIKit

class DetailInfoCell: UICollectionViewCell {
  
  static let identifier = String(describing: DetailInfoCell.self)
  
  var didSetupConstraints = false
  
  var data: RepoDetailModel? {
    didSet {
      guard let item = data else { return }
      nameLabel.text = item.name
      attackLabel.text = item.location
      subtypeLabel.text = item.company
      
//      let attributedText = NSMutableAttributedString(string: "Flavor :", attributes: [
//        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
//        NSAttributedString.Key.foregroundColor: UIColor.white.cgColor
//      ])
//
//      attributedText.append(NSAttributedString(string: "\n\"\(item.flavor)\"", attributes: [
//        NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16),
//        NSAttributedString.Key.foregroundColor: UIColor.white.cgColor
//      ]))
      
//      flavorLabel.attributedText = attributedText
      
    }
  }
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  let subtypeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  var attackLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  var flavorLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .white
    label.font = UIFont.italicSystemFont(ofSize: 16)
    label.textAlignment = .justified
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(nameLabel)
    addSubview(attackLabel)
    addSubview(subtypeLabel)
    addSubview(flavorLabel)
    
    setNeedsUpdateConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func updateConstraints() {
    if !didSetupConstraints {
      //setup constraint
      
      nameLabel.snp.makeConstraints { make in
        make.top.equalTo(self).inset(16)
        make.leading.equalTo(self).inset(16)
        make.trailing.equalTo(self).inset(16)
      }
      
      attackLabel.snp.makeConstraints { make in
        make.top.equalTo(nameLabel.snp.bottom).inset(-3)
        make.leading.equalTo(self).inset(16)
        make.trailing.equalTo(self).inset(16)
      }
      
      subtypeLabel.snp.makeConstraints { make in
        make.top.equalTo(attackLabel.snp.bottom).inset(-3)
        make.leading.equalTo(self).inset(16)
        make.trailing.equalTo(self).inset(16)
      }
      
      flavorLabel.snp.makeConstraints { make in
        make.top.equalTo(subtypeLabel.snp.bottom).inset(-8)
        make.leading.equalTo(self).inset(16)
        make.trailing.equalTo(self).inset(16)
        make.bottom.equalTo(self).inset(8)
      }
      
      didSetupConstraints = true
    }
    
    super.updateConstraints()
  }
  
}
