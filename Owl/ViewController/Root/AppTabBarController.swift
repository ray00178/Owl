//
//  AppTabBarController.swift
//  Owl
//
//  Created by Ray on 2021/9/8.
//

import UIKit

class AppTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = .owlBackground
        tabBar.tintColor = .owlMain
        tabBar.unselectedItemTintColor = .owlMain
        
        delegate = self
    }
}

extension AppTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("TabBar didSelect = \(viewController)")
    }
}
