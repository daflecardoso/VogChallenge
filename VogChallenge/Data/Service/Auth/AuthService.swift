//
//  AuthService.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import RxSwift

protocol AuthServiceContract {
    func signIn(request: SignInRequest) -> Single<SignInResponse>
}

class AuthService: AuthServiceContract {
    
    /**
    Stub true use mock response
     */
    private let provider = ApiProvider<AuthAPI>(stub: true)
    
    func signIn(request: SignInRequest) -> Single<SignInResponse> {
        return provider.rx.request(.signIn(request)).map(SignInResponse.self)
    }
}
