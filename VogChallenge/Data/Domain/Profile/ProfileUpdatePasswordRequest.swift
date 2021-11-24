//
//  ProfileUpdatePassword.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

struct ProfileUpdatePasswordRequest: Codable {
    let currentPassword, newPassword, passwordConfirmation: String
    
    var isValid: Bool {
        return newPassword == passwordConfirmation && !newPassword.isEmpty
    }
}
