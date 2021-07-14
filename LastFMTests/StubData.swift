//
// Copyright (c) 2021 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//

import Foundation

enum StubResponse {
  static let searchResult = """
    {
    "results": {
    "opensearch:Query": {
    "#text": "",
    "role": "request",
    "searchTerms": "Mani Sharma",
    "startPage": "1"
    },
    "opensearch:totalResults": "284",
    "opensearch:startIndex": "0",
    "opensearch:itemsPerPage": "2",
    "artistmatches": {
    "artist": [
    {
    "name": "Mani Sharma",
    "listeners": "4967",
    "mbid": "b47aab00-7ce6-459c-b31e-1ce667481922",
    "url": "https://www.last.fm/music/Mani+Sharma",
    "streamable": "0",
    "image": [
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "small"
    },
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "medium"
    },
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "large"
    },
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "extralarge"
    },
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "mega"
    }
    ]
    },
    {
    "name": "Mani Sharma & Amit Heri w. Bombay Jayashree",
    "listeners": "157",
    "mbid": "",
    "url": "https://www.last.fm/music/Mani+Sharma+&+Amit+Heri+w.+Bombay+Jayashree",
    "streamable": "0",
    "image": [
    {
    "#text": "",
    "size": "small"
    },
    {
    "#text": "",
    "size": "medium"
    },
    {
    "#text": "",
    "size": "large"
    },
    {
    "#text": "",
    "size": "extralarge"
    },
    {
    "#text": "",
    "size": "mega"
    }
    ]
    }
    ]
    },
    "@attr": {
    "for": "Mani Sharma"
    }
    }
    }
    """
  
  static let failureSearchResult = """
    {
    "results": {
    "opensearch:Query": {
    "#text": "",
    "role": "request",
    "searchTerms": "Mani Sharma",
    "startPage": "1"
    },
    "opensearch:totalResults": "284",
    "opensearch:startIndex": "0",
    "opensearch:itemsPerPage": "2",
    "artistmatches": {
    "artist": [
    {
    "listeners": "4967",
    "mbid": "b47aab00-7ce6-459c-b31e-1ce667481922",
    "url": "https://www.last.fm/music/Mani+Sharma",
    "streamable": "0",
    "image": [
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "small"
    },
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "medium"
    },
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "large"
    },
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "extralarge"
    },
    {
    "#text": "https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png",
    "size": "mega"
    }
    ]
    },
    {
    "name": "Mani Sharma & Amit Heri w. Bombay Jayashree",
    "listeners": "157",
    "mbid": "",
    "url": "https://www.last.fm/music/Mani+Sharma+&+Amit+Heri+w.+Bombay+Jayashree",
    "streamable": "0",
    "image": [
    {
    "#text": "",
    "size": "small"
    },
    {
    "#text": "",
    "size": "medium"
    },
    {
    "#text": "",
    "size": "large"
    },
    {
    "#text": "",
    "size": "extralarge"
    },
    {
    "#text": "",
    "size": "mega"
    }
    ]
    }
    ]
    },
    "@attr": {
    "for": "Mani Sharma"
    }
    }
    }
    """
  
  static let missingKey = """
    {
    "error": 10,
    "message": "Invalid API key - You must be granted a valid key by last.fm"
    }
    """
}
