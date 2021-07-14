//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit
import SafariServices

/// Search view controller
class SearchViewController: UIViewController, SFSafariViewControllerDelegate {
  
  // MARK:- Variables And Properties
  
  private let searchView = UISearchController()
  private var viewModel: SearchViewModel!
  private var timer: Timer?
  
  private enum Constants {
    static let cellIdentifier: String = "resultsCell"
    static let title: String = "Search Artist"
    static let errorMessage: String = "Unable to create result cell"
    static let detailScreenId: String = "detailScreen"
    static let placeholderText: String = "Search artist..."
  }
  
  // MARK:- IBOutlets
  
  @IBOutlet weak var resultsTableView: UITableView! {
    didSet {
      resultsTableView.dataSource = self
      resultsTableView.delegate = self
      resultsTableView.estimatedRowHeight = 54.0
      resultsTableView.rowHeight = UITableView.automaticDimension
    }
  }
  
  @IBOutlet var errorView: UIView!
  @IBOutlet var loadingView: UIView!
  @IBOutlet var emptyView: UIView!
  @IBOutlet weak var errorMsg: UILabel!
  @IBOutlet var endofResults: UIView!
  @IBOutlet var initialView: UIView!
  
  
  // MARK:- View Load
  override func viewDidLoad() {
    super.viewDidLoad()
    initializeSearchView()
    title = Constants.title
    viewModel = SearchViewModel(with: self)
  }
  
  // MARK:- Private Methods
  private func initializeSearchView() {
    searchView.obscuresBackgroundDuringPresentation = false
    searchView.searchBar.delegate = self
    searchView.searchBar.placeholder = Constants.placeholderText
    searchView.searchResultsUpdater = self
    searchView.automaticallyShowsScopeBar = false
    navigationItem.searchController = searchView
  }
  
  // MARK:- Naviagtion
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.detailScreenId {
      if let detailVC = segue.destination as? ArtistDetailViewController, let selectedIndex = resultsTableView.indexPathForSelectedRow?.row
         {
        let uniqueId = viewModel.artistId(for: selectedIndex)
        let vm = ArtistDetailViewModel(with: viewModel.businessLogic, artist: viewModel.selectedArtist(for: selectedIndex))
        detailVC.viewModel = vm
        
      }
    }
  }
}

// MARK:- Table Datasource
extension SearchViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? SearchResultTableViewCell else {
      fatalError(Constants.errorMessage)
    }
    cell.viewModel = viewModel.cellViewModel(with: indexPath.row)
    cell.accessibilityIdentifier = "\(Constants.cellIdentifier)-\(indexPath.row)"
    cell.configure()
    return cell
  }
}

// MARK:- Tableview Delegate
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.numberOfRows() - 1 {
      viewModel.loadMore()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if !viewModel.isUniqueIdAvailable(for: indexPath.row) {
      performSegue(withIdentifier: Constants.detailScreenId, sender: nil)
    } else {
      let safariVC = SFSafariViewController(url: NSURL(string: viewModel.artistDetails(for: indexPath.row))! as URL)
      present(safariVC, animated: true, completion: nil)
      safariVC.delegate = self
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

// MARK:- SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if let text = searchView.searchBar.text {
      timer?.invalidate()
      timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
        guard let self = self else {
          return
        }
        self.viewModel.searchArtist(for: text)
      })
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.clearResults()
  }
}

// MARK:- Search results updating
extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if searchView.searchBar.searchTextField.isFirstResponder {
      searchView.showsSearchResultsController = true
      searchView.searchBar.searchTextField.backgroundColor = UIColor.rwGreen().withAlphaComponent(0.1)
    } else {
      searchView.searchBar.searchTextField.backgroundColor = nil
    }
  }
}

// MARK:- SearchView delegate
extension SearchViewController: SearchViewDelegate {
  func reloadTableView() {
    resultsTableView.reloadData()
  }

  func setUpFooterView(for state: State) {
    switch state {
      case .initial:
        resultsTableView.tableFooterView = initialView
      case .error(let error):
        errorMsg.text = error.localizedDescription
        resultsTableView.tableFooterView = errorView
      case .loading:
        resultsTableView.tableFooterView = loadingView
      case .paging:
        resultsTableView.tableFooterView = loadingView
      case .empty:
        resultsTableView.tableFooterView = emptyView
      case .populated:
        resultsTableView.tableFooterView = endofResults
    }
  }
}
