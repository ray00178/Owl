//
//  UIView+Extension.swift
//  Owl
//
//  Created by Ray on 2021/9/8.
//

import UIKit

// MARK: - Auto Layout

extension UIView {
    
    /// 使用AutoLayout
    var useAutoLayout: Bool {
        get { !translatesAutoresizingMaskIntoConstraints }
        set {
            translatesAutoresizingMaskIntoConstraints = !newValue
        }
    }
    
}

// MARK: - Shadow、Corner

extension UIView {
    
    @IBInspectable
        var cornerRadius: CGFloat {
            get {
                layer.cornerRadius
            }
            
            set {
                layer.cornerRadius = newValue
                clipsToBounds = true
            }
        }
        
        @IBInspectable
        var borderWidth: CGFloat {
            get {
                layer.borderWidth
            }
            
            set {
                layer.borderWidth = newValue
            }
        }
        
        @IBInspectable
        var borderColor: UIColor? {
            get {
                if let color = layer.borderColor {
                    return UIColor(cgColor: color)
                }
                
                return nil
            }
            
            set {
                if let color = newValue {
                    layer.borderColor = color.cgColor
                } else {
                    layer.borderColor = nil
                }
            }
        }
        
        @IBInspectable
        var shadowRadius: CGFloat {
            get {
                layer.shadowRadius
            }
            
            set {
                layer.shadowRadius = newValue
            }
        }
        
        @IBInspectable
        var shadowOpacity: Float {
            get {
                layer.shadowOpacity
            }
            
            set {
                layer.shadowOpacity = newValue
            }
        }
        
        @IBInspectable
        var shadowOffset: CGSize {
            get {
                layer.shadowOffset
            }
            
            set {
                layer.shadowOffset = newValue
            }
        }
        
        @IBInspectable
        var shadowColor: UIColor? {
            get {
                if let color = layer.shadowColor {
                    return UIColor(cgColor: color)
                }
                
                return nil
            }
            
            set {
                if let color = newValue {
                    layer.shadowColor = color.cgColor
                } else {
                    layer.shadowColor = nil
                }
            }
        }
}

// MARK: - UI Test

extension UIView {
    
    /// Use for UITest
    var accessibilityId: String? {
        get { accessibilityIdentifier }
        set {
            isAccessibilityElement = true
            accessibilityIdentifier = newValue
        }
    }
}
