//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

public enum PlistKey: String {
  case baseUrl = "Base_URL"
  case apiKey = "API_KEY"
}

public struct Environment {
  fileprivate var infoDict: [String: Any] {
    get {
      if let dict = Bundle.main.infoDictionary {
        return dict
      }else {
        fatalError("Plist file not found")
      }
    }
  }
  
  public func config(_ key: PlistKey) -> String {
    switch key {
      case .baseUrl:
        return infoDict[PlistKey.baseUrl.rawValue] as! String
      case .apiKey:
        return infoDict[PlistKey.apiKey.rawValue] as! String
    }
  }
}
