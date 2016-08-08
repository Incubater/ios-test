//
//  JKPreferences.swift
//  JKFramework
//
//  Created by 刘炜洋 on 16/2/24.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKPreferences {
    
        	
    /**
    * 存储缓存数据
    * @param key  存储的key值
    * @param value  存储的数据(字符串)
    */
    public class func SaveSharePersistent(key:String,value:String)
    {
        NSUserDefaults.standardUserDefaults().setObject(value,forKey: key);
    }
    
    /**
    * 存储缓存数据
    * @param key  存储的key值
    * @param value  存储的数据(浮点数)
    */
    public class func SaveSharePersistent(key:String,value:Float)
    {
        NSUserDefaults.standardUserDefaults().setFloat(value,forKey: key)
    }
    
    /**
    * 存储缓存数据
    * @param key  存储的key值
    * @param value  存储的数据(双精度浮点数)
    */
    public class func SaveSharePersistent(key:String,value:Double)
    {
        NSUserDefaults.standardUserDefaults().setDouble(value, forKey: key)
    }
    
    /**
    * 存储缓存数据
    * @param key  存储的key值
    * @param value  存储的数据(长整型)
    */
    public class func SaveSharePersistent(key:String,value:Int64)
    {
        NSUserDefaults.standardUserDefaults().setObject(JKConvert.toString(value), forKey: key)
    }
    
    /**
    * 存储缓存数据
    * @param key  存储的key值
    * @param value  存储的数据(整型)
    */
    public class func SaveSharePersistent(key:String,value:Int) {
        NSUserDefaults.standardUserDefaults().setInteger(value, forKey: key)
    }
    
    /**
    * 存储缓存数据
    * @param key  存储的key值
    * @param value  存储的数据(布尔型)
    */
    public class func SaveSharePersistent(key:String,value:Bool) {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: key)
    }
    
    /**
    * 存储缓存数据
    * @param key  存储的key值
    * @param a_tValue  存储的数据(字符串数组)
    */
    public class func SaveSharePersistent(key:String,a_tValue:[String]) {
        NSUserDefaults.standardUserDefaults().setObject(a_tValue, forKey: key)
    }
    
    /**
    * 获取缓存数据
    * @param key   存储数据时所对应的键
    * @return 对应的值（字符串）
    * */
    public class func GetSharePersistentString(key:String)->String
    {
        return NSUserDefaults.standardUserDefaults().valueForKey(key) as? String ?? ""
    }
    
    /**
    * 获取缓存数据
    * @param key  存储数据时所对应的键
    * @return 对应的值（整型）
    * */
    public class func GetSharePersistentInt(key:String)->Int
    {
        return NSUserDefaults.standardUserDefaults().integerForKey(key)
    }
    
    /**
    * 获取缓存数据
    * @param key  存储数据时所对应的键
    * @return 对应的值（长整型）
    * */
    public class func GetSharePersistentLong(key:String)->Int64
    {
        return JKConvert.toLong(NSUserDefaults.standardUserDefaults().valueForKey(key) as? String ?? "")
    }
    
    /**
    * 获取缓存数据
    * @param key  存储数据时所对应的键
    * @return 对应的值（浮点型）
    */
    public class func GetSharePersistentFloat(key:String)->Float
    {
        return NSUserDefaults.standardUserDefaults().floatForKey(key)
    }
    
    /**
    * 获取缓存数据
    * @param key  存储数据时所对应的键
    * @return 对应的值（浮点型）
    */
    public class func GetSharePersistentBoolean(key:String)->Bool{
        return NSUserDefaults.standardUserDefaults().boolForKey(key) ?? false
    }
    
    /**
    * 获取缓存数据
    * @param key  存储数据时所对应的键
    * @return 对应的值（双精度浮点型）
    */
    public class func GetSharePersistentDouble(key:String)->Double{
        return NSUserDefaults.standardUserDefaults().valueForKey(key) as? Double ?? 0.0
    }
    
    /**
    * 获取缓存数据
    * @param key   存储数据时所对应的键
    * @return 对应的值（字符串数组）
    * */
    public class func GetSharePersistentArrayString(key:String)->[String]{
        return NSUserDefaults.standardUserDefaults().stringArrayForKey(key) ?? []

    }
    
    /**
    * 清除特定缓存数据
    * @param key  存储的key值
    */
    public class func RemoveSharePersistent(key:String) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
    }
    
}