//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

protocol SearchBusinessLogicDelegate {
  func searchArtist(for key: String, page: Int, success _success: @escaping Success<SearchArtistResults>,
                    failure _failure: @escaping Failure)
  
  func getArtistDetails(for id: String, success _success: @escaping Success<ArtistDetails>,
                        failure _failure: @escaping Failure)
}

struct SearchBusinessLogic: SearchBusinessLogicDelegate {
  
  let service = HTTPService.shared
  func searchArtist(for key: String,
                    page: Int,
                    success _success: @escaping Success<SearchArtistResults>,
                    failure _failure: @escaping Failure) {
    let queryParams = ["artist" : key,
                       "page": String(page),
                       "limit": String(100)
    ]
    
    do {
      try service.requestBackend(path: .searchArtist, queryParams: queryParams, success: { response in
        _success(response)
      }, failure: { error in
        _failure(error)
      }).resume()
    } catch {
      print(error)
    }
  }
  
  func getArtistDetails(for id: String, success _success: @escaping Success<ArtistDetails>,
                        failure _failure: @escaping Failure) {
    let queryParams: QueryParameters = ["mbid" : id]
    
    do {
      try service.requestBackend(path: .artistInfo, queryParams: queryParams, success: { response in
        _success(response)
      }, failure: { error in
        _failure(error)
      }).resume()
    } catch {
      print(error)
    }
  }
}
