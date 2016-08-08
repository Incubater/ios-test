//
//  JKException.swift
//  JKFramework
//
//  Created by Cjj on 16/2/26.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKException
{
    /**反射函数类*/
    private var tReflectClass:String?;
    
    public init(tReflect:String) {
        tReflectClass = tReflect;
    }
    
    /**
    * 退出程序
    */
    public class func ExitProgram()
    {
        JKControllerManager.Exit();
    }
    
    /**
    * 消息反射函数
    * @param MainActivity 显示结果的activity
    * @param tReflect 反射类
    * @param tFunction 反射函数
    */
    public class func DoingReflect(MainController:UIViewController,tReflect:String,tFunction:String)
    {
        

    }
    
    public func uncaughtException(exception:NSException)
    {
        var tText = "";
        tText += "Model:" + UIDevice.currentDevice().model + "\r\n";
        tText += "Device:" + JKSystem.GetDevice() + "\r\n";
        tText += "Version:" + UIDevice.currentDevice().systemVersion + "\r\n";
        tText += "CodeVersion:" + JKSystem.GetVersionString() + "(" + JKSystem.GetVersionCode() + ")\r\n\r\n";
        
        tText += exception.debugDescription;
        for i in 0 ..< exception.callStackSymbols.count
        {
            tText += "\r\n";
            tText += exception.callStackSymbols[i];
        }
        JKLog.e(tText)
        
        let ExceptionController:JKExceptionController = JKExceptionController();
        var a_tParam = [String: AnyObject]();
        a_tParam["ReportText"] = tText;
        JKSystem.GetCurrentController()?.StartViewController(ExceptionController,a_tParam: a_tParam);
        
        NSRunLoop.mainRunLoop().run();
    }
}