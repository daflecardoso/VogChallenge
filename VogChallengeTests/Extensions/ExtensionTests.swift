//
//  ExtensionTests.swift
//  VogChallengeTests
//
//  Created by Dafle on 24/11/21.
//

import XCTest
@testable import VogChallenge

class ExtensionTests: XCTestCase {
    
    func testIsValidURL() {
        XCTAssertNotNil(try! "http://something.com".url())
    }
    
    func testInvalidURL() {
        let url = try! "anything".url()
        XCTAssertNil(url.baseURL)
    }
    
    func testResultTextTextField() {
        let label = UITextField()
        label.text = "some"
        XCTAssertEqual(label.textOrEmpty, "some")
    }
}
