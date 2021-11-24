//
//  SignInViewController.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SignInViewController: BaseViewController {
    
    private lazy var tipLabel = UILabel().apply {
        $0.text = "Remember: your user is vog and password is vog"
        $0.numberOfLines = 0
        $0.bold(in: ["user is vog", "password is vog"])
    }
    
    private lazy var userField = UITextField().apply {
        $0.placeholder = "user"
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
    }
    
    private lazy var passwordField = UITextField().apply {
        $0.placeholder = "password"
        $0.isSecureTextEntry = true
    }
    
    private lazy var signInButton = VogButton().apply {
        $0.setTitleColor(.red, for: .normal)
        $0.title = "SignIn"
        $0.rx.tap.bind { [unowned self] in
            self.viewModel.signIn(request: self.makeRequest())
        }.disposed(by: disposeBag)
    }
    
    override var requestingViews: [UIButton] {
        return [signInButton]
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        tipLabel,
        userField,
        passwordField,
        signInButton
    ]).apply {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    override var baseViewModel: BaseViewModel? {
        return viewModel
    }
    
    private let viewModel: SignInViewModel
    
    internal init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
        setupBinds()
    }
    
    private func setupView() {
        title = "SignIn"
    }
    
    private func setupConstraints() {
        view.addSubview(stackView) {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupBinds() {
        Observable.combineLatest(
            userField.rx.controlEvent(.allEvents).startWith(()),
            passwordField.rx.controlEvent(.allEvents).startWith(()))
            .map { [unowned self] _ in self.makeRequest().isValid }
            .startWith(false)
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel
            .success
            .drive(onNext: { [unowned self] in
                coordinator.navigateToHome()
            }).disposed(by: disposeBag)
    }
    
    private func makeRequest() -> SignInRequest {
        return SignInRequest(user: userField.textOrEmpty, password: passwordField.textOrEmpty)
    }
}
