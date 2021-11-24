//
//  User.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

struct ProfileResponse: Decodable {
    let message: String
    let data: Profile
}

struct Profile: Decodable {
    let firstName: String
    let userName: String?
    let lastName: String
}

