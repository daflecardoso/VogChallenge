//
//  SignInViewModel.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel: BaseViewModel {
    
    private let authService: AuthServiceContract
    private let keychain: KeyChainCacheContract
    
    init(authService: AuthServiceContract, keychain: KeyChainCacheContract) {
        self.authService = authService
        self.keychain = keychain
    }
    
    private let _success = PublishSubject<()>()
    var success: Driver<()> {
        return _success.asDriver(onErrorJustReturn: ())
    }
    
    func signIn(request: SignInRequest) {
        authService
            .signIn(request: request)
            .loading(isLoading)
            .requesting(isRequesting)
            .subscribe(onSuccess: { [unowned self] response in
                self.keychain.set(response.token, forKey: .token)
                _success.onNext(())
            }, onFailure: handleError(error:))
            .disposed(by: disposeBag)
    }
}
