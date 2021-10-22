//
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation

enum PokeDetailModel{
  
  struct Request{
    
    func toParam() -> [String: Any]{
      return [:]
    }
  
  }
  
//  struct Response {
//    var data: RepoDetailResponse
//  }
//
//  struct ViewModel{
//
//    var displayed: Displayed
//
//    var name: String {
//      return displayed.name
//    }
//
//    var subtype: String {
//      get {
//        let supertypes = displayed.supertypes
//        let subtypes = displayed.subtypes.joined(separator: ", ")
//        return supertypes.appending(" - \(subtypes)")
//      }
//
//    }
//
//    var attack: String {
//      get {
//        let attack = displayed.attack.joined(separator: ", ")
//        return attack.appending(" (HP \(displayed.hp))")
//      }
//    }
//
//    var flavor: String {
//      return displayed.flavor
//    }
//
//    struct Displayed{
//      let id: String
//      let name: String
//      let smalImages: URL?
//      let largeImage: URL?
//      let supertypes: String
//      let subtypes: [String]
//      let types: [String]
//      let attack: [String]
//      let hp: String
//      let flavor: String
//    }
//
//  }
  
}

struct RepoDetailModel {
  let name: String
  let avatar: URL?
  let repoURL: String
  let company: String
  let location: String
  let blog: String
  let cratedAt: String
}
