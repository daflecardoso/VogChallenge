//
//  Enviroment.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

class Environment {
    
    static let shared = Environment()
    
    private init() {}
    
    static let baseUrl = Environment.pList(key: "BASE_URL")
    
    static func pList(key: String) -> String {
        Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
    }
}
