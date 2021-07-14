//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

public protocol ArtistResultHandler {
  var artist: Artist { get }
  var searchText: String { get }
}

extension ArtistResultHandler {
  func name() -> String {
    return artist.name
  }
}

public struct ResultsCellViewModel: ArtistResultHandler {
  
  // MARK:- Variables & Properties
  public var artist: Artist
  public var searchText: String
  
  // MARK:- Initialization
  init(with artist: Artist, searchKey: String) {
    self.artist = artist
    self.searchText = searchKey
  }
}
