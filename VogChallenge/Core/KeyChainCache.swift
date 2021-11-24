//
//  KeyChainCache.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import Security
import SwiftKeychainWrapper

enum KeyChainCacheKey: String, CaseIterable {
    case token
}

protocol KeyChainCacheContract {
    func set<T: Codable>(_ data: T, forKey: KeyChainCacheKey)
    func remove(forKey: KeyChainCacheKey)
    func get<T: Codable>(forKey: KeyChainCacheKey) -> T?
    func removeSignInData()
    func token() -> String
}

class KeyChainCache: KeyChainCacheContract {
    
    static let shared = KeyChainCache()
    
    func set<T>(_ data: T, forKey key: KeyChainCacheKey) where T : Decodable, T : Encodable {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            let saved = KeychainWrapper.standard.set(encoded, forKey: key.rawValue)
            debugPrint(saved ? "key: \(key.rawValue) saved" : "Error to save")
        }
    }
    
    func remove(forKey key: KeyChainCacheKey) {
        KeychainWrapper.standard.removeObject(forKey: key.rawValue)
    }
    
    func get<T>(forKey key: KeyChainCacheKey) -> T? where T : Decodable, T : Encodable {
        if let savedData = KeychainWrapper.standard.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            if let item = try? decoder.decode(T.self, from: savedData) {
                return item
            }
        }
        return nil
    }
    
    func token() -> String {
        guard let token: String = self.get(forKey: .token) else {
            return ""
        }
        return token
    }
    
    func removeSignInData() {
        KeyChainCacheKey.allCases.forEach { remove(forKey: $0) }
    }
}
