//
//  UserService.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import RxSwift

protocol ProfileServiceContract {
    func profile() -> Single<ProfileResponse>
    func updateProfile(request: ProfileUpdateRequest) -> Single<ProfileResponse>
    func updatePassword(request: ProfileUpdatePasswordRequest) -> Single<ProfileUpdatePasswordResponse>
}

class ProfileService: ProfileServiceContract {
    
    private let provider = ApiProvider<ProfileAPI>.init()
    
    func profile() -> Single<ProfileResponse> {
        return provider.rx.request(.profile).map(ProfileResponse.self)
    }
    
    func updateProfile(request: ProfileUpdateRequest) -> Single<ProfileResponse> {
        return provider.rx.request(.updateProfile(request)).map(ProfileResponse.self)
    }
    
    func updatePassword(request: ProfileUpdatePasswordRequest) -> Single<ProfileUpdatePasswordResponse> {
        return provider.rx.request(.updatePassword(request)).map(ProfileUpdatePasswordResponse.self)
    }
}
