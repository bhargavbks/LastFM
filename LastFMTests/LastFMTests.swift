//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import XCTest
@testable import LastFM

class MockViewDelegate: SearchViewDelegate {
  func setUpFooterView(for state: State) {
  }
  
  var inReloadTableView = false
  func reloadTableView() {
    inReloadTableView = true
  }
}

class MockBusinessLogic: SearchBusinessLogicDelegate {
  var isSuccess = false
  func searchArtist(for key: String, page: Int, success _success: @escaping Success<SearchArtistResults>, failure _failure: @escaping Failure) {
    if isSuccess {
      let data = Data(StubResponse.searchResult.utf8)
      do {
        let artist = try JSONDecoder().decode(SearchArtistResults.self, from: data)
        _success(artist)
      } catch {
        print(error)
      }
    }
  }
}

class LastFMTests: XCTestCase {
  
  var testSearchViewModel: SearchViewModel!
  
  override func setUpWithError() throws {
    let delegate = MockViewDelegate()
    let mockBusinessLogic = MockBusinessLogic()
    mockBusinessLogic.isSuccess = true
    testSearchViewModel = SearchViewModel(with: delegate, for: mockBusinessLogic)
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testNumberOfRows() {
    testSearchViewModel.searchArtist(for: "Mani Sharma")
    let count = testSearchViewModel.numberOfRows()
    XCTAssertEqual(count, 2)
  }
}
