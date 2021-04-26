//
//  Constants.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/23/21.
//

import Foundation

enum Constants:String {
    case host = "https://rss.itunes.apple.com"
    case kNoImageKey = "NoImageAvailable"
}

enum ApiVersion:String {
    case apiVersion1 = "/api/v1"
}

enum Country:String {
    case USA = "/us"
}

enum MediaType:String {
    case appleMusic = "/apple-music"
}

enum FeedType:String {
    case topAlbum = "/top-albums"
}

enum GenreType:String {
    case all  = "/all"
}

enum ResultLimit:String {
    case Ten  = "/10"
    case TwentyFive  = "/25"
    case Fifty  = "/50"
    case Hundred  = "/100"
}

enum AllowExplicit:String {
    case Yes  = "/explicit.json"
    case No  = "/non-explicit.json"
}

enum APPError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

enum ResponseResult<T> {
    case success(T)
    case failure(APPError)
}

