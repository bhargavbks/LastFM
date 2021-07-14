//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation


extension HTTPURLResponse {
  var hasSuccessStatusCode: Bool {
    return 200...299 ~= statusCode
  }
}
