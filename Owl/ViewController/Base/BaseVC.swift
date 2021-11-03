//
//  AppBaseVC.swift
//  Owl
//
//  Created by Ray on 2021/9/8.
//

import UIKit

class AppBaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    deinit {
        print("\(self) deinit")
    }
    
    private func setup() {
        
    }
}

// MARK: - Root Controller

extension AppBaseVC {
    
    /// 取得 AppTabBarController
    var appTabBarController: AppTabBarController? {
        tabBarController as? AppTabBarController
    }
    
    /// 取得 AppNavigationController
    var appNavigationController: AppNavigationController? {
        navigationController as? AppNavigationController
    }
}

// MARK: - 設定返回鍵圖示

extension AppBaseVC {
    
}
