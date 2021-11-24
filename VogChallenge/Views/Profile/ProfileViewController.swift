//
//  ProfileViewController.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit

class ProfileViewController: BaseViewController {
    
    private lazy var profileView = ProfileView()
    
    private lazy var passwordView = ProfilePasswordView()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        profileView,
        passwordView
    ]).apply {
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    private lazy var scrollView = UIScrollView().apply {
        //$0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    override var baseViewModel: BaseViewModel? {
        return viewModel
    }
    
    private let viewModel: ProfileViewModel
    
    internal init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewModel.fetchProfile()
    }
    
    func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        title = "User Profile"
        view.backgroundColor = .defaultRed
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView) {
            $0.leading.trailing.bottomMargin.equalToSuperview()
            $0.topMargin.equalToSuperview().inset(16)
        }
        scrollView.addSubview(stackView) {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(1)
        }
    }
}
