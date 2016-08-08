//
//  JKJson.swift
//  JKFramework
//
//  Created by Cjj on 16/2/1.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import SwiftyJSON

public class JKJson : JKBaseSerialization
{
//    private var json = JSON(data:NSData(bytes:JKConvert.toByteArray("{}")))
    private var json = JSON.parse("{}");
    
    /**
     * 从文件里读取序列化内容
     * @param tPath 文件地址(assets不加"/")
     * @param tEncoding 编码支持"UTF-8","GBK
     */
    override public func LoadFile(tPath:String,tEncoding:String) {
        json = JSON(data: NSData(bytes: JKFile.ReadBytes(tPath)))
    }
    
    /**
     * 设置序列化内容
     * @param tText 序列化内容
     */
    override public func LoadString(tText:String) {
        json = JSON(data: NSData(bytes: JKConvert.toByteArray(tText)))
    }
    
    /**
     * 询问地址创建节点属性
     * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
     * @param tText 属性值
     */
    override public func CreateNode(tQuestion:String,tText:String)
    {
        let a_tRule = JKAnalysis.Split(tQuestion, tDelimiter: "/");
        var jsoTmp = json;
        var a_jsonRoot = [json];
        var a_tRoot:[AnyObject] = [];
        for i in 0 ..< a_tRule.count
        {
            let tRule = a_tRule[i];
            let tIndex = JKAnalysis.GetMiddleString(tRule, tFirst: "[", tEnd: "]");
            if (tIndex == "")
            {
                if (jsoTmp[tRule] == nil)
                {
                    jsoTmp[tRule] = JSON.parse("{}");
                }
                jsoTmp = jsoTmp[tRule];
                a_jsonRoot.append(jsoTmp);
                a_tRoot.append(tRule);
            }
            else
            {
                let nStart = a_tRule[i].rangeOfString("[",options: NSStringCompareOptions.ForcedOrderingSearch);
                let tRule = a_tRule[i].substringWithRange(a_tRule[i].startIndex ..< nStart!.startIndex);
                if (jsoTmp[tRule] == nil)
                {
                    jsoTmp[tRule] = JSON.parse("{}");
                }
                jsoTmp = jsoTmp[tRule];
                a_jsonRoot.append(jsoTmp);
                a_tRoot.append(tRule);
                jsoTmp = jsoTmp[JKConvert.toInt(tIndex) - 1];
                a_jsonRoot.append(jsoTmp);
                a_tRoot.append(JKConvert.toInt(tIndex) - 1);
            }
        }
        a_jsonRoot[a_jsonRoot.count-1].string = tText;
        for i in (a_jsonRoot.count-2).stride (through: 0, by: -1) {
            if (a_tRoot[i] as? String != nil)
            {
                a_jsonRoot[i][a_tRoot[i] as! String] = a_jsonRoot[i+1];
            }
            else {
                a_jsonRoot[i][a_tRoot[i] as! Int] = a_jsonRoot[i+1];
            }

        }
        json = a_jsonRoot[0];
    }
    
    /**
    * 询问地址创建节点属性
    * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
    * @param nText 属性值
    */
    override public func CreateNode(tQuestion:String,nText:Int)
    {
        let a_tRule = JKAnalysis.Split(tQuestion, tDelimiter: "/");
        var jsoTmp = json;
        var a_jsonRoot = [json];
        var a_tRoot:[AnyObject] = [];
        for i in 0 ..< a_tRule.count
        {
            let tRule = a_tRule[i];
            let tIndex = JKAnalysis.GetMiddleString(tRule, tFirst: "[", tEnd: "]");
            if (tIndex == "")
            {
                if (jsoTmp[tRule] == nil)
                {
                    jsoTmp[tRule] = JSON.parse("{}");
                }
                jsoTmp = jsoTmp[tRule];
                a_jsonRoot.append(jsoTmp);
                a_tRoot.append(tRule);
            }
            else
            {
                let nStart = a_tRule[i].rangeOfString("[",options: NSStringCompareOptions.ForcedOrderingSearch);
                let tRule = a_tRule[i].substringWithRange(a_tRule[i].startIndex ..< nStart!.startIndex);
                if (jsoTmp[tRule] == nil)
                {
                    jsoTmp[tRule] = JSON.parse("{}");
                }
                jsoTmp = jsoTmp[tRule];
                a_jsonRoot.append(jsoTmp);
                a_tRoot.append(tRule);
                jsoTmp = jsoTmp[JKConvert.toInt(tIndex) - 1];
                a_jsonRoot.append(jsoTmp);
                a_tRoot.append(JKConvert.toInt(tIndex) - 1);
            }
        }
        a_jsonRoot[a_jsonRoot.count-1].number = nText;
        for i in (a_jsonRoot.count-2).stride (through: 0, by: -1) {
            if (a_tRoot[i] as? String != nil)
            {
                a_jsonRoot[i][a_tRoot[i] as! String] = a_jsonRoot[i+1];
            }
            else {
                a_jsonRoot[i][a_tRoot[i] as! Int] = a_jsonRoot[i+1];
            }

        }
        json = a_jsonRoot[0];
    }
    
    /**
     * 询问地址是否存在
     * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
     * @return 若该节点存在返回true
     */
    override public func IsExist(tQuestion:String)->Bool
    {
        let a_tRule = JKAnalysis.Split(tQuestion, tDelimiter: "/");
        var jsoTmp:JSON = json;
        for i in 0 ..< a_tRule.count
        {
            let tRule = a_tRule[i];
            let tIndex = JKAnalysis.GetMiddleString(tRule, tFirst: "[", tEnd: "]");
            if (tIndex == "")
            {
                jsoTmp = jsoTmp[a_tRule[i]];
            }
            else
            {
                let nStart = a_tRule[i].rangeOfString("[",options: NSStringCompareOptions.ForcedOrderingSearch);
                let tRule = a_tRule[i].substringWithRange(a_tRule[i].startIndex ..< nStart!.startIndex);
                jsoTmp = jsoTmp[tRule];
                jsoTmp = jsoTmp[JKConvert.toInt(tIndex) - 1];
            }
        }
        if (jsoTmp.string != nil){
            return true;
        }
        else {
            return false;
        }
    }
    
    /**
     * 询问地址获取节点个数
     * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
     * @return 节点个数
     */
    override public func GetNodeCount(tQuestion:String)->Int
    {
        let a_tRule = JKAnalysis.Split(tQuestion, tDelimiter: "/");
        var jsoTmp:JSON = json;
        for i in 0 ..< a_tRule.count
        {
            let tRule = a_tRule[i];
            let tIndex = JKAnalysis.GetMiddleString(tRule, tFirst: "[", tEnd: "]");
            if (tIndex == "")
            {
                jsoTmp = jsoTmp[a_tRule[i]];
            }
            else
            {
                let nStart = a_tRule[i].rangeOfString("[",options: NSStringCompareOptions.ForcedOrderingSearch);
                let tRule = a_tRule[i].substringWithRange(a_tRule[i].startIndex ..< nStart!.startIndex);
                jsoTmp = jsoTmp[tRule];
                jsoTmp = jsoTmp[JKConvert.toInt(tIndex) - 1];
            }
        }
        return jsoTmp.count;
    }
    
    /**
     * 询问地址获取节点文本
     * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
     * @return 匹配成功返回文本,失败返回空
     */
    override public func GetNodeText(tQuestion:String)->String
    {
        let a_tRule = JKAnalysis.Split(tQuestion, tDelimiter: "/");
        var jsoTmp:JSON = json;
        for i in 0 ..< a_tRule.count
        {
            let tRule = a_tRule[i];
            let tIndex = JKAnalysis.GetMiddleString(tRule, tFirst: "[", tEnd: "]");
            if (tIndex == "")
            {
                jsoTmp = jsoTmp[a_tRule[i]];
            }
            else
            {
                let nStart = a_tRule[i].rangeOfString("[",options: NSStringCompareOptions.ForcedOrderingSearch);
                let tRule = a_tRule[i].substringWithRange(a_tRule[i].startIndex ..< nStart!.startIndex);
                jsoTmp = jsoTmp[tRule];
                jsoTmp = jsoTmp[JKConvert.toInt(tIndex) - 1];
            }
        }
        return jsoTmp.stringValue
    }
    
    /**
     * 将序列化内容保存文件
     * @param tPath 保存的sdcard路径
     * @param tEncoding 编码支持"UTF-8","GBK
     */
    override public func SaveFile(tPath:String, tEncoding:String) {
        JKFile.WriteFile(tPath, tText: GetString(),tEncoding:  tEncoding);
    }
    
    /**
     * 将序列化内容转为字符串
     * @return 转化后的字符串
     */
    override public func GetString()->String
    {
        if let string = json.rawString() {
            return string;
        }
        return "";
    }
    
}