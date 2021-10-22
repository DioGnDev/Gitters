//
//  NetworkReachabilityManager.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/20/21.
//

import Foundation
import Alamofire

enum ConnectionStatus {
  case active
  case innactive
}

protocol NetworkManagerProtocol{
  func startListening()
  func stopListening()
  var lister: ((ConnectionStatus) -> Void)? { get }
}

class NetworkManager: NetworkManagerProtocol {
  
  var lister: ((ConnectionStatus) -> Void)?
  
  static let sharedInstance = NetworkManager()
  
  let manager = NetworkReachabilityManager(host: "www.apple.com")
  
  func startListening(){
    manager?.startListening { [unowned self] status in
      switch status {
      case .notReachable:
        lister?(.innactive)
        debug("connection", "no connection")
      case .reachable:
        lister?(.active)
        debug("connection", "connected to internet")
      case .unknown:
        lister?(.innactive)
      }
    }
  }
  
  func stopListening(){
    manager?.stopListening()
  }
  
}
