//
//  ProfileUpdateRequest.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

struct ProfileUpdateRequest: Codable {
    let firstName, lastName: String
    let userName: String?
    
    var isValid: Bool {
        return !firstName.isEmpty && !lastName.isEmpty
    }
}
