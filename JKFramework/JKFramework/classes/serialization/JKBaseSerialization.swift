//
//  JKBaseSerialization.swift
//  JKFramework
//
//  Created by Cjj on 16/2/1.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKBaseSerialization
{
    public init() {
    }
    
    /**
     * 从文件里读取序列化内容
     * @param tPath 文件地址(assets不加"/")
     * @param tEncoding 编码支持"UTF-8","GBK
     */
    public func LoadFile(tPath:String,tEncoding:String) {
        fatalError("这个方法必须在子类中被重写");
    }
    
    /**
     * 设置序列化内容
     * @param tText 序列化内容
     */
    public func LoadString(tText:String) {
        fatalError("这个方法必须在子类中被重写");
    }
    
    /**
    * 将序列化内容保存文件
    * @param tPath 保存的sdcard路径
    * @param tEncoding 编码支持"UTF-8","GBK
    */
    public func SaveFile(tPath:String,tEncoding:String)
    {
        fatalError("这个方法必须在子类中被重写");
    }
    
    /**
    * 将序列化内容保存文件
    * @param tPath 保存的sdcard路径
    */
    public func SaveFile(tPath:String)
    {
        SaveFile(tPath,tEncoding: "UTF-8");
    }
    
    /**
    * 询问地址创建节点属性
    * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
    * @param tText 属性值
    */
    public func CreateNode(tQuestion:String,tText:String)
    {
        fatalError("这个方法必须在子类中被重写");
    }
    
    /**
    * 将序列化内容转为字符串
    * @return 转化后的字符串
    */
    public func GetString()->String
    {
        fatalError("这个方法必须在子类中被重写");
    }
    
    /**
    * 询问地址是否存在
    * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
    * @return 若该节点存在返回true
    */
    public func IsExist(tQuestion:String)->Bool
    {
        fatalError("这个方法必须在子类中被重写");
    }
    
    /**
    * 询问地址获取节点文本
    * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
    * @return 匹配成功返回文本,失败返回空
    */
    public func GetNodeText(tQuestion:String)->String
    {
        fatalError("这个方法必须在子类中被重写");
    }
    
    /**
    * 询问地址获取节点个数
    * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
    * @return 节点个数
    */
    public func GetNodeCount(tQuestion:String)->Int
    {
        fatalError("这个方法必须在子类中被重写");
    }
    
    /**
    * 询问地址创建节点属性
    * @param tQuestion 匹配规则为"XXX/XXX[n]/@XXX"(匹配从1开始)
    * @param nText 属性值
    */
    public func CreateNode(tQuestion:String,nText:Int)
    {
        fatalError("这个方法必须在子类中被重写");
    }
}