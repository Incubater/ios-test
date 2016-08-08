//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

@IBDesignable
public  class JKEditText : UITextView,UITextViewDelegate {

    /// 键盘监听
    private var mOnKeyListener: OnKeyListener?;
    /// 键盘监听事件
    public typealias OnKeyListener = (vView:UIView,tKey:String) -> Bool
    
    public override func awakeFromNib()
    {
        super.awakeFromNib();        
        self.delegate = self;
    }
    
    /**
     设置点击事件监听
     
     - parameter mListener: 监听回调
     */
    public func SetOnKeyListener(mListener:OnKeyListener)
    {
        self.mOnKeyListener = mListener
        self.delegate = self;
    }
    
    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        return mOnKeyListener?(vView: self,tKey:text) ?? true;
    }

}
