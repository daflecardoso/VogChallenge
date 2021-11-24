//
//  ProfileViewModel.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    
    private let profileService: ProfileServiceContract
    
    init(profileService: ProfileServiceContract) {
        self.profileService = profileService
    }
    
    private let _profile = PublishSubject<Profile?>()
    var profile: Driver<Profile?> {
        return _profile.asDriver(onErrorJustReturn: nil)
    }
    
    private let _passwordUpdated = PublishSubject<String?>()
    var passwordUpdated: Driver<String?> {
        return _passwordUpdated.asDriver(onErrorJustReturn: nil)
    }
    
    func fetchProfile() {
        profileService
            .profile()
            .loading(isLoading)
            .subscribe(onSuccess: { [unowned self] profileResponse in
                self._profile.onNext(profileResponse.data)
            }, onFailure: handleError(error:))
            .disposed(by: disposeBag)
    }
    
    func updateProfile(request: ProfileUpdateRequest) {
        profileService
            .updateProfile(request: request)
            .loading(isLoading)
            .subscribe(onSuccess: { [unowned self] profileResponse in
                self._profile.onNext(profileResponse.data)
            }, onFailure: handleError(error:))
            .disposed(by: disposeBag)
    }
    
    func updatePassword(request: ProfileUpdatePasswordRequest) {
        profileService
            .updatePassword(request: request)
            .loading(isLoading)
            .subscribe(onSuccess: { [unowned self] response in
                self._passwordUpdated.onNext(response.message)
            }, onFailure: handleError(error:))
            .disposed(by: disposeBag)
    }
}
