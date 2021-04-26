//
//  NetworkServiceTests.swift
//  Top100AlbumsTests
//
//  Created by Surendra Singh on 4/23/21.
//

import XCTest

@testable import Top100Albums
class NetworkServiceTests: XCTestCase {
    var testAPIService: NetworkService?
    
    override func setUp() {
            super.setUp()
        testAPIService = NetworkService()
        }

        override func tearDown() {
            testAPIService = nil
            super.tearDown()
        }
    
    func test_fetch_data() {
        
        guard let testService = self.testAPIService else { return }
        let expect = XCTestExpectation(description: "callback")
        
        let urlCreator = UrlCreator(host: Constants.host.rawValue)
        let urlString = urlCreator.createUrl(for: .appleMusic, feedType: .topAlbum, genre: .all, resultLimit: .Hundred, allowExplicit: .Yes, apiVersion: .apiVersion1, country: .USA)
        testService.dataRequest(with: urlString, objectType: FeedResponse.self) { (result) in
            expect.fulfill()
            switch result {
            case .success(let object):
                XCTAssertGreaterThan(object.feed.results.count, 0)
            case .failure( _): break
            }
        }
        wait(for: [expect], timeout: 60)
    }
    
}
