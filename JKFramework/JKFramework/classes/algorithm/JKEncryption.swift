//
//  JKEncryption.swift
//  JKFramework
//
//  Created by Cjj on 15/12/16.
//  Copyright © 2015年 Cjj. All rights reserved.
//

import Foundation
import CryptoSwift

public class JKEncryption
{
    
    /**
     Md5 32位大写
     
     - parameter tText: 加密字符串
     
     - returns: MD5后字符串
     */
    class public func MD5_32(tText:String) ->String {
        return tText.md5().uppercaseString;
    }
    
    /**
     Md5 16位大写
     
     - parameter tText: 加密字符串
     
     - returns: MD5后字符串
     */
    class public func MD5_16(tText:String) ->String {
        let tBack = tText.md5().uppercaseString;
        return tBack.substringWithRange(tBack.startIndex.advancedBy(8) ..< tBack.endIndex.advancedBy(-8));
    }
    
    /**
     Md5 16位字节
     
     - parameter tText: 加密字符串
     
     - returns: MD5字节数组
     */
    class public func MD5_byte(tText:String) ->[UInt8] {
        var a_byBack:[UInt8] = [UInt8]()
        for i in 0 ..< 16
        {
            var tBack = tText.md5().uppercaseString;
            tBack = tBack.substringWithRange(tBack.startIndex.advancedBy(i*2+0) ..< tBack.startIndex.advancedBy(i*2+2));
            a_byBack.append(UInt8(tBack,radix: 16) ?? 0);
            
            
        }
        return a_byBack;
    }
    
    /**
     sha1 40位大写
     
     - parameter tText: 加密字符串
     
     - returns: sha1后字符串
     */
    class public func SHA1_40(tText:String) ->String {
        return tText.sha1().uppercaseString;
    }
    
    /**
     Base64位加密
     
     - parameter a_byByte: 加密字节数组
     
     - returns: 加密后字节数组
     */
    class public func Base64Encryptor(a_byByte:[UInt8]) ->[UInt8] {
        let encodedData = NSData(bytes:a_byByte);
        let nsEncode = encodedData.base64EncodedDataWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
        let encodeString = NSString(data: nsEncode, encoding: NSUTF8StringEncoding)
        return JKConvert.toByteArray(JKConvert.toString(encodeString!));
    }
    
    /**
     Base64位解密
     
     - parameter a_byByte: 解密字节数组
     
     - returns: 解密后字节数组
     */

    class public func Base64Decryptor(a_byByte:[UInt8]) ->[UInt8] {
        let decodedData = NSData(base64EncodedData:NSData(bytes:a_byByte), options: NSDataBase64DecodingOptions(rawValue: 0));
        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
        return JKConvert.toByteArray(JKConvert.toString(decodedString!));
    }
    
    /**
     AES 128位加密(CBC/Nopadding)
     
     - parameter a_byByte: 加密字节数组
     
     - parameter tKey:加密钥匙
     
     - returns: 加密后字节数组
     */

    class public func AESEncryptor(a_byByte:[UInt8],tKey:String)->[UInt8] {
        do {
            let enc = try AES(key: MD5_16(tKey), iv: MD5_16(tKey), blockMode:.CBC).encrypt(a_byByte)
            return enc;
        } catch let error as NSError {
            JKLog.ErrorLog("AES加密失败.原因为:" + error.localizedDescription);
            return [UInt8]();
        }
    }
    
    /**
     AES 128位解密(CBC/Nopadding)
     
     - parameter a_byByte: 解密字节数组
     
     - parameter tKey:解密钥匙
     
     - returns: 解密后字节数组
     */
    
    class public func AESDecryptor(a_byByte:[UInt8],tKey:String)->[UInt8] {
        do {
            let enc = try AES(key: MD5_16(tKey), iv: MD5_16(tKey), blockMode:.CBC).decrypt(a_byByte)
            return enc;
        } catch let error as NSError {
            JKLog.ErrorLog("AES解密失败.原因为:" + error.localizedDescription);
            return [UInt8]();
        }
    }
}