//
//  HandleError.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import Moya

class HandleError {
    
    func handle(with error: Error) -> ServiceError {
        do {
            let response = try getResponseError(with: error)
        
            switch response.statusCode {
            case 401:
                return .expiredSession
            case 403:
                return .shouldSignIn
            case 404:
                return .generic(message: "service not found")
            default: break
            }
            
            if isValidJson(response.data) {
                
                if let jsonError = try? JSONDecoder().decode(ResponseApiError.self, from: response.data) {
                    return .generic(message: jsonError.message ?? "")
                }
              
                // HANDLE DIFFERENT TYPES OF API ERROR
                return .generic(message: "An error has occurred")
                
            } else {
                let finalError = String(data: response.data, encoding: .utf8) ?? ServiceError.invalidResponse.errorMessage
                debugPrint(finalError)
                return .generic(message: "An error has occurred, please try again")
            }
            
        } catch {
            
            if let error = error as? ServiceError {
                return error
            }
            return .generic(message: "Ops ocorreu um erro")
        }
    }
    
    private func isValidJson(_ data: Data) -> Bool {
        do {
            _ = try JSONSerialization.jsonObject(with: data, options: [])
            return true
        } catch {
            return false
        }
    }
    
    private func getResponseError(with error: Error) throws -> Response {
        
        if !Reachability.isConnectedToNetwork() {
            throw ServiceError.noInternetConnection
        }
        
        if let moyaError = error as? MoyaError, let response = moyaError.response {
            return response
        }
        
        if let error = error as? ServiceError {
            throw error
        }
        
        throw ServiceError.invalidResponse
    }
}
