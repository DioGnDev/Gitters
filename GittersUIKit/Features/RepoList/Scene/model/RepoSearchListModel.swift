//
//  PokeListModel.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/18/21.

import Foundation

enum Sort: String{
  
  case desc = "desc"
  case asc = "asc"
}

enum RepoSearchListModel{
  
  struct Request{
    
    var page: Int? = 1
    var pageSize: Int? = nil
    var query: String? = nil
    var sort: Sort? = .asc
    var orderBy: String? = nil
    
    func toParam() -> [String: Any]{
      var dictionary = [String: Any]()
      if let page = page {
        dictionary["page"] = page
      }
      
      if let pageSize = pageSize{
        dictionary["per_page"] = pageSize
      }
      
      if let query = query {
        dictionary["q"] = query
      }
      
      if let sort = sort {
        dictionary["sort"] = sort.rawValue
      }
      
      if let orderBy = orderBy {
        dictionary["order"] = orderBy
      }
      
      return dictionary
    }
    
  }
  
//  struct Response {
//    var lists: [RepositoryResponse]
//    let currentPage: Int
//    let count: Int
//  }
//
//  struct ViewModel{
//
//    var displayed: [Displayed]
//
//    struct Displayed{
//      let id: String
//      let name: String
//      let supertype: String
//      let subtypes: [String]
//      let type: [String]
//      let smallImage: URL?
//      let largeImage: URL?
//      let attacks: [String]
//      let hp: String
//      let flavor: String
//    }
//
//  }
  
}

struct RepositoryModel {
  let id: Int
  let owner: String
  let repo: String
  let avatarURL: URL?
  let url: URL?
  let forkCount: Int
  let issueCount: Int
  let watcherCount: Int
}
