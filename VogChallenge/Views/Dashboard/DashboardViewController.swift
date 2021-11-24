//
//  DashboardViewController.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation

class DashboardViewController: BaseViewController {
    
    private lazy var profileButton = VogButton().apply {
        $0.title = "Profile"
        $0.setTitleColor(.red, for: .normal)
        $0.type = .outlined
        $0.rx.tap.bind { [unowned self] in
            self.push(coordinator.makeProfileViewController())
        }.disposed(by: disposeBag)
    }
    
    override var baseViewModel: BaseViewModel? {
        return viewModel
    }
    
    private let viewModel: DashboardViewModel
    
    internal init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        title = "Dashboard"
    }
    
    private func setupConstraints() {
        view.addSubview(profileButton) {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
