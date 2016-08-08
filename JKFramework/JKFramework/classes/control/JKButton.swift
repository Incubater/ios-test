//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

@IBDesignable
public class JKButton : UIButton {
    
    /**普通背景*/
    private var clBackground:UIColor = UIColor.clearColor()
    /**高亮背景*/
    private var clBackgroundHigh:UIColor = UIColor.clearColor()
    /**禁用背景*/
    private var clBackgroundDisable:UIColor = UIColor.clearColor()
    /**选择背景*/
    private var clBackgroundSelect:UIColor = UIColor.clearColor()
    
    @IBInspectable
    var SelectBackgroundColor: UIColor {
        get{
            return clBackgroundSelect
        }
        set {
            clBackgroundSelect = newValue;
            if (selected && enabled && !highlighted)
            {
                backgroundColor = clBackgroundSelect;
            }
        }
    }
    
    @IBInspectable
    var DisableBackgroundColor: UIColor {
        get{
            return clBackgroundDisable
        }
        set {
            clBackgroundDisable = newValue;
            if (!enabled)
            {
                backgroundColor = clBackgroundDisable;
            }
        }
    }
    
    @IBInspectable
    var HighlightBackgroundColor: UIColor {
        get{
            return clBackgroundHigh
        }
        set {
            clBackgroundHigh = newValue;
            if (highlighted)
            {
                backgroundColor = clBackgroundHigh;
            }
        }
    }
    
    
    override public var highlighted: Bool {
        willSet(newValue) {

        }
        didSet {
            if (highlighted)
            {
                backgroundColor = clBackgroundHigh;
            }
            else {
                if (enabled)
                {
                    backgroundColor = clBackground;
                }
            }

        }
    }
    
    override public var enabled: Bool {
        willSet(newValue) {
            
        }
        didSet {
            if (!enabled)
            {
                backgroundColor = clBackgroundDisable;
            }
            else {
                backgroundColor = clBackground;
            }
            
        }
    }
    
    override public var selected: Bool {
        willSet(newValue) {
            
        }
        didSet {
            if (selected)
            {
                if (enabled)
                {
                    backgroundColor = clBackgroundSelect;
                }
            }
            else {              
                backgroundColor = clBackground;
            }            
        }
    }
    
    override public var backgroundColor:UIColor?{
        willSet(newValue) {
            if (!highlighted && enabled && !selected)
            {
                clBackground = (newValue ?? UIColor.clearColor())!;
            }
        }
        didSet {
            
        }
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect);
    }

//    func setBackgroundColor(backgroundColor:UIColor,state:UIControlState)
//    {
//        // If it is normal then set the standard background here
//        if(state == UIControlState.Normal)
//        {
//            super.backgroundColor = backgroundColor;
//        }
//        // Store the background colour for that state
////        [_colors setValue:backgroundColor forKey:[self keyForState:state]];
//    }
    
//    @IBInspectable
//    var ViewGone:Bool{
//        get{
//            return viewStatus;
//        }set{
//            viewStatus = newValue
//        }
//    }
    
}
