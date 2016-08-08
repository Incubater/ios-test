//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

@IBDesignable
public  class JKToggleButton : UISwitch {
    
    private var fScale:CGFloat = 1
    
    @IBInspectable
    var scale:CGFloat{
        get { return fScale }
        set {
            fScale = newValue;
            self.transform = CGAffineTransformMakeScale(fScale, fScale);
        }
    }

}
