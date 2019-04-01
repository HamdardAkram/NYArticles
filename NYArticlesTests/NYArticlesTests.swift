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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetArticleList() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let networkClient = NetworkingClient()
        networkClient.send(path: "emailed/7.json", method: .get, params: [:], success: { (data, json) in
            
            XCTAssertNil(data)
            
        }) { (error) in
            print(error)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
