//
//  File.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

struct ProfileUpdatePasswordResponse: Decodable {
    let code: String
    let message: String
    let exceptionName: String?
}
