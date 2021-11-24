//
//  SignInViewModelTests.swift
//  VogChallengeTests
//
//  Created by Dafle on 24/11/21.
//

import XCTest
import RxSwift
@testable import VogChallenge

class SignInViewModelTests: XCTestCase {
    
    private let disposeBag = DisposeBag()
    
    private class FakeKeyChain: KeyChainCacheContract {
        
        var _token: String?
        
        func set<T>(_ data: T, forKey: KeyChainCacheKey) where T : Decodable, T : Encodable {
            self._token = data as? String
        }
        
        func remove(forKey: KeyChainCacheKey) {
            
        }
        
        func get<T>(forKey: KeyChainCacheKey) -> T? where T : Decodable, T : Encodable {
            return "" as? T
        }
        
        func removeSignInData() {
            
        }
        
        func token() -> String {
            return _token ?? ""
        }
    }
    
    private class FakeSucessAuthService: AuthServiceContract {
        func signIn(request: SignInRequest) -> Single<SignInResponse> {
            return Single.just(SignInResponse(token: "token bearer"))
        }
    }
    
    private class FakeErrorAuthService: AuthServiceContract {
        func signIn(request: SignInRequest) -> Single<SignInResponse> {
            return Single.error(ServiceError.generic(message: "some error"))
        }
    }
    
    func testSignInSuccess() {
        let fakeKeychain = FakeKeyChain()
        
        let viewModel = SignInViewModel(authService: FakeSucessAuthService(), keychain: fakeKeychain)
        
        viewModel.signIn(request: .init(user: "fake", password: "fake"))
        
        XCTAssertEqual(fakeKeychain.token(), "token bearer")
    }
    
    func testSignInError() {
        let fakeKeychain = FakeKeyChain()
        
        let viewModel = SignInViewModel(authService: FakeErrorAuthService(), keychain: fakeKeychain)
        
        viewModel.signIn(request: .init(user: "fake", password: "fake"))
        
        XCTAssertEqual(fakeKeychain.token(), "")
    }
}
