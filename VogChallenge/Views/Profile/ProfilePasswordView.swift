//
//  ProfilePasswordView.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProfilePasswordView: UIView {
    
    private let disposeBag = DisposeBag()
    private let headerView = HeaderInfoView(title: "PASSWORD")
    private let newPasswordView = VogFieldView(title: "New Password", isSecure: true)
    private let confirmPasswordView = VogFieldView(title: "Re-enter Password", isSecure: true)
    
    private lazy var stackFields = UIStackView(arrangedSubviews: [
        newPasswordView,
        confirmPasswordView
    ]).apply {
        $0.axis = .vertical
    }
    
    private lazy var saveButton = VogButton().apply {
        $0.setTitleColor(.white, for: .normal)
        $0.title = "SAVE CHANGES"
        $0.type = .outlined
        $0.rx.tap.bind { [unowned self] in
            self.didTapSave?(self.makeRequest())
        }.disposed(by: disposeBag)
    }
    
    var didTapSave: ((ProfileUpdatePasswordRequest) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupConstraints()
        setupBinds()
    }
    
    private func setupConstraints() {
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
    
    private func setupBinds() {
        Observable.combineLatest(
            newPasswordView.field.rx.controlEvent(.allEvents).startWith(()),
            confirmPasswordView.field.rx.controlEvent(.allEvents).startWith(()))
            .map { [unowned self] _ in self.makeRequest().isValid }
            .startWith(false)
            .bind(to: saveButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func makeRequest() -> ProfileUpdatePasswordRequest {
        return ProfileUpdatePasswordRequest(
            currentPassword: "",
            newPassword: newPasswordView.field.textOrEmpty,
            passwordConfirmation: confirmPasswordView.field.textOrEmpty)
    }
}
