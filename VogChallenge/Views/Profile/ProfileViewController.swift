//
//  ProfileViewController.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

class ProfileViewController: BaseViewController {
    
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
    }
    
    private func setupConstraints() {
        
    }
}
