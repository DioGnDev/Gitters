//
//  ApiService.swift
//  AjaibTest
//
//  Created by Ilham Hadi Prabawa on 10/18/21.
//

import Foundation
import Alamofire

class ApiService{
  
  func request<T: Codable>(of type: T.Type,
                           with url: String,
                           withMethod method: HTTPMethod? = .get,
                           withHeaders headers: HTTPHeaders = [:],
                           withParameter parameters: Parameters = [:],
                           withEncoding encoding: ParameterEncoding? = URLEncoding.default,
                           completion: @escaping(Result<T, NError>) -> Void) {
    
    
    //Headers
    var localHeaders: HTTPHeaders = ["Accept": "application/vnd.github.v3+json"]
    
    if !headers.isEmpty {
      for (k, v) in headers.dictionary {
        localHeaders.add(name: k, value: v)
      }
    }
    
    AF.request(Environment.baseURL.appending(url),
               method: method ?? .get,
               parameters: parameters,
               encoding: encoding ?? URLEncoding.default,
               headers: localHeaders)
      .responseString(queue: DispatchQueue.main,
                      encoding: String.Encoding.utf8,
                      completionHandler: { (response) in
        
        //Log
        debug("url", String(describing: response.request))
        debug("header", String(describing: localHeaders))
        debug("params", String(describing: parameters))
        debug("statuscode", String(describing: response.response?.statusCode))
        
//        let jsonStr = String(data: response.data ?? Data(), encoding: .utf8)!
//        let pretty = jsonStr.replacingOccurrences(of: "\\", with: "")
//        debug("response", pretty)
        
        if let error = response.error {
          if error.responseCode == -1009 {
            completion(.failure(.connectionProblem))
          }else {
            completion(.failure(.undefinedError))
          }
          return
        }
        
        guard let statusCode = response.response?.statusCode else {
          completion(.failure(.undefinedError))
          return
        }
        
        if 200 ... 299 ~= statusCode  {
          //success
          guard let data = response.data else {
            completion(.failure(.undefinedError))
            return
          }
          
          //parsing json
          do {
            let json = try JSONDecoder().decode(T.self, from: data)
            completion(.success(json))
            
          } catch {
            debug("failed", error)
            completion(.failure(.parseError))
          }
          
          
        } else if statusCode == 401 {
          completion(.failure(.unauthorized))
          
        } else if statusCode == 404 {
          completion(.failure(.sourceNotFound))
          
        } else if statusCode == 500 {
          //internal server error
          completion(.failure(.internalServerError))
          
        } else {
          // throw unknown error
          
          completion(.failure(.undefinedError))
          
        }
      })
  }
  
  func parsingJSON<T>(of type: T.Type, from data: Data) -> Result<T, NError> where T: Codable{
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
      
      let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
      let model = try JSONDecoder().decode(T.self, from: jsonData)
      return .success(model)
      
    } catch let error {
      debug("error", error.localizedDescription)
    }
    
    return .failure(.parseError)
  }
  
  func loadJsonFromFile(with url: String) -> Data {
    
    guard let pathString = Bundle.main.url(forResource: url, withExtension: "json") else {
      fatalError("File not found")
    }
    
    guard let data = try? Data(contentsOf: pathString) else {
      fatalError("Unable to convert json to String")
    }
    
    return data
  }
  
}
