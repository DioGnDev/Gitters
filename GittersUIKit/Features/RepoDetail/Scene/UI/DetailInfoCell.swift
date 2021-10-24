//
//  DetailCell.swift
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
      flavorLabel.text = item.blog
      
//      let attributedString = NSMutableAttributedString(string: "Twitter:", attributes: [
//        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
//        NSAttributedString.Key.foregroundColor: UIColor.white.cgColor
//      ])
//
//      attributedString.addAttribute(.link, value: item.blog, range: NSRange())
//      attributedString.append(NSAttributedString(string: "\n\"\(item.blog)\"", attributes: [
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
    label.numberOfLines = 0
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
        make.bottom.equalTo(flavorLabel.snp.top).inset(-8)
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

extension DetailInfoCell: UITextViewDelegate{
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    UIApplication.shared.open(URL, options: [:], completionHandler: nil)
    return false
  }
}
