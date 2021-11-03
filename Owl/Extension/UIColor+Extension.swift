//
//  UIColor+Extension.swift
//  Owl
//
//  Created by Ray on 2021/9/3.
//

import UIKit

// MARK: - Convenience

extension UIColor {
    
    /// Convenience init
    /// - Parameters:
    ///   - hex: 色碼
    ///   - alpha: 透明度
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
            
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
            
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
            
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
        
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
}

// MARK: - Convert

extension UIColor {
    
    /// 顏色轉成對應色碼
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
            
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
            
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
}

// MARK: - Color List

extension UIColor {
    
    /// 主色
    /// - Light = #F7685A
    /// - Drak = #FFFFFF
    static var owlMain: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(hex: "FFFFFF")
                } else {
                    return UIColor(hex: "F7685A")
                }
            }
        } else {
            return UIColor(hex: "F7685A")
        }
    }
    
    /// 背景色
    /// - Light = #FFFFFF
    /// - Drak = #16202B
    static var owlBackground: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(hex: "16202B")
                } else {
                    return UIColor(hex: "FFFFFF")
                }
            }
        } else {
            return UIColor(hex: "FFFFFF")
        }
    }
    
    /// Cell background 顏色
    static var owlCellBackground: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(hex: "4E7297")
                } else {
                    return UIColor(hex: "E6E6E6")
                }
            }
        } else {
            return UIColor(hex: "E6E6E6")
        }
    }
    
    /// 灰階1 顏色
    /// - 737373
    static var owlGrayOne: UIColor {
        return UIColor(hex: "737373")
    }
}
