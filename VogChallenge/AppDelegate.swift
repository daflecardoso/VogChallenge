//
//  AppDelegate.swift
//  VogChallenge
//
//  Created by Dafle on 24/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coordinator: AppCoordinator = AppCoordinator(appDelegate: self, window: window!)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        coordinator.start()
        
        return true
    }
}

