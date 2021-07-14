//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

public typealias Headers = [String: String]
public typealias QueryParameters = [String: String]

public struct HTTPRequest {
  
  // MARK: - Properties
  
  // MARK: - Methods
  
  static func configure(for path: FmAPI,
                        queryParams parameters: QueryParameters?,
                        httpBody body: Data?,
                        method: HTTPMethod) throws -> URLRequest {
    
    guard let apiPath = path.baseURL.appendingPathComponent(path.path).absoluteString.removingPercentEncoding else {
      throw AppError.missingURL
    }
    
    let env = Environment()
    let apiKey = env.config(.apiKey)
    
    var urlComponents = URLComponents(string: apiPath)
    if method == .get {
      var defaultParameters = ["format": "json", "api_key": apiKey]
      
      if let params = parameters {
        defaultParameters = defaultParameters.merging(params, uniquingKeysWith: +)
      }
      
      let queryItems = defaultParameters.map { key, value in
        URLQueryItem(name: key, value: value)
      }
      
      urlComponents?.queryItems?.append(contentsOf: queryItems)
      
    }
    
    guard let url = urlComponents?.url else {
      throw AppError.missingURL
    }
    
    var request = URLRequest(url: url)
    if method == .post {
      request.httpBody = body
    }
    
    request.httpMethod = method.rawValue
    let appHeaders: Headers = [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
    request.allHTTPHeaderFields = appHeaders
    return request
  }
}
