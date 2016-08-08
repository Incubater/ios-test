//
//  JKConvert.swift
//  JKFramework
//
//  Created by Cjj on 15/12/10.
//  Copyright © 2015年 Cjj. All rights reserved.
//

import Foundation

public class JKConvert
{
    
    /**
     转字符串
     
     - parameter nNum: 整形
     
     - returns: 转后的字符串
     */
    class public func toString(nNum:Int) ->String {
        return String(nNum);
    }
    
    /**
     转字符串
     
     - parameter lNum: 长整形
     
     - returns: 转后的字符串
     */
    class public func toString(lNum:Int64) ->String {
        return String(lNum);
    }
    
    /**
     转字符串
     
     - parameter lNum: 长整形
     
     - returns: 转后的字符串
     */
    class public func toString(lNum:UInt64) ->String {
        return String(lNum);
    }
    
    /**
     转字符串
     
     - parameter fFloat: 浮点型
     
     - returns: 转后的字符串
     */
    class public func toString(fFloat:Float) ->String {
        return String(fFloat);
    }
    
    /**
     转字符串
     
     - parameter dDouble: 浮点型
     
     - returns: 转后的字符串
     */
    class public func toString(dDouble:Double) ->String {
        return String(dDouble);
    }
    
    /**
     转字符串
     
     - parameter a_byByte: byte数组
     
     - returns: 转后的字符串
     */
    class public func toString(a_byByte:[UInt8]) ->String {
        return toString(a_byByte,tEncoding: "UTF-8");
    }
    
    /**
     转字符串
     
     - parameter a_byByte: byte数组
     - parameter tEncoding: 编码格式(GBK,UTF-8)
     
     - returns: 转后的字符串
     */
    class public func toString(a_byByte:[UInt8],tEncoding:String) ->String {
        if (tEncoding.uppercaseString == "GBK")
        {
            return String(data: NSData(bytes: a_byByte), encoding: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))) ?? "";
        }else {
            return String(data: NSData(bytes: a_byByte), encoding: NSUTF8StringEncoding) ?? "";
        }
    }
    
    
    /**
     转int
     
     - parameter tText: 字符串
     
     - returns: 转后的整形
     */
    class public func toInt(tText:String) ->Int {
        return Int(tText) ?? 0;
    }
    
    /**
     转int
     
     - parameter lNum: 长整型
     
     - returns: 转后的整形
     */
    class public func toInt(lNum:Int64) ->Int {
        return Int(lNum) ?? 0;
    }
    
    /**
     转int
     
     - parameter lNum: 长整型
     
     - returns: 转后的整形
     */
    class public func toInt(lNum:UInt64) ->Int {
        return Int(lNum) ?? 0;
    }
    
    
    /**
     转long
     
     - parameter lNum: 整形
     
     - returns: 转后的长整形
     
     */
    class public func toLong(lNum:UInt64) ->Int64 {
        return Int64(lNum) ?? 0;
    }
    
    /**
     转long
     
     - parameter nText: 整形
     
     - returns: 转后的长整形
     
     */
    class public func toLong(nText:UInt) ->Int64 {
        return Int64(nText) ?? 0;
    }
    
    /**
     转long
     
     - parameter nText: 整形
     
     - returns: 转后的长整形
     
     */
    class public func toLong(nText:Int) ->Int64 {
        return Int64(nText) ?? 0;
    }
    
    /**
     转long
     
     - parameter tText: 字符串
     
     - returns: 转后的长整形
     
     */
    class public func toLong(tText:String) ->Int64 {
        return Int64(tText) ?? 0;
    }
    
    /**
     转double
     
     - parameter tText: 字符串
     
     - returns: 转的double
     */
    class public func toDouble(tText:String) ->Double {
        return Double(tText) ?? 0;
    }
    
    /**
     转double
     
     - parameter lNum: 长整形
     
     - returns: 转的double
     */
    class public func toDouble(lNum:UInt64) ->Double {
        return Double(lNum) ?? 0;
    }
    
    
    /**
     转double
     
     - parameter lNum: 长整形
     
     - returns: 转的double
     */
    class public func toDouble(lNum:Int64) ->Double {
        return Double(lNum) ?? 0;
    }
    
    /**
     转double
     
     - parameter nNum: 整形
     
     - returns: 转的double
     */
    class public func toDouble(nNum:Int) ->Double {
        return Double(nNum) ?? 0;
    }
    
    /**
     转float
     
     - parameter nNum: 整形
     
     - returns: 转的float
     */
    class public func toFloat(nNum:Int) ->Float {
        return Float(nNum) ?? 0;
    }
    
    /**
     小数四舍五入
     
     - parameter dNum: 原小数
     - parameter nIndex: 保留位数
     
     - returns: 四舍五入后的字符串
     */
    class public func toFormatDecimal(dNum:Double,nIndex:Int) ->String {
        let dnhRole = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundBankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        return String.init(format: "%.2f", NSDecimalNumber.init(double: dNum).decimalNumberByRoundingAccordingToBehavior(dnhRole).doubleValue);
    }
    
    /**
     转byte数组
     
     - parameter tText: 字符串
     
     - returns: 转的double
     */
    class public func toByteArray(tText:String) ->[UInt8] {
        return toByteArray(tText,tEncoding: "UTF-8")
    }
    
    /**
     转byte数组
     
     - parameter tText: 字符串
     
     - returns: 转的double
     */
    class public func toByteArray(tText:String,tEncoding:String) ->[UInt8] {
        
        if (tEncoding.uppercaseString == "GBK")
        {
            return [UInt8](tText.dataUsingEncoding(CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)),allowLossyConversion: false) ?? NSData());
        }else {
            return [UInt8](tText.utf8);
        }
    }
    
    
    /**
     Url编码转字符串
     
     - parameter tText: url编码
     
     - returns: 转后的字符串
     */
    class public func URLToString(tText:String) ->String {
        return tText.stringByRemovingPercentEncoding ?? "";
    }
    
    /**
     转url编码
     
     - parameter tText: 字符串
     
     - returns: url编码
     */
    class public func toURL(tText:String) ->String {
        return tText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet()) ?? "";
    }
    
    /**
     String转NSString
     
     - parameter tText: 字符串
     
     - returns: 转后的字符串
     */
    class public func toNSString(tText:String) ->NSString {
        return NSString(string: tText);
    }
    
    /**
     NSString转String
     
     - parameter tText: 字符串
     
     - returns: 转后的字符串
     */
    class public func toString(tText:NSString) ->String {
        return String(tText);
    }
}