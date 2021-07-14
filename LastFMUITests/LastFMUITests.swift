//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import XCTest

class LastFMUITests: XCTestCase {
  
  let app = XCUIApplication()
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app.launch()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testMusicSearch() {
    XCTContext.runActivity(named: "Music Search", block: {_ in
      XCTAssertTrue(app.navigationBars["Search Artist"].exists, "Title of the screen exists")
    })
    
    XCTContext.runActivity(named: "Test Search", block: {_ in
      let searchBar = app.searchFields.firstMatch
      XCTAssertTrue(searchBar.exists)
    })
    
    XCTContext.runActivity(named: "Edit search", block: { _ in
      let searchBar = app.searchFields.firstMatch
      searchBar.tap()
      searchBar.typeText("Fsdfsdfsdf")
      let tableView = app.tables.firstMatch
      let cell = tableView.cells["resultsCell-0"]
      XCTAssert(cell.waitForExistence(timeout: 3))
    })
    
    XCTContext.runActivity(named: "FooterView for end of results", block: { _ in
      
      let footerView = app.staticTexts["Thanks, above are the results all we have for you!"].firstMatch
      XCTAssert(footerView.waitForExistence(timeout: 3))
    })
    
    XCTContext.runActivity(named: "Clear text", block: { _ in
      let searchBar = app.searchFields.firstMatch
      searchBar.buttons["Clear text"].tap()
      let footerView = app.staticTexts["Search for artists"].firstMatch
      XCTAssert(footerView.waitForExistence(timeout: 3))
    })
    
    XCTContext.runActivity(named: "Zero results", block: { _ in
      let searchBar = app.searchFields.firstMatch
      searchBar.tap()
      searchBar.typeText("sdfdsfdsfdsfdsf")
      let footerView = app.staticTexts["No results! Try searching for something different."].firstMatch
      XCTAssert(footerView.waitForExistence(timeout: 3))
    })
  }
  
  func swipeUpUntilElementFound(element : XCUIElement, maxNumberOfSwipes : UInt) -> Bool{
    if element.exists{
      return true
    }
    else {
      for _ in 1...maxNumberOfSwipes{
        app.swipeUp()
        if element.exists{
          return true
        }
      }
      return false
    }
  }
}
