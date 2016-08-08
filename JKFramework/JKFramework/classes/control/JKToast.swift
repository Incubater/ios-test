//
//  JKToast.swift
//  JKFramework
//
//  Created by Cjj on 16/2/17.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import JLToast

public class JKToast {
    
    private static var taInstance:JLToast?;
    
    /**
    * Toast提示
    * @param tMessage 提示内容
    * @param nType 提示时间长短,0为短时间,1为长时间
    */
    public class func Show(tMessage:String,nType:Int)
    {
        if (taInstance != nil)
        {
            taInstance?.cancel()
        }
        taInstance = JLToast.makeText(tMessage, duration: nType == 1 ? JLToastDelay.LongDelay : JLToastDelay.ShortDelay);
        taInstance?.show()
    }
    
}