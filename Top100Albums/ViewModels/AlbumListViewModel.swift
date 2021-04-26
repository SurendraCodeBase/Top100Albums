//
//  AlbumListViewModel.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/23/21.
//

import Foundation

class AlbumListViewModel{
    
    private var feedResponse:FeedResponse?
    
    func fetchAlbum(for mediaType:MediaType, feedType:FeedType, genre:GenreType, completionhandler:@escaping(_ error:Error?)->Void){
        let urlCreator = UrlCreator(host: Constants.host.rawValue)
        let urlString = urlCreator.createUrl(for: mediaType, feedType: feedType, genre: genre, resultLimit: .Hundred, allowExplicit: .Yes, apiVersion: .apiVersion1, country: .USA)
        let networkService = NetworkService()
        networkService.dataRequest(with: urlString, objectType: FeedResponse.self) { (result) in
            switch result {
            case .success(let object):
                self.feedResponse = object
                completionhandler(nil)
            case .failure(let error):
                completionhandler(error)
            }
        }
    }
    
    func getFeed()->Feed?{
        guard let feedResponse = self.feedResponse  else { return nil }
        return feedResponse.feed
    }
    
    func getFeedResults()->[Result]?{
        guard let feed = self.getFeed() else { return nil }
        return feed.results
    }
    
    func getFeedResultsCount()->Int{
        guard let results = self.getFeedResults() else { return 0 }
        return results.count
    }
    
    func getResult(atIndex:Int)->Result?{
        guard let results = self.getFeedResults() else { return nil }
        return results[atIndex]
    }
}
