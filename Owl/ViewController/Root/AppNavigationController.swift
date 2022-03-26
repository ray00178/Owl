//
//  AppNavigationController.swift
//  Owl
//
//  Created by Ray on 2021/9/8.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            
            // 設定順序
            // 1. configureWithTransparentBackground()
            // 2. titleTextAttributes and backgroundColor
            // 如果1與2顛倒, 會變成透明的NavagitionBar
            
            // 底部線條會不見
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.owlMain]
            appearance.backgroundColor = .owlBackground
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            
            navigationBar.isTranslucent = true
            navigationBar.tintColor = .owlMain
        } else {
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.owlMain]
            navigationBar.titleTextAttributes = textAttributes
            navigationBar.barTintColor = .owlBackground
            navigationBar.tintColor = .owlMain
            
            // 是否要有半透明遮罩
            navigationBar.isTranslucent = true
            
            // 隱藏下方黑色底線
            navigationBar.shadowImage = UIImage()
        }
    }
    
    /// 全螢幕左滑退出
    private func fullScreenSwipe() {
        // Reference: https://juejin.im/entry/5795809dd342d30059ed5c60
        // Support fullscreen swipe back
        let target = interactivePopGestureRecognizer?.delegate
        let targetView = interactivePopGestureRecognizer?.view
        let action = NSSelectorFromString("handleNavigationTransition:")
                
        let pan = UIPanGestureRecognizer(target: target, action: action)
        pan.delegate = self
        targetView?.addGestureRecognizer(pan)
                
        // Disable system
        interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension AppNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return children.count > 1
    }
}
