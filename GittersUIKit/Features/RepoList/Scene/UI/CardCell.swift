//
//
//  Created by Ilham Hadi Prabawa on 10/19/21.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class CardCell: UICollectionViewCell{
  
  static let identifier = String(describing: CardCell.self)
  
  var imageTapped: ((URL?) -> Void)?
  
  var item: RepositoryModel? {
    didSet{
      guard let model = item else { return }
      imageView.sd_setImage(with: model.avatarURL, placeholderImage: UIImage(named: ""))
      ownerLabel.text = model.owner
      repoNameLabel.text = model.repo
      watcherLabel.text = String(describing: model.watcherCount)
      forkLabel.text = String(describing: model.forkCount)
      issusLabel.text = String(describing: model.issueCount)
      
      if model.watcherCount > 1 {
        watcherTitleLabel.text = "Watchers"
      }
      
      if model.forkCount > 1 {
        forkTitleLabel.text = "Forks"
      }
      
      if model.issueCount > 1 {
        issuesTitleLabel.text = "Issues"
      }
      
    }
  }
  
  let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.layer.cornerRadius = 10
    view.clipsToBounds = true
    return view
  }()
  
  let repoNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textColor = .white
    label.numberOfLines = 2
    return label
  }()
  
  let ownerLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .white
    return label
  }()
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.layer.cornerRadius = 60 / 2
    iv.clipsToBounds = true
    iv.isUserInteractionEnabled = true
    return iv
  }()
  
  let wathcerImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "eye")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  let forkImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "eye")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  let issueImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "issue")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  let watcherTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Watchers"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .white
    label.numberOfLines = 2
    return label
  }()
  
  let watcherLabel: UILabel = {
    let label = UILabel()
    label.text = "3"
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .white
    label.numberOfLines = 2
    return label
  }()
  
  let forkTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Fork"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .white
    return label
  }()
  
  let forkLabel: UILabel = {
    let label = UILabel()
    label.text = "3"
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .white
    label.numberOfLines = 2
    return label
  }()
  
  let issuesTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Issues"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .white
    return label
  }()
  
  let issusLabel: UILabel = {
    let label = UILabel()
    label.text = "4"
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .white
    label.numberOfLines = 2
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    contentView.layer.cornerRadius = 3
    contentView.layer.masksToBounds = true
    contentView.addSubview(containerView)
    containerView.addSubview(imageView)
    containerView.addSubview(repoNameLabel)
    containerView.addSubview(ownerLabel)
    containerView.addSubview(watcherLabel)
    containerView.addSubview(forkLabel)
    containerView.addSubview(issusLabel)
    containerView.addSubview(watcherTitleLabel)
    containerView.addSubview(forkTitleLabel)
    containerView.addSubview(issuesTitleLabel)
    
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
    
    containerView.snp.makeConstraints { make in
      make.edges.equalTo(contentView).inset(16)
    }
  
    imageView.snp.makeConstraints { make in
      make.size.equalTo(CGSize(width: 60, height: 60))
      make.leading.equalTo(containerView).inset(16)
      make.top.equalTo(containerView).inset(16)
    }
    
    repoNameLabel.snp.makeConstraints { make in
      make.top.equalTo(containerView).inset(24)
      make.leading.equalTo(imageView.snp.trailing).inset(-16)
      make.trailing.equalTo(containerView).inset(16)
    }
    
    ownerLabel.snp.makeConstraints { make in
      make.top.equalTo(repoNameLabel.snp.bottom)
      make.leading.equalTo(imageView.snp.trailing).inset(-16)
    }
    
    watcherTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(ownerLabel.snp.bottom).inset(-16)
      make.leading.equalTo(imageView.snp.trailing).inset(-16)
    }
    
    forkTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(ownerLabel.snp.bottom).inset(-16)
      make.leading.equalTo(watcherTitleLabel.snp.trailing).inset(-20)
    }
    
    issuesTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(ownerLabel.snp.bottom).inset(-16)
      make.leading.equalTo(forkTitleLabel.snp.trailing).inset(-20)
    }
    
    watcherLabel.snp.makeConstraints { make in
      make.top.equalTo(watcherTitleLabel.snp.bottom).inset(-8)
      make.centerX.equalTo(watcherTitleLabel.snp.centerX)
    }
    
    forkLabel.snp.makeConstraints { make in
      make.top.equalTo(forkTitleLabel.snp.bottom).inset(-8)
      make.centerX.equalTo(forkTitleLabel.snp.centerX)
    }
    
    issusLabel.snp.makeConstraints { make in
      make.top.equalTo(issuesTitleLabel.snp.bottom).inset(-8)
      make.centerX.equalTo(issuesTitleLabel.snp.centerX)
    }
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  func didTapImage(){
    imageTapped?(item?.url)
  }
  
}
