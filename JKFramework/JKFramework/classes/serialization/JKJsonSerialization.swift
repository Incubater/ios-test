//
//  JKJson.swift
//  JKFramework
//
//  Created by Cjj on 16/2/1.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import EVReflection

public class JKJsonSerialization
{
    
    /**
     * 从文件里读取序列化内容
     * @param tPath 文件地址(assets不加"/")
     * @param tEncoding 编码支持"UTF-8","GBK
     * @param classBean 序列化对象
     */
     public func LoadFile(tPath:String,tEncoding:String,classBean:EVObject) {
        let jsonDict = EVReflection.dictionaryFromJson(JKFile.ReadFile(tPath,tEncoding: tEncoding));
        EVReflection.setPropertiesfromDictionary(jsonDict, anyObject: classBean);
    }
    
    
    /**
     * 设置序列化内容
     * @param tText 序列化内容
     * @param classBean 序列化对象
     */
    public class func LoadString(tText:String,classBean:EVObject) {
        let jsonDict = EVReflection.dictionaryFromJson(tText);
        EVReflection.setPropertiesfromDictionary(jsonDict, anyObject: classBean);
    }
    
//    /**
//     * 将序列化内容保存文件
//     * @param tPath 保存的sdcard路径
//     * @param tEncoding 编码支持"UTF-8","GBK
//     * @param oObject 序列话对象
//     */
//    public class func SaveFile<T: Mappable>(tPath:String, tEncoding:String,oObject:T) {
//        JKFile.WriteFile(tPath, tText: GetString(oObject),tEncoding:  tEncoding);
//    }
//    
//    /**
//     * 将序列化内容转为字符串
//     * @param oObject 序列话对象
//     * @return 转化后的字符串
//     */
//    public class func GetString<T: Mappable>(oObject:T)->String
//    {
//        return Mapper().toJSONString(oObject, prettyPrint: true)!
//    }
    
}