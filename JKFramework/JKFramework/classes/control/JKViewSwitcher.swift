//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import SnapKit

@IBDesignable
public  class JKViewSwitcher : UIStackView {

    /**不显示的界面是否保留Layout*/
//    private boolean bShow = false;
    /**当前显示页面*/
    private var nDisplay = 0;
    
    @IBInspectable
    var displayedChild: Int {
        get { return nDisplay }
        set {
            nDisplay = newValue
            SetDisplayedChild(nDisplay)
        }
    }
    
    override public func addSubview(view: UIView) {
        super.addSubview(view);
        if (subviews.count-1 == nDisplay)
        {
            view.hidden = false;
        }
        else {
            view.hidden = true;
        }
    }
    
    override public func layoutSubviews()
    {
        super.layoutSubviews();
    }
    
    /**
     * 切换页面
     * @param nShow 显示第几个页面(从0开始)
     */
    public func SetDisplayedChild(nShow:Int)
    {
        nDisplay = nShow;
        let nCount = subviews.count;
        for i in 0 ..< nCount
        {
            if (i==nShow)
            {
                subviews[i].hidden = false;
            }
            else {
                subviews[i].hidden = true;
            }
        }
    }
    
    /**
     * 获取当前显示的页面索引
     * @return 索引号(0开始)
     */
    public func GetDisplayIndex()->Int
    {
        return nDisplay;
    }
}

