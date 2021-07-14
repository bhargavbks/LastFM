//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import XCTest
@testable import LastFM

class SearchArtistResultTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testSuccessResponse() throws {
    let data = Data(StubResponse.searchResult.utf8)
    let artist = try JSONDecoder().decode(SearchArtistResults.self, from: data)
    XCTAssertEqual(artist.pages, 142)
    XCTAssertEqual(artist.total, 284)
    XCTAssertEqual(artist.artists.count, 2)
  }
  
  func testFailureResponse() throws {
    let data = Data(StubResponse.failureSearchResult.utf8)
    XCTAssertThrowsError(try JSONDecoder().decode(SearchArtistResults.self, from: data)) { error in
      if case .keyNotFound(let key, _)? = error as? DecodingError {
        XCTAssertEqual("name", key.stringValue)
      } else {
        XCTFail("Expected '.keyNotFound' but got \(error)")
      }
    }
  }
}
