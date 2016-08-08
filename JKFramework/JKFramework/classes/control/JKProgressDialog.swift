//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import MBProgressHUD

public  class JKProgressDialog:MBProgressHUD {
    
    /// 是否显示
    private var bShow = false;
    /// 界面
    private var vc:UIViewController?;
    
    public init(vc:UIViewController) {
        super.init(view:vc.view);
        self.vc = vc;
        removeFromSuperViewOnHide = true;
//        backgroundView.color = UIColor(red: 255, green: 255, blue: 255, alpha: 0.2);
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6);
//        userInteractionEnabled = false;
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func isShowing()->Bool
    {
        return bShow;
    }
    
    public func setMessage(tMessage:String)
    {
        label.text = tMessage;
    }
 
    public func show()
    {
        bShow = true
        vc?.view.addSubview(self)
        showAnimated(true);
    }
    
    public func dismiss()
    {
        bShow = false
        hideAnimated(true)
    }
}
