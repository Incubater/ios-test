//
//  JKDate.swift
//  JKFramework
//
//  Created by Cjj on 16/1/23.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import SwiftDate

public class JKDate
{
    
    /**
     获取精确时间戳
     
     - returns: 时间戳精确到毫秒
     */
    class public func GetExactCalendarTime() ->UInt64 {
        return UInt64(NSDate().timeIntervalSince1970*1000);
    }
    
    /**
     获取时间戳
     
     - returns: 时间戳精确到秒
     */
    class public func GetCalendarTime() ->UInt64 {
        return UInt64(NSDate().timeIntervalSince1970);
    }
    
    /**
     获取时间完整格式
     
     - returns: xxxx年xx月xx日 xx:xx:xx
     */
    class public func GetFullDate(bUse:Bool) ->String {
        let lTime = GetExactCalendarTime();
        return GetFullDate(bUse,lTime: lTime);
    }
    
    /**
     获取时间完整格式
     
     - returns: xxxx年xx月xx日 xx:xx:xx
     */
    class public func GetFullDate(bUse:Bool,lTime:UInt64) ->String {
        return GetLongDate(bUse,lTime: lTime) + " " + GetLongTime(lTime);
    }
    
    /**
     获取年月日
     
     - returns: xxxx年xx月xx日
     */
    class public func GetLongDate(bUse:Bool) ->String {
        let date:NSDate = NSDate();
        return JKConvert.toString(date.year) + (bUse ? "年" : "-") + JKConvert.toString(date.month) + (bUse ? "月" : "-") + JKConvert.toString(date.day) + (bUse ? "日" : "");
    }
    
    /**
     获取年月日
     
     - returns: xxxx年xx月xx日
     */
    class public func GetLongDate(bUse:Bool,lTime:UInt64) ->String {
        let date:NSDate = NSDate(timeIntervalSince1970: Double(lTime/1000));
        return JKConvert.toString(date.year) + (bUse ? "年" : "-") + JKConvert.toString(date.month) + (bUse ? "月" : "-") + JKConvert.toString(date.day) + (bUse ? "日" : "");
    }
    
    /**
     获取时分秒
     
     - returns: xx:xx:xx
     */
    class public func GetLongTime() ->String {
        let date:NSDate = NSDate();
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.stringFromDate(date)
    }
    
    /**
     获取时分秒
     
     - returns: xx:xx:xx
     */
    class public func GetLongTime(lTime:UInt64) ->String {
        let date:NSDate = NSDate(timeIntervalSince1970: Double(lTime/1000));
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.stringFromDate(date)
    }
    
    /**
     获取时分秒
     
     - returns: xx:xx:xx
     */
    class public func GetOneTime(lTime:UInt64,nType:Int) ->Int {
        let date:NSDate = NSDate(timeIntervalSince1970: Double(lTime/1000));
        switch (nType)
        {
        case 0:
            return date.year;
        case 1:
            return date.month;
        case 2:
            return date.day;
        case 3:
            if (date.weekday == 1)
            {
                return 7;
            }
            else
            {
                return date.weekday-1;
            }
        case 4:
            return date.hour;
        case 5:
            return date.minute;
        case 6:
            return date.second;
        default:
            return -1;
        }
    }
    
}