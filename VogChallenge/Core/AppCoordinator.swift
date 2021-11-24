//
//  AppCoordinator.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private weak var appDelegate: AppDelegate?
    let window : UIWindow
    
    init(appDelegate: AppDelegate, window: UIWindow) {
        self.appDelegate = appDelegate
        self.window = window
    }
    
    func makeDashboardViewController() -> DashboardViewController {
        let viewModel = DashboardViewModel()
        return DashboardViewController(viewModel: viewModel)
    }
    
    func start() {
        self.navigateToHome()
    }
    
    private func navigateToHome() {
        let viewController = makeDashboardViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
