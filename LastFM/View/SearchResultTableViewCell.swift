//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
  
  // MARK:- Properties
  var viewModel: ArtistResultHandler!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  // MARK:- IBOutlet
  
  @IBOutlet weak var name: UILabel!
  
  // MARK:- Methods
  
  func configure() {
    
    let initialtext = viewModel.name()
    
    let attrString: NSMutableAttributedString = NSMutableAttributedString(string: initialtext)
    
    let range = (initialtext as NSString).range(of: viewModel.searchText, options: .caseInsensitive)
    
    attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.rwGreen(), range: range)
    
    self.name.attributedText = attrString
  }
}
