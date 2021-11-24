//
//  UILabelExtensions.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit

extension UILabel {
    
    func bold(in pieces: [String], font: UIFont = .systemFont(ofSize: 16, weight: .bold)) {
        let text = self.text ?? ""
        self.attributedText = NSMutableAttributedString(string: text).apply(closure: { attributed in
            pieces.forEach { boldTitle in
                let range = (text as NSString).range(of: boldTitle)
                attributed.addAttribute(.font, value: font, range: range)
            }
        })
    }
}
