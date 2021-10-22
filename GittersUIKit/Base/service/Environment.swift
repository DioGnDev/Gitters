//
//  Environment.swift
//  TheMoviee
//
//  Created by Ilham Hadi Prabawa on 2/23/21.
//

import Foundation
import UIKit

public enum Environment {
  
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()
  
  static let baseURL: String = {
    guard let url = infoDictionary["BaseURL"] as? String else { return "" }
    return url
  }()
  
  static let apiKey: String = {
    guard let apiKey = infoDictionary["Api-Key"] as? String else { return "" }
    return apiKey
  }()
  
}
