//
//  NYArticlesTests.swift
//  NYArticlesTests
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import XCTest
@testable import NYArticles

class NYArticlesTests: XCTestCase {

    var networkClient: NetworkingClient?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        networkClient = NetworkingClient()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkClient = nil
        super.tearDown()
    }

    func testGetArticleList() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let promise = expectation(description: "Status code: 200")
        networkClient?.send(path: "emailed/7.json", method: .get, params: [:], success: { (data, json) in
            
            let decoder = JSONDecoder()
            do {
                let mostPopularData = try decoder.decode(MostPopularData.self, from: data!)
                
                if mostPopularData.status == "OK" {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(mostPopularData.status)")
                }
            } catch {
                print(error)
            }
            
        }, failure: { (error) in
            print(error)
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
