//
//  UrlCreator.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/23/21.
//

import Foundation

struct UrlCreator {
    private var host = Constants.host.rawValue
    
    init (host:String){
        self.host = host
    }
    func createUrl(for mediaType:MediaType, feedType:FeedType, genre:GenreType, resultLimit:ResultLimit, allowExplicit:AllowExplicit, apiVersion:ApiVersion, country:Country) -> String {
        
        //Format
        //https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/non-explicit.json
        var urlString = self.host
        urlString = urlString + apiVersion.rawValue
        urlString = urlString + country.rawValue
        urlString = urlString + mediaType.rawValue
        urlString = urlString + feedType.rawValue
        urlString = urlString + genre.rawValue
        urlString = urlString + resultLimit.rawValue
        urlString = urlString + allowExplicit.rawValue
        return urlString
    }
}
