//
//  ProfileViewModelTests.swift
//  VogChallengeTests
//
//  Created by Dafle on 24/11/21.
//

import XCTest
import RxSwift
@testable import VogChallenge

class ProfileViewModelTests: XCTestCase {
    
    private let disposeBag = DisposeBag()
    
    private class FakeProfileService: ProfileServiceContract {
        func profile() -> Single<ProfileResponse> {
            return Single.just(ProfileResponse.init(message: "Success get profile",
                                                    data: .init(firstName: "Vog",
                                                                userName: "voguser",
                                                                lastName: "vog lastName")))
        }
        
        func updateProfile(request: ProfileUpdateRequest) -> Single<ProfileResponse> {
            return Single.just(ProfileResponse.init(message: "Success update profile",
                                                    data: .init(firstName: "Vog updated",
                                                                userName: "voguser updated",
                                                                lastName: "vog lastName updated")))
        }
        
        func updatePassword(request: ProfileUpdatePasswordRequest) -> Single<ProfileUpdatePasswordResponse> {
            return Single.just(ProfileUpdatePasswordResponse.init(code: "123",
                                                                  message: "updated",
                                                                  exceptionName: nil))
        }
    }
    
    private class FakeErrorProfileService: ProfileServiceContract {
        func profile() -> Single<ProfileResponse> {
            return Single.error(ServiceError.none)
        }
        
        func updateProfile(request: ProfileUpdateRequest) -> Single<ProfileResponse> {
            return Single.error(ServiceError.none)
        }
        
        func updatePassword(request: ProfileUpdatePasswordRequest) -> Single<ProfileUpdatePasswordResponse> {
            return Single.error(ServiceError.none)
        }
    }
    
    func testFetchSuccessProfile() {
        let viewModel = ProfileViewModel(profileService: FakeProfileService())
        
        var profile: Profile!
        viewModel.profile.drive(onNext: { _profile in
            profile = _profile
        }).disposed(by: disposeBag)
        
        viewModel.fetchProfile()
        
        XCTAssertEqual(profile.firstName, "Vog")
        XCTAssertEqual(profile.userName, "voguser")
        XCTAssertEqual(profile.lastName, "vog lastName")
    }
    
    func testFetchErrorProfile() {
        let viewModel = ProfileViewModel(profileService: FakeErrorProfileService())
        
        var profile: Profile!
        viewModel.profile.drive(onNext: { _profile in
            profile = _profile
        }).disposed(by: disposeBag)
        
        viewModel.fetchProfile()
        
        XCTAssertNil(profile)
    }
    
    func testUpdateProfileSuccessProfile() {
        let viewModel = ProfileViewModel(profileService: FakeProfileService())
        
        var profile: Profile!
        viewModel.profile.drive(onNext: { _profile in
            profile = _profile
        }).disposed(by: disposeBag)
        
        viewModel.updateProfile(request: .init(firstName: "fake", lastName: "fake", userName: "fake"))
        
        XCTAssertEqual(profile.firstName, "Vog updated")
        XCTAssertEqual(profile.userName, "voguser updated")
        XCTAssertEqual(profile.lastName, "vog lastName updated")
    }
    
    func testUpdateProfileErrorProfile() {
        let viewModel = ProfileViewModel(profileService: FakeErrorProfileService())
        
        var profile: Profile!
        viewModel.profile.drive(onNext: { _profile in
            profile = _profile
        }).disposed(by: disposeBag)
        
        viewModel.updateProfile(request: .init(firstName: "fake", lastName: "fake", userName: "fake"))
        
        XCTAssertNil(profile)
    }
    
    func testUpdatePasswordSuccessProfile() {
        let viewModel = ProfileViewModel(profileService: FakeProfileService())
        
        var message: String!
        viewModel.passwordUpdated.drive(onNext: { _message in
            message = _message
        }).disposed(by: disposeBag)
        
        viewModel.updatePassword(request: .init(currentPassword: "", newPassword: "", passwordConfirmation: ""))
        
        XCTAssertEqual(message, "updated")
    }
    
    func testUpdatePasswordErrorProfile() {
        let viewModel = ProfileViewModel(profileService: FakeErrorProfileService())
        
        var message: String!
        viewModel.passwordUpdated.drive(onNext: { _message in
            message = _message
        }).disposed(by: disposeBag)
        
        viewModel.updatePassword(request: .init(currentPassword: "", newPassword: "", passwordConfirmation: ""))
        
        XCTAssertNil(message)
    }
}
