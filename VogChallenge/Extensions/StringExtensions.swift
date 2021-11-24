//
//  StringExtensions.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

extension String {
    
    func url() throws -> URL {
        guard let _url = URL(string: self) else {
            throw ServiceError.generic(message: "your url isn't valid")
        }
        return _url
    }
    
    var jsonData: Data {
        guard let path = Bundle.main.path(forResource: self, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return Data()
        }
        return data
    }
}
