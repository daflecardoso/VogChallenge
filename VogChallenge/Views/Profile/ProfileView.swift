//
//  ProfileView.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit

class ProfileView: UIView {
    
    private lazy var headerView = HeaderInfoView(title: "BASIC INFORMATION")
    
    private lazy var stackFields = UIStackView(arrangedSubviews: [
        VogFieldView(title: "Username"),
        VogFieldView(title: "First Name"),
        VogFieldView(title: "Last Name"),
    ]).apply {
        $0.axis = .vertical
    }
    
    private lazy var saveButton = VogButton().apply {
        $0.setTitleColor(.white, for: .normal)
        $0.title = "SAVE CHANGES"
        $0.type = .outlined
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(headerView) {
            $0.leading.trailing.top.equalToSuperview()
        }
        addSubview(stackFields) {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        addSubview(saveButton) {
            $0.top.equalTo(stackFields.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
