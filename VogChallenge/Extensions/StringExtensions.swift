//
//  StringExtensions.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

extension String {
    
    var url: URL {
        guard let _url = URL(string: self) else {
            fatalError("your url isn't valid")
        }
        return _url
    }
}
