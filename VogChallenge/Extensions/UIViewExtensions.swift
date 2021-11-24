//
//  UIViewExtensions.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    
    func addSubview(_ view: UIView, closure: (ConstraintMaker) -> Void) {
        self.addSubview(view)
        view.snp.makeConstraints(closure)
    }
}
