//
//  DomainTests.swift
//  VogChallengeTests
//
//  Created by Dafle on 24/11/21.
//

import XCTest
@testable import VogChallenge

class DomainTests: XCTestCase {
    
    func testInvalidSignInRequest() {
        let request = SignInRequest(user: "", password: "")
        XCTAssertFalse(request.isValid)
    }
    
    func testValidSignInRequest() {
        let request = SignInRequest(user: "anything", password: "anything")
        XCTAssertTrue(request.isValid)
    }
    
    func testInvalidProfileUpdateRequest() {
        let request = ProfileUpdateRequest(firstName: "", lastName: "", userName: nil)
        XCTAssertFalse(request.isValid)
    }
    
    func testValidProfileUpdateRequest() {
        let request = ProfileUpdateRequest(firstName: "some", lastName: "some", userName: nil)
        XCTAssertTrue(request.isValid)
    }
    
    func testInvalidUpdatePasswordRequest() {
        let request = ProfileUpdatePasswordRequest(currentPassword: "", newPassword: "", passwordConfirmation: "")
        XCTAssertFalse(request.isValid)
    }
    
    func testInvalidDifferentUpdatePasswordRequest() {
        let request = ProfileUpdatePasswordRequest(currentPassword: "",
                                                   newPassword: "something",
                                                   passwordConfirmation: "anything")
        XCTAssertFalse(request.isValid)
    }
    
    func testValidUpdatePasswordRequest() {
        let request = ProfileUpdatePasswordRequest(currentPassword: "",
                                                   newPassword: "some",
                                                   passwordConfirmation: "some")
        XCTAssertTrue(request.isValid)
    }
}
