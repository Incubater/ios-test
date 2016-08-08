//
//  JKToast.swift
//  JKFramework
//
//  Created by Cjj on 16/2/17.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKWebView : UIWebView {
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        Init();
    }
    
    private func Init()
    {
    
        let scScrollview = subviews[0] as? UIScrollView;
        scScrollview?.bounces = false
    }
    
}