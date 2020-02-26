//
//  UrlSessionHelper.swift
//  iTunesRSSFeedExample
//
//  Created by Chidananda, Sumanth on 17/02/2020.
//  Copyright © 2020 Sumanth. All rights reserved.
//

import Foundation

final class UrlSessionHelper {
  let defaultSession = URLSession(configuration: .default)
  
  var dataTask: URLSessionDataTask?
  var errorMessage = ""
  
  typealias FeedJSON = [String: Any]
  typealias RSSFeedResponseFromAPI = ([Result]?, _ sectionTitle: String, _ errorMessage: String) -> Void
  
  func getFeeds(selectedFeedType: String, completion: @escaping RSSFeedResponseFromAPI) {
    dataTask?.cancel()
    
    let feedTypeAPIValue = feedTypeAPI(selectedFeedType: selectedFeedType)
    if var urlComponents = URLComponents(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/\(feedTypeAPIValue)/all/10/explicit.json") {
      
      guard let url = urlComponents.url else {
        return
      }
    
      dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
        defer {
          self?.dataTask = nil
        }
        
        if let error = error {
          self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
        } else if
          let jsonData = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
                        
            let decoder = JSONDecoder()
            
            let rssFeed = try? decoder.decode(Feed.self, from: jsonData)
            let feed = rssFeed?.feed
            let results = feed?.results
          
          DispatchQueue.main.async {
            completion(results, feed?.title ?? "", self?.errorMessage ?? "")
          }
        }
      }
      
      dataTask?.resume()
    }
  }
  
  private func feedTypeAPI(selectedFeedType: String) -> String {
        let feedTypeAPIDictionary = [FeedTypeListViewController.kTopAlbums:"top-albums", FeedTypeListViewController.kComingSoon:"coming-soon", FeedTypeListViewController.kHotTracks:"hot-tracks", FeedTypeListViewController.kNewReleases:"new-releases", FeedTypeListViewController.kTopSongs:"top-songs"]
        let feedAPIParameter = feedTypeAPIDictionary[selectedFeedType] ?? ""
        return feedAPIParameter
  }
}
