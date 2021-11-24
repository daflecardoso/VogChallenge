//
//  ServiceError.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

enum ServiceError: Error {
    case invalidResponse
    case expiredSession
    case shouldSignIn
    case noInternetConnection
    case generic(message: String)
    case none
}

extension ServiceError {
    var errorMessage: String {
        switch self {
        case .invalidResponse:
            return "Unable to connect to server, please try again later."
        case .expiredSession:
            return "Your session has expired."
        case .shouldSignIn:
            return "You must login again."
        case .noInternetConnection:
            return "You need to connect to the internet."
        case .generic(let message):
            return message
        case .none:
            return ""
        }
    }
}
