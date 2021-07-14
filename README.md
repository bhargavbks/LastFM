# Mobile Developer Practical Test
## Brief: Develop a music search app using last.fm’s API.

We would like you to create a basic, search, results, detail type application using LastFM’s API. This app will make a network request based on the search information, parse the response and show a results page, which can then drill down a level in the details of a selected item.

## Features
At a minimum your app should contain:
- Search – using the API pick from EITHER, Album, Song or Artist
- Results – Display the results with minimal detail
- Detail – On selecting an item from the result – the Detail view is presented, this should contain the basic information about from the result, you don’t need to include a everything from the returned values, but enough to show an expanded amount of info compared to the results view.

## Solution
I choose the option to search artist, to implement the solution for now, but we can easily extend this to implement alubm search and other varites of search feature easily. I have choosen MVVM design pattern to implenet the base structure of the application which gives us flexibilty to implement to decoupling of UI and business logic, the MVVM design pattern results in more flexible and easier-to-read classes. To the detail screen I had choose to display it in Safari view controller because, not all the results has mbid, without it we can't get more details.

