//
//  AuthService.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import RxSwift

protocol AuthServiceContract {
    func signIn(request: SignInRequest) -> Single<SingInResponse>
}

class AuthService: AuthServiceContract {
    
    /**
    Stub true use mock response
     */
    private let provider = ApiProvider<AuthAPI>(stub: true)
    
    func signIn(request: SignInRequest) -> Single<SingInResponse> {
        return provider.rx.request(.signIn(request)).map(SingInResponse.self)
    }
}
