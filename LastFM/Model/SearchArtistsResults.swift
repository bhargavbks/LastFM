//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights    reserved.
//

import Foundation


// MARK:- Search Result Model
public struct SearchArtistResults: Decodable {
  
  // MARK:- Constants
  let total: Int
  let pages: Int
  let artists: [Artist]
  
  // MARK:- Coding Key
  enum CodingKeys: String, CodingKey {
    case total = "opensearch:totalResults"
    case artists
    case artistMatch = "artistmatches"
    case itemsPerPage = "opensearch:itemsPerPage"
  }

  enum ResultsCodingKeys: String, CodingKey {
    case result = "results"
  }
  
  enum ArtistArray: CodingKey {
    case artist
  }
  
  // MARK:- Initialization
  public init(from decoder: Decoder) throws {
    
    // Base Container
    let baseContainer = try decoder.container(keyedBy: ResultsCodingKeys.self)
    
    // Results Container
    let resultsContainer = try baseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .result)
    
    let totalResults = try resultsContainer.decode(String.self, forKey: .total)
    let itemsPerPage = try resultsContainer.decode(String.self, forKey: .itemsPerPage)
    total = Int(totalResults) ?? 0
    let noOfPages = Int(itemsPerPage) ?? 30
    pages = total/noOfPages
    
    // MatchArtists Container
    let matchArtistContainer = try resultsContainer.nestedContainer(keyedBy: ArtistArray.self, forKey: .artistMatch)
    artists = try matchArtistContainer.decode([Artist].self, forKey: .artist)
  }
}
