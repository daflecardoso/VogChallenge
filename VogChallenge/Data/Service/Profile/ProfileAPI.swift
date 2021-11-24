//
//  UserAPI.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import Moya

enum ProfileAPI {
    case profile
    case updateProfile(ProfileUpdateRequest)
    case updatePassword(ProfileUpdatePasswordRequest)
}

extension ProfileAPI: TargetType {
    
    var baseURL: URL {
        return Environment.baseUrl.url
    }
    
    var path: String {
        switch self {
        case .profile:
            return "/profiles/mine"
        case .updateProfile:
            return "/profiles/update"
        case .updatePassword:
            return "/password/change"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .profile:
            return .get
        case .updateProfile:
            return .put
        case .updatePassword:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .profile:
            return .requestPlain
        case .updateProfile(let request):
            return .requestJSONEncodable(request)
        case .updatePassword(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .profile:
            return "signin_success_response".jsonData
        case .updateProfile:
            return "signin_success_response".jsonData
        case .updatePassword:
            return "signin_success_response".jsonData
        }
    }
    
    var headers: [String : String]? {
        return ApiProvider<Self>.headers
    }
}
