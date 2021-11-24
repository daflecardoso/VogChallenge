//
//  ProfileView.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProfileView: UIView {
    
    private let disposeBag = DisposeBag()
    var profile: Profile? { didSet { setupProfile() }}
    
    private let headerView = HeaderInfoView(title: "BASIC INFORMATION")
    private let userNameView = VogFieldView(title: "Username")
    private let firstNameView = VogFieldView(title: "First Name")
    private let lastNameView = VogFieldView(title: "Last Name")
    
    private lazy var stackFields = UIStackView(arrangedSubviews: [
        userNameView,
        firstNameView,
        lastNameView
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
    
    var didTapSave: ((ProfileUpdateRequest) -> Void)?
    
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
            userNameView.field.rx.controlEvent(.allEvents).startWith(()),
            firstNameView.field.rx.controlEvent(.allEvents).startWith(()),
            lastNameView.field.rx.controlEvent(.allEvents).startWith(()))
            .map { [unowned self] _ in self.makeRequest().isValid }
            .startWith(false)
            .bind(to: saveButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    private func makeRequest() -> ProfileUpdateRequest {
        return ProfileUpdateRequest(firstName: userNameView.field.textOrEmpty,
                                    lastName: lastNameView.field.textOrEmpty,
                                    userName: userNameView.field.textOrEmpty)
    }
    
    private func setupProfile() {
        userNameView.field.text = profile?.userName
        firstNameView.field.text = profile?.firstName
        lastNameView.field.text = profile?.lastName
        
        setupBinds()
    }
}
