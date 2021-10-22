
//
//  Created by Ilham Hadi Prabawa on 10/19/21.
//

import UIKit
import SnapKit
import SDWebImage

class HeaderView: UICollectionReusableView {
  
  static let identidier = String(describing: HeaderView.self)
  
  var didSetupConstraints = false
  
  var imageTapped: ((URL) -> Void)?
  
  var avatar: URL? {
    didSet{
      imageView.sd_setImage(with: avatar,
                            placeholderImage: UIImage(named: "empty_pokemon"))
    }
  }
  
  
  //MARK: - View
  lazy var imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.isUserInteractionEnabled = true
    iv.layer.cornerRadius = 250 / 2
    iv.layer.masksToBounds = true
    iv.clipsToBounds = true
//    iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(imageView)
    
    setNeedsUpdateConstraints()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    if !didSetupConstraints {
      //setup constraint
      
      imageView.snp.makeConstraints { make in
        make.center.equalTo(self)
        make.size.equalTo(CGSize(width: 250, height: 250))
      }
      
      didSetupConstraints = true
    }
    
    super.updateConstraints()
  }
  
}
