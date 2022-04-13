//
//  AppManager.swift
//  Owl
//
//  Created by Ray on 2021/9/8.
//

import UIKit

struct AppManager {
    
    static let share: AppManager = AppManager()
    
    private init() {}

    public func createRootFor12Earlier(window: UIWindow?) {
        let appTabBarController = AppTabBarController()
        let appTabs: [AppTab] = [.ui, .network, .other, .setting]
        var vcs: [UIViewController] = []
        
        for (index, appTab) in appTabs.enumerated() {
            let containerVC = AppContainerVC(appTab: appTab)
            let nac = AppNavigationController(rootViewController: containerVC)
            
            let item = UITabBarItem(title: appTab.title,
                                    image: appTab.unSelectedImage,
                                    selectedImage: appTab.selectedImage)
            item.tag = index
            nac.tabBarItem = item
            
            vcs.append(nac)
        }
        
        appTabBarController.viewControllers = vcs
        
        window?.backgroundColor = .owlBackground
        window?.rootViewController = appTabBarController
        window?.makeKeyAndVisible()
    }
    
    @available(iOS 13.0, *)
    public func createRootFor13Later(window: UIWindow?, windowScene: UIWindowScene) {
        let appTabBarController = AppTabBarController()
        let appTabs: [AppTab] = [.ui, .network, .other, .setting]
        var vcs: [UIViewController] = []
        
        for (index, appTab) in appTabs.enumerated() {
            let containerVC = AppContainerVC(appTab: appTab)
            let nac = AppNavigationController(rootViewController: containerVC)
            
            let item = UITabBarItem(title: appTab.title,
                                    image: appTab.unSelectedImage,
                                    selectedImage: appTab.selectedImage)
            item.tag = index
            nac.tabBarItem = item
            
            vcs.append(nac)
        }
        
        appTabBarController.viewControllers = vcs
        
        window?.windowScene = windowScene
        window?.backgroundColor = .owlBackground
        window?.rootViewController = appTabBarController
        window?.makeKeyAndVisible()
    }
}

// MARK: - Enum

extension AppManager {
    
    /// 頁籤
    enum AppTab {
        
        case ui
        
        case network
        
        case other
        
        case setting
        
        /// 標題
        var title: String {
            switch self {
            case .ui:
                return "UI"
            case .network:
                return "網路"
            case .other:
                return "其他"
            case .setting:
                return "設定"
            }
        }
        
        /// 選中圖片樣式
        var selectedImage: UIImage? {
            switch self {
            case .ui:
                return UIImage(named: "ic-ui-full")
            case .network:
                return UIImage(named: "ic-network-full")
            case .other:
                return UIImage(named: "ic-other-full")
            case .setting:
                return UIImage(named: "ic-setting-full")
            }
        }
        
        /// 未選中圖片樣式
        var unSelectedImage: UIImage? {
            switch self {
            case .ui:
                return UIImage(named: "ic-ui-empty")
            case .network:
                return UIImage(named: "ic-network-empty")
            case .other:
                return UIImage(named: "ic-other-empty")
            case .setting:
                return UIImage(named: "ic-setting-empty")
            }
        }
    }
    
}
