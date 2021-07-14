//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights    reserved.
//

import Foundation

// MARK: - Artist
public struct Artist: Codable {
  let name, listeners, mbid: String
  let url: String
  let streamable: String
}
