//
//  JKAnalysis.swift
//  JKFramework
//
//  Created by Cjj on 16/2/2.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKAnalysis
{
    
    /**
     * 将字符串转成大写
     * @param tText  传入字符串
     * @return 转成大写后的字符串
     */
    public class func toUpper(tText:String)->String
    {
        return tText.uppercaseString;
    }
    
    /**
    * 将字符串转成小写
    * @param tText  传入字符串
    * @return 转成小写后的字符串
    */
    class public func toLower(tText:String)->String
    {
        return tText.lowercaseString;
    }
    
    /**
     * 将字符串按规定字符进行切割
     * @param tText  完整字符串
     * @param tDelimiter 切割方式
     * @return 切割后的字符串数组
     */
    class public func Split(tText:String,tDelimiter:String)->[String]
    {
        return tText.componentsSeparatedByString(tDelimiter);
    }
    
    /**
     * 获取字符串中指定字符串区间内容
     * @param tText	搜寻的字符串
     * @param tFirst  字符串的起始区间
     * @param tEnd  字符串的结束区间
     * @return  字符串中间的内容
     */
    class public func GetMiddleString(tText:String,tFirst:String,tEnd:String)->String
    {
        return GetMiddleString(tText, nPos: 0, tFirst:tFirst, tEnd:tEnd);

    }
    
    /**
     * 获取字符串中指定字符串区间内容
     * @param tText	搜寻的字符串
     * @param tFirst  字符串的起始区间
     * @param tEnd  字符串的结束区间
     * @return  字符串中间的内容
     */
    class public func GetMiddleString(tText:String,nPos:Int,tFirst:String,tEnd:String)->String
    {
        if (tText.isEmpty)
        {
            return "";
        }
        let searchRange = tText.startIndex.advancedBy(nPos) ..< tText.endIndex
        var nStart = tText.rangeOfString(tFirst,options: NSStringCompareOptions.ForcedOrderingSearch,range: searchRange);
        if (nStart == nil)     //内容没有找到
        {
            return "";
        }
        nStart?.startIndex = nStart!.startIndex.advancedBy(tFirst.lengthOfBytesUsingEncoding(NSUTF8StringEncoding));

        let searchRange2 = nStart!.startIndex.advancedBy(1) ..< tText.endIndex
        let nEnd = tText.rangeOfString(tEnd, options: NSStringCompareOptions.ForcedOrderingSearch,range: searchRange2);
        if (nEnd == nil)//内容没有找到
        {
            return "";
        }
        
        return tText.substringWithRange(nStart!.startIndex ..< nEnd!.startIndex);
    }
    
}