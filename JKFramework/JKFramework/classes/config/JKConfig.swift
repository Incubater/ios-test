//
//  File.swift
//  JKFramework
//
//  Created by ymook on 16/3/1.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKConfig {

	/**配置文件夹路径*/
	var tPath: String = ""

	public func JKConfig(tPath: String)
	{
		self.tPath = tPath
	}

	/**
	 * 通过键获取配置值
	 * @param tKey 键
	 * @return 配置值(无设置返回null)
	 */
	public func Get(tKey: String) -> String
	{
        let MdPlist:NSMutableDictionary = NSMutableDictionary(contentsOfFile: tPath) ?? NSMutableDictionary()
        return (MdPlist.valueForKey(tKey) as? String ) ?? ""
	}

	/**
	 * 添加键值到Properties对象
	 * @param tKey 键
	 * @param tValue 值
	 */
	public func Set(tKey: String, tValue: String)
	{
        let MdPlist:NSMutableDictionary = NSMutableDictionary(contentsOfFile: tPath) ?? NSMutableDictionary()
        MdPlist.setValue(tValue, forKey: tKey)
        MdPlist.writeToFile(tPath, atomically: true)
	}

	/**
	 * 清除所有数据
	 */
	public func ClearAll()
	{
        NSMutableDictionary().writeToFile(tPath, atomically: true)
	}
}
