//
//  AuthAPI.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import Moya

enum AuthAPI {
    case signIn(SignInRequest)
}

extension AuthAPI: TargetType {
    
    var baseURL: URL {
        return try! Environment.baseUrl.url()
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/signin"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signIn(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .signIn:
            return "signin_success_response".jsonData
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
