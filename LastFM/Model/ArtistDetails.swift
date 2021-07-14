//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

public struct ArtistDetails: Decodable {
  
  // MARK:- Constants
  let playCount: Int?
  let listeners: Int?
  let content: String?
  
  // MARK:- Coding Key
  
  enum MainContainer: CodingKey {
    case artist
    
  }
  
  enum ArtistContainer: CodingKey {
    case bio
    case stats
  }
  
  enum BioContainer: CodingKey {
    case content
    
  }
  
  enum StatsContainer: CodingKey {
    case playcount
    case listeners
  }
  
  // MARK:- Initialization
  
  public init(from decoder: Decoder) throws {
    
    // Base Container
    let mainContainer = try decoder.container(keyedBy: MainContainer.self)
    
    // Artist Container
    let artistContainer = try mainContainer.nestedContainer(keyedBy: ArtistContainer.self, forKey: .artist)
    
    // Bio Container
    let bioContainer = try artistContainer.nestedContainer(keyedBy: BioContainer.self, forKey: .bio)
    
    content = try bioContainer.decodeIfPresent(String.self, forKey: .content)
    
    // Stats Container
    let statsContainer = try artistContainer.nestedContainer(keyedBy: StatsContainer.self, forKey: .stats)
    
    playCount = try statsContainer.decodeIfPresent(Int.self, forKey: .playcount)
    listeners = try statsContainer.decodeIfPresent(Int.self, forKey: .listeners)
  }
}
