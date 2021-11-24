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
    
    private let provider = ApiProvider<AuthAPI>()
    
    func signIn(request: SignInRequest) -> Single<SingInResponse> {
        return provider.rx.request(.signIn(request)).map(SingInResponse.self)
    }
}
