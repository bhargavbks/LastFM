//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
  
  // MARK:- IBOutlets
  
  @IBOutlet weak var playCountStack: UIStackView! {
    didSet{
      playCountStack.isHidden = true
    }
  }
  
  @IBOutlet weak var listenerCountStack: UIStackView! {
    didSet {
      listenerCountStack.isHidden = true
    }
  }
  
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
    didSet {
      activityIndicator.isHidden = false
    }
  }
  @IBOutlet weak var contentLabel: UILabel! {
    didSet {
      contentLabel.isHidden = true
    }
  }
  @IBOutlet weak var playCountLabel: UILabel!
  @IBOutlet weak var lisenersLabel: UILabel!
  
  // MARK:- Variables & Properties
  var viewModel: ArtistDetailViewModel!
  
  // MARK:- View load
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    self.title = viewModel.title()
  }
}

extension ArtistDetailViewController: ArtistDetailDelegate {
  func loadErrorScreen(with error: String) {
    contentLabel.text = error
    contentLabel.isHidden = false
    activityIndicator.isHidden = true
  }
  
  func startSpinner() {
    activityIndicator.startAnimating()
  }
  
  func stopSpinner() {
    activityIndicator.stopAnimating()
  }
  
  func reloadView() {
    contentLabel.text = viewModel.content()
    lisenersLabel.text = viewModel.listenersCount()
    playCountLabel.text = viewModel.playCount()
    contentLabel.isHidden = false
    playCountStack.isHidden = false
    listenerCountStack.isHidden = false
    activityIndicator.isHidden = true
  }
  
}
