//
//  DataError.swift
//  iOS Clean Arch
//
//  Created by Ilham Hadi Prabawa on 1/15/21.
//

import Foundation

enum NError: Error {
  case unauthorized
  case internalServerError
  case responseError(message: String)
  case incompleteInput
  case sourceNotFound
  case emptyResult
  case parseError
  case undefinedError
  case connectionProblem
  case invalidUrl(url: String)
}

extension NError {
  var description: String {
    switch self {
    case .unauthorized:
      return "Ups! Your session has been expired. You'll be logged out."
    case .internalServerError:
      return "Internal Server Error, Please try again later."
    case let .responseError(message):
      return message
    case .incompleteInput:
      return "Incomplete input"
    case .undefinedError:
      return "Something went wrong"
    case .parseError:
      return "failed to parse data"
    case .sourceNotFound:
      return "Sorry Source Not Found"
    case .emptyResult:
      return "Empty Result"
    case .connectionProblem:
      return "No internet connection!"
    case .invalidUrl(let url):
      return "Invalid URL format: \(url)"
    }
  }
}
