//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

protocol SearchViewDelegate: AnyObject {
  func reloadTableView()
  func setUpFooterView(for state: State)
}

public enum State {
  case loading
  case paging([Artist])
  case populated([Artist])
  case error(AppError)
  case empty
  case initial
  
  var currentArtists: [Artist] {
    switch self {
      case .paging(let artists):
        return artists
      case .populated(let artists):
        return artists
      default:
        return []
    }
  }
}

final class SearchViewModel {
  
  // MARK:- Constants
  enum Constants {
    static let emptyValue: String = ""
    static let total: Int = 0
    static let defaultPage: Int = 1
  }
  
  // MARK:- Variables & Properties

  private weak var delegate: SearchViewDelegate?
  public var businessLogic: SearchBusinessLogicDelegate!
  private var searchText : String = Constants.emptyValue
  private var currentPage = Constants.defaultPage
  private var total = Constants.total
  
  var state = State.initial {
    didSet {
      delegate?.setUpFooterView(for: state)
      delegate?.reloadTableView()
    }
  }
  
  // MARK:- Initialization
  
  init(with delegate: SearchViewDelegate, for businessLogic: SearchBusinessLogicDelegate = SearchBusinessLogic()) {
    self.businessLogic = businessLogic
    self.delegate = delegate
  }
  
  // MARK:- Public Methods
  
  public func searchArtist(for text: String) {
    if text.isEmpty {
      clearResults()
    } else {
      if searchText != text {
        clearResults()
      }
      searchText = text
      state = .loading
      loadData()
    }
  }
  
  public func numberOfRows() -> Int {
    return state.currentArtists.count
  }
  
  public func cellViewModel(with index: Int) -> ArtistResultHandler {
    return ResultsCellViewModel(with: state.currentArtists[index], searchKey: searchText)
  }
  
  public func artistDetails(for index: Int) -> String {
    return state.currentArtists[index].url
  }
  
  public func artistId(for index: Int) -> String {
    return state.currentArtists[index].mbid
  }
  
  public func loadMore() {
    if state.currentArtists.count < total {
      loadData()
    }
  }
  
  public func clearResults() {
    total = Constants.total
    currentPage = Constants.defaultPage
    searchText = Constants.emptyValue
    state = .initial
  }
  
  public func isUniqueIdAvailable(for id: Int) -> Bool {
    return state.currentArtists[id].mbid == ""
  }
  
  public func selectedArtist(for index: Int) -> Artist {
    return state.currentArtists[index]
  }
  
  // MARK:- Private Methods

  private func loadData() {
    businessLogic.searchArtist(for: searchText, page: currentPage, success: { [weak self] response in
      guard let self = self else {
        return
      }
      
      if response.artists.count > 0 {
        self.total = response.total
        var artists = self.state.currentArtists
        artists.append(contentsOf: response.artists)
        if self.currentPage < response.pages {
          self.currentPage += 1
          self.state = .paging(artists)
        } else {
          self.state = .populated(artists)
        }
      } else {
        self.state = .empty
      }
    }, failure: { [weak self] error in
      guard let self = self else {
        return
      }
      self.state = .error(error)
    })
  }
}
