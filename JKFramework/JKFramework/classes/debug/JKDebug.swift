

//
//  JKDebug.swift
//  JKFramework
//
//  Created by Cjj on 15/12/19.
//  Copyright © 2015年 Cjj. All rights reserved.
//

import Foundation
import CocoaLumberjack
import IQKeyboardManagerSwift
import SDWebImage

public class JKDebug
{
    
    /**Debug版本号(0为发布版)*/
    public static var nDebug = 1;
    
    /**运行状态标志符*/
    public static var tState:String?
    /**反射类*/
    public static var tReflect = "";
    
    class public func Init(nDebugStauts:Int,tReflect:String) {
        JKDebug.nDebug = nDebugStauts
        JKDebug.tReflect = tReflect;
        //Log初始化
        DDLog.addLogger(DDTTYLogger.sharedInstance())
        //键盘初始化
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true;
        IQKeyboardManager.sharedManager().enableAutoToolbar = false;
    }
    
    /**
    * 激活回收状态
    */
    public class func Activation()
    {
        JKDebug.tState = "Running";
        if (!JKControllerManager.isNull())
        {
            JKControllerManager.Abandon();
        }
        JKControllerManager.Reset();
        JKPreferences.RemoveSharePersistent("JKFILE_CHOICEFILE");
    }
}
