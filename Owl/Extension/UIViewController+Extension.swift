//
//  UIViewController+Extension.swift
//  Owl
//
//  Created by Ray on 2021/9/15.
//

import UIKit

// MARK: - Present, Push and Pop UIViewController

extension UIViewController {
    
    /// Present 某個 UIViewController
    /// - Parameters:
    ///   - vc: Target UIViewController
    ///   - style: see more UIModalPresentationStyle
    ///   - animated: 是否有動畫
    ///   - completion: 完成後回調
    public func present(to vc: UIViewController,
                        style: UIModalPresentationStyle,
                        animated: Bool,
                        completion: (() -> Swift.Void)?) {
        if (vc is UIAlertController) == false {
            vc.modalPresentationStyle = style
        }
        
        present(vc, animated: animated, completion: completion)
    }
    
    /// Push 某個 UIViewController
    /// - Parameters:
    ///   - vc: Target UIViewController
    ///   - animated: 是否有動畫
    public func push(to vc: UIViewController, animated: Bool) {
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    /// Pop 回前一個 UIViewController
    /// - Parameter animated: 是否有動畫
    /// - Returns: Pop current viewcontroller
    @discardableResult
    public func pop(animated: Bool) -> UIViewController? {
        return navigationController?.popViewController(animated: animated)
    }
    
    
    /// Pop 某個 UIViewController
    /// - Parameters:
    ///   - vc: Target UIViewController
    ///   - animated: 是否有動畫
    /// - Returns: Pop current viewcontrollers
    @discardableResult
    public func pop(to vc: UIViewController, animated: Bool) -> [UIViewController]? {
        return navigationController?.popToViewController(vc, animated: animated)
    }
    
    /// Pop 回第一個UIViewController
    /// - Parameter animated: 是否有動畫
    /// - Returns: Pop current viewcontrollers
    @discardableResult
    public func popToRoot(animated: Bool) -> [UIViewController]? {
        return navigationController?.popToRootViewController(animated: animated)
    }
}
