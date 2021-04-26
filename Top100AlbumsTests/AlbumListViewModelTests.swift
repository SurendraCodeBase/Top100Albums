//
//  AlbumListViewModelTests.swift
//  Top100AlbumsTests
//
//  Created by Surendra Singh on 4/23/21.
//

import XCTest
@testable import Top100Albums

class AlbumListViewModelTests: XCTestCase {
    var testAlbumListViewModel: AlbumListViewModel?
    
    override func setUp() {
        super.setUp()
        self.testAlbumListViewModel = AlbumListViewModel()
    }
    
    override func tearDown() {
        self.testAlbumListViewModel = nil
        super.tearDown()
    }
    
    func test_fetch_album() {
        
        guard let testViewModel = self.testAlbumListViewModel else { return }
        let expect = XCTestExpectation(description: "callback")
        
        testViewModel.fetchAlbum(for: .appleMusic, feedType: .topAlbum, genre: .all, completionhandler: { (error) in
            expect.fulfill()
            XCTAssertNil(error, "Failed")
        })
    }
    
    func test_fetch_feed(){
        
        guard let testViewModel = self.testAlbumListViewModel else { return }
        let feed = testViewModel.getFeed()
        XCTAssertNil(feed, "Failed")
        
    }
}

