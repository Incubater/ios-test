//
//  JKLog.swift
//  JKFramework
//
//  Created by Cjj on 15/12/16.
//  Copyright © 2015年 Cjj. All rights reserved.
//

import Foundation
import CocoaLumberjack


public class JKLog
{
    static private let ERROR_PATH = JKFile.GetCurrentPath() + "/JKError/Error.txt";
    
    /**
     输入log
     
     - parameter tText: log内容
     */
    class public func d(tText:String) {
        if (JKDebug.nDebug != 0)
        {
            DDLogDebug(tText);
        }
    }
    
    /**
     输入log
     
     - parameter tText: log内容
     */
    class public func e(tText:String) {
        if (JKDebug.nDebug != 0)
        {
            DDLogError(tText);
        }
    }
    
    /**
     打印错误语句
     
     - parameter tMessage: 错误信息
     */
    public class func ErrorLog(tMessage:String)
    {
        if (JKDebug.nDebug != 0)
        {
            JKFile.CreateDir(ERROR_PATH);
            if (!JKFile.IsExists(ERROR_PATH)){
                JKFile.WriteFile(ERROR_PATH, tText: "");
            }
            JKFile.AppendFile(ERROR_PATH, tText: JKDate.GetFullDate(false) + ": " + GetFunctionPos() + "  " + tMessage + "\r\n");
        }
    }
    
    /**
     获取当前函数位置
     
     - returns: 函数位置
     */
    public class func GetFunctionPos()->String
    {
//        let a = __FUNCTION__;
//        let b = __FILE__;
//        let c = __LINE__;
        return "";
    }
}
