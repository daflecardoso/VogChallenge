//
//  ResponseApiError.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

struct ResponseApiError: Decodable {
    let code: String
    let message: String?
}
