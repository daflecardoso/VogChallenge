//
//  VogField.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit

class VogFieldView: UIView {
    
    private lazy var titleLabel = UILabel().apply {
        $0.text = title
    }
    
    lazy var field = UITextField().apply {
        $0.placeholder = title
        $0.autocorrectionType = .no
        $0.isSecureTextEntry = isSecure
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, field]).apply {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    private let title: String
    private let isSecure: Bool
    
    init(title: String, isSecure: Bool = false) {
        self.title = title
        self.isSecure = isSecure
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(stackView) {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}

