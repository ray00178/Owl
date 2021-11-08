//
//  UIScreen+Extension.swift
//  Owl
//
//  Created by Ray on 2021/11/8.
//

import UIKit

extension UIScreen {
    
    /// 螢幕寬度
    static var width: CGFloat { UIScreen.main.bounds.width }
    
    /// 螢幕高度
    static var height: CGFloat { UIScreen.main.bounds.height }
    
    /// 解析度
    static var density: CGFloat { UIScreen.main.scale }
    
}
