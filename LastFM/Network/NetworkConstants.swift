//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

// MARK:- HTTP Methods
public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
}

// MARK:- EndPoint
public protocol EndpointType {
  
  var baseURL: URL { get }
  var path: String { get }
}

// MARK:- LastFm api's
public enum FmAPI {
  case searchArtist
  case artistInfo
}

extension FmAPI: EndpointType {
  public var baseURL: URL {
    let env = Environment()
    return URL(string: "\(env.config(.baseUrl))")!
  }
  
  public var path: String {
    switch self {
      case .searchArtist:
        return "?method=artist.search"
      case .artistInfo:
        return "?method=artist.getinfo"
    }
  }
}


public enum AppError: Int, Error {
  case inValidService = 2
  case inValidMethod = 3
  case authenticationFailed = 4
  case invalidFormat = 5
  case invalidParameters = 6
  case invalidApiKey = 10
  case badRequest = 400
  case unAuthorised = 401
  case forbidden = 403
  case notFound = 405
  case requestTimeOut = 408
  case internalServerError = 500
  case badGateway = 502
  case serviceUnavailable = 503
  case gatewayTimeOut = 504
  case missingURL = 1000
  case missingHeaders = 1001
  case missingParameters = 1002
  case dataFormatError = 1003
  case encodingFailed = 1004
  case problemWithRequest = 1005
  case unknown = 1006
  
  init(with error: NSError) {
    self = AppError(rawValue: error.code) ?? .unknown
  }
  
  init(response: URLResponse?) {
    if let response = response as? HTTPURLResponse {
      self = AppError(rawValue: response.statusCode) ?? .unknown
    } else {
      self = .unknown
    }
  }
  
  var localizedDescription: String {
    switch self {
      case .inValidService:
        return "This service does not exist"
      case .inValidMethod:
        return "No method with that name in this package"
      case .authenticationFailed:
        return "You do not have permissions to access the service"
      case .invalidFormat:
        return "This service doesn't exist in that format"
      case .invalidParameters:
        return "Your request is missing a required parameter"
      case .badRequest:
        return "Bad request!"
      case .unAuthorised:
        return "Authentication Error Occurred!"
      case .forbidden:
        return "Request forbidden!"
      case .notFound:
        return "Problem with server!"
      case .requestTimeOut:
        return "Connection timed out!"
      case .internalServerError, .badGateway, .serviceUnavailable, .gatewayTimeOut:
        return "Sorry, couldn't reach servers!"
      case .encodingFailed:
        return "Problem in encoding headers & parameters"
      case .missingURL:
        return "Url is missing."
      case .missingHeaders:
        return "Headers are missing."
      case .missingParameters:
        return "Paramters are missing."
      case .dataFormatError:
        return "Problem in formating data."
      default:
        return "Sorry, couldn't reach servers!"
    }
  }
}


enum DataResponseError: Error {
  case network
  case decoding
  
  var reason: String {
    switch self {
      case .network:
        return "An error occurred while fetching data "
      case .decoding:
        return "An error occurred while decoding data"
    }
  }
}
