//
//  JKRandom.swift
//  JKFramework
//
//  Created by ymook on 16/3/17.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKRandom
{

	/**
	 * 获取制定长度的随机数
	 * @param nLen	随机数长度
	 * @return  返回随机整型字符串
	 */
	class public func GetIntRandom(nLen: Int) -> String
	{
		var tReturn: String = ""
		for _ in 0 ..< nLen
		{
			tReturn = tReturn + String(arc4random_uniform(10))
		}
		return tReturn
	}

	/**
	 * 获取范围内随机数[nStart,nEnd]
	 * @param nStart 随机范围起始值
	 * @param nEnd 随机范围结束值
	 * @return 返回的随机数
	 */
	class public func GetRandom(nStart: Int,nEnd: Int) -> Int
	{
        var nStart = nStart;
        var nEnd = nEnd;
		if (nStart > nEnd)
		{
			let nTmp = nStart;
			nStart = nEnd;
			nEnd = nTmp;
		}
		let nSize = nEnd - nStart + 1
		let nRandom = arc4random_uniform(UInt32(nSize))
		return Int(nRandom) + nStart;
	}

	/**
	 * 生成一个GUID
	 * @return 返回GUID
	 */
	class public func MakeGUID() -> String
	{
		return NSUUID().UUIDString
	}
}
