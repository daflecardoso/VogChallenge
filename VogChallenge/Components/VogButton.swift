//
//  VogButton.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit

class VogButton: UIButton {
    
    var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    enum Style {
        case outlined
    }
    
    var type: Style = .outlined {
        didSet {
            update()
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        setTitleColor(.lightGray, for: .disabled)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func update() {
        switch type {
        case .outlined:
            layer.cornerRadius = 4
            layer.borderWidth = 1
            layer.borderColor = titleColor(for: .normal)?.cgColor
        }
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
