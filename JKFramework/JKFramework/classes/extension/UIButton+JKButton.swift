//
//  ChineseTraditionalColors.swift
//  ChineseTraditionalColors
//
//  Created by Zhixuan Lai on 11/2/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import Foundation

extension UIButton {
    
    public func SetTitile(tText: String) {
        setTitle(tText, forState: UIControlState.Normal);
        setTitle(tText, forState: UIControlState.Highlighted);
        setTitle(tText, forState: UIControlState.Selected);
        setTitle(tText, forState: UIControlState.Disabled);
    }
}
