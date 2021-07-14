//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

protocol ArtistDetailDelegate {
  func startSpinner()
  func stopSpinner()
  func reloadView()
  func loadErrorScreen(with error: String)
}

final class ArtistDetailViewModel {
  
  // MARK:- Variables & Properties
  private var artistDetails: ArtistDetails?
  public var businessLogic: SearchBusinessLogicDelegate!
  public var selectedArtist: Artist!
  public var delegate: ArtistDetailDelegate?
  
  public init(with businessLogic: SearchBusinessLogicDelegate, artist: Artist) {
    self.businessLogic = businessLogic
    self.selectedArtist = artist
    fetchArtistDetails()
  }
  
  // MARK:- Private Methods
  
  func fetchArtistDetails() {
    delegate?.startSpinner()
    businessLogic.getArtistDetails(for: selectedArtist.mbid, success: { [weak self] response in
      guard let self = self else {
        return
      }
      self.artistDetails = response
      self.delegate?.reloadView()
      self.delegate?.stopSpinner()
    }, failure: { [weak self] error in
      print("Error")
      guard let self = self else {
        return
      }
      self.delegate?.loadErrorScreen(with: error.localizedDescription)
      self.delegate?.stopSpinner()
    })
  }
  
  // MARK:- Public Methods
  
  func title() -> String {
    return selectedArtist.name
  }
  
  func content() -> String? {
    return artistDetails?.content
  }
  
  func playCount() -> String? {
    guard let artistDetails = artistDetails,
          let count = artistDetails.playCount else {
      return nil
    }
    return String(count)
  }
  
  func listenersCount() -> String? {
    guard let artistDetails = artistDetails,
          let listeners = artistDetails.listeners else {
      return nil
    }
    return String(listeners)
  }
}
