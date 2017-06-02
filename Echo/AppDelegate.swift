//
//  AppDelegate.swift
//  Echo
//
//  Created by ShengHua Wu on 02/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - App Delegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let router = Router()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let navigationController = window?.rootViewController as? UINavigationController,
            let messagingViewController = navigationController.topViewController as? MessagingViewController else { return true }
        
        router.configure(messagingViewController)
        return true
    }
}

// MARK: - Router
struct Router {
    func configure(_ messagingViewController: MessagingViewController) {
        messagingViewController.title = "Echo"
        
        let viewModel = MessagingViewModel { [weak viewController = messagingViewController] (state) in
            viewController.flatMap { $0.updateUI(with: state) }
        }
        messagingViewController.viewModel = viewModel
    }
}
