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
    
    private func makeSignInViewController() -> SignInViewController {
        let authService = AuthService()
        let keychain = KeyChainCache()
        let viewModel = SignInViewModel(authService: authService, keychain: keychain)
        return SignInViewController(viewModel: viewModel)
    }
    
    private func makeDashboardViewController() -> DashboardViewController {
        let viewModel = DashboardViewModel()
        return DashboardViewController(viewModel: viewModel)
    }
    
    func start() {
        self.navigateToSignIn()
    }
    
    private func navigateToSignIn() {
        let viewController = makeSignInViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func navigateToHome() {
        let viewController = makeDashboardViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func makeProfileViewController() -> ProfileViewController {
        let profileService = ProfileService()
        let viewModel = ProfileViewModel(profileService: profileService)
        return ProfileViewController(viewModel: viewModel)
    }
}
