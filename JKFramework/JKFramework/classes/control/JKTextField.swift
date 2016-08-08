//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

@IBDesignable
public class JKTextField : UITextField,UITextFieldDelegate {
    
    private var padding = UIEdgeInsetsZero
    /// 文本最大长度限制
    private var nMaxLength = -1
    /// hint颜色
    private var placeholderColor = UIColor.grayColor()
    /// return监听
    private var mOnReturnListener: OnReturnKeyTypeListener?;
    ///return键点击事件
    public typealias OnReturnKeyTypeListener = (vView:UIView) -> Bool
    
    public override func awakeFromNib()
    {
        super.awakeFromNib();
        self.delegate = self;
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(JKTextField.TextFieldEditChange as (JKTextField) -> () -> ()), name: UITextFieldTextDidChangeNotification, object: self);
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBInspectable
    var maxLength:Int{
        get { return nMaxLength }
        set {
            nMaxLength = newValue;
        }
    }
    
    @IBInspectable
    var hintColor:UIColor{
        get { return placeholderColor }
        set {
            placeholderColor = newValue;
            setValue(placeholderColor, forKeyPath: "placeholderLabel.textColor")
        }
    }

    @IBInspectable
    var paddingLeft: CGFloat {
        get { return padding.left }
        set { padding.left = newValue }
    }
    
    @IBInspectable
    var paddingRight: CGFloat {
        get { return padding.right }
        set { padding.right = newValue }
    }
    
    @IBInspectable
    var paddingTop: CGFloat {
        get { return padding.top }
        set { padding.top = newValue }
    }
    
    @IBInspectable
    var paddingBottom: CGFloat {
        get { return padding.bottom }
        set { padding.bottom = newValue }
    }
    
    override public func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override public func drawPlaceholderInRect(rect: CGRect) {
        super.drawPlaceholderInRect(UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        let insets = self.padding
        var rect = super.textRectForBounds(UIEdgeInsetsInsetRect(bounds, insets))
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
    
    override public func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        let insets = self.padding
        var rect = super.placeholderRectForBounds(UIEdgeInsetsInsetRect(bounds, insets))
        rect.origin.x    -= (editing ? 2*insets.left :insets.left)
        rect.origin.y    -= (editing ? 2*insets.top :insets.top)
        rect.size.width  += (editing ? 2*(insets.left + insets.right) :(insets.left + insets.right))
        rect.size.height += (editing ? 2*(insets.top + insets.bottom) :(insets.top + insets.bottom))
        return rect
    }

    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        let insets = self.padding
        let rect = super.editingRectForBounds(UIEdgeInsetsInsetRect(bounds, insets))
        return rect
    }

    /**
     设置点击事件监听
     
     - parameter mListener: 监听回调
     */
    public func SetOnReturnKeyTypeListener(mListener:OnReturnKeyTypeListener)
    {
        self.mOnReturnListener = mListener
        self.delegate = self;
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        return mOnReturnListener?(vView: self) ?? true;
    }
    
    func TextFieldEditChange()
    {
        let range = self.markedTextRange;
        if (range == nil && nMaxLength >= 0)
        {
            if (self.text?.Length() > nMaxLength) {
                let nIndex = self.text?.startIndex.advancedBy(nMaxLength);
                if (nIndex != nil)
                {
                    self.text = self.text?.substringToIndex(nIndex!)
                }
            }
        }
    }
}
