//
//  ChineseTraditionalColors.swift
//  ChineseTraditionalColors
//
//  Created by Zhixuan Lai on 11/2/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import Foundation

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            if (layer.borderColor != nil)
            {
                return UIColor(CGColor: layer.borderColor!)
            }
            return UIColor.clearColor();
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
}