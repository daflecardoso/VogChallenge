//
//  CustomLoadingView.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit

class CustomLoadingView: UIView {
    
    private let indicator = UIActivityIndicatorView().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.hidesWhenStopped = true
        $0.style = .whiteLarge
        $0.color = .wb
    }
    
    private let margin: CGFloat = 16
    override var isHidden: Bool {
        didSet {
            if isHidden {
                indicator.stopAnimating()
            } else {
                indicator.startAnimating()
            }
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.setup()
    }
    
    private func setup() {
        backgroundColor = .headerNavigationTint
        layer.cornerRadius = Constants.cardRadius
    
        addSubview(indicator)
        addConstraints([
            indicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            indicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            indicator.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            indicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin)
        ])
    }
}
