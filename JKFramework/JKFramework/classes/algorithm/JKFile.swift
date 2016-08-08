//
//  File.swift
//  JKFramework
//
//  Created by ymook on 15/12/10.
//  Copyright © 2015年 Cjj. All rights reserved.
//

import Foundation
import PathKit

public class JKFile
{
    /**
     判断文件是否存在
     - parameter tPath: 路径
     - returns: 是否存在 true为存在
     */
    class public func IsExists(tPath: String) -> Bool {
        return PathKit.Path(tPath).exists;
    }
    
    /**
     判断文件或文件夹是否为文件夹
     - parameter tPath: 路径
     - returns: 是否为文件夹
     */
    class public func IsDirectory(tPath: String) -> Bool {
        
        return PathKit.Path(tPath).isDirectory;
    }
    
    /**
     判断文件或文件夹是否为文件
     - parameter tPath: 路径
     - returns: 是否为文件
     */
    class public func IsFile(tPath: String) -> Bool {
        return Path(tPath).isFile;
    }
    
    /**
     创建当前文件路径下的文件夹
     - parameter tPath: 路径
     */
    class public func CreateDir(tPath: String) {
        do {
            let nPos = tPath.rangeOfString("/", options: NSStringCompareOptions.BackwardsSearch);
            let tPathTmp = tPath.substringWithRange(tPath.startIndex ..< nPos!.startIndex);
            try NSFileManager.defaultManager().createDirectoryAtPath(tPathTmp, withIntermediateDirectories: true, attributes: nil)
        } catch _ as NSError {
        }
    }
    
    /**
     读取文件
     - parameter tFileName: 路径
     - returns: 文件内容
     */
    class public func ReadFile(tFileName: String, tEncoding: String = "UTF-8") -> String {
        do {
            switch (tEncoding.uppercaseString)
            {
            case "UTF-8":
                return try Path(tFileName).read(NSUTF8StringEncoding)
            case "GBK":
                let enc = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                return try Path(tFileName).read(enc)
            default:
                return try Path(tFileName).read(NSUTF8StringEncoding)
            }
        } catch let error as NSError {
            JKLog.ErrorLog("读入字符串数据失败.原因为:" + error.localizedDescription);
            return "";
        }
    }
    
    /**
     写入文件字符串
     - parameter tFileName: 路径
     - parameter tText:     写入内容
     - parameter tEncoding:     字符编码
     */
    class public func WriteFile(tPath: String, tText: String, tEncoding: String = "UTF-8") {
        do {
            switch (tEncoding.uppercaseString)
            {
            case "UTF-8":
                try Path(tPath).write(tText, encoding: NSUTF8StringEncoding)
            case "GBK":
                let enc = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                try Path(tPath).write(tText, encoding: enc)
            default:
                try Path(tPath).write(tText, encoding: NSUTF8StringEncoding)
            }
        } catch let error as NSError {
            JKLog.ErrorLog("写入字符串数据失败.原因为:" + error.localizedDescription);
        }
    }
    
    /**
     * 以覆盖的方式写入文件
     * @param tPath 文本的路径地址
     * @param buffer 写入的数据数组
     */
    class public func WriteFile(tPath: String, buffer: [UInt8])
    {
        do {
            try Path(tPath).write(NSData(bytes: buffer))
        } catch let error as NSError {
            JKLog.ErrorLog("存储文件字节数组失败.原因为:" + error.localizedDescription);
        }
    }
    
    /**
     末尾追加文件字符串(默认UTF-8)
     - parameter tFileName: 路径
     - parameter tText:     写入内容
     */
    class public func AppendFile(tPath: String, tText: String) {
        let fielHandle = NSFileHandle(forWritingAtPath: tPath);
        fielHandle?.seekToEndOfFile();
        fielHandle?.writeData(NSData(bytes: JKConvert.toByteArray(tText)));
        fielHandle?.closeFile();
    }
    
    /**
     * 以末尾追加的方式写入文件(默认UTF-8)
     * @param tPath 文本的路径地址
     * @param buffer 写入的字符串
     */
    class public func AppendFile(tPath: String, buffer: [UInt8])
    {
        let fielHandle = NSFileHandle(forWritingAtPath: tPath);
        fielHandle?.seekToEndOfFile();
        fielHandle?.writeData(NSData(bytes: buffer));
        fielHandle?.closeFile();
    }
    
    /**
     获取当前平台下的应用路径(末尾不带/)
     - returns: 当前平台下的应用路径
     */
    class public func GetCurrentPath() -> String {
        return String(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)[0])
    }
    
    /**
     获取当前平台下的保存文件路径(末尾不带/)
     - returns: 当前平台下的保存文件路径
     */
    class public func GetPublicPath() -> String {
        return String(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0])
    }
    
    /**
     获取当前平台下的缓存路径(末尾不带/)
     - returns: 当前平台下的缓存路径
     */
    class public func GetPublicCachePath() -> String {
        return String(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0])
    }
    
    /**
     获取文件大小
     - parameter tPath: 路径
     - returns: 文件大小
     */
    class public func GetFileSize(tPath: String) -> UInt64 {
        do {
            let attributes: NSDictionary = try NSFileManager.defaultManager().attributesOfItemAtPath(tPath)
            return attributes.fileSize()
        } catch let error as NSError {
            JKLog.ErrorLog("获取文件大小失败.原因为:" + error.localizedDescription);
            return 0
        }
    }
    
    /**
     拷贝文件到指定路径
     - parameter tSourceFile: 文件路径
     - parameter tTargetFile: 目标路径
     */
    class public func CopyFile(tSourceFile: String, tTargetFile: String) {
        if (!IsExists(tSourceFile)) {
            return;
        }
        CreateDir(tTargetFile);
        do {
            try Path(tSourceFile).copy(Path(tTargetFile));
        } catch let error as NSError {
            JKLog.ErrorLog("复制文件(夹)失败.原因为:" + error.localizedDescription);
        }
    }
    
    /**
     删除文件(夹)
     - parameter tFile: 文件(夹)路径
     */
    class public func DeleteFile(tFile:String) {
        do {
            try Path(tFile).delete();
        } catch let error as NSError {
            JKLog.ErrorLog("删除文件(夹)失败.原因为:" + error.localizedDescription);
        }
    }
    
    /**
     * 读取文件
     * @param tPath 文件路径地址
     * @return 返回文件字节数组
     */
    class public func ReadBytes(tPath: String) -> [UInt8]
    {
        do {
            let nsReturn:NSData = try Path(tPath).read()
            var bytes = [UInt8](count: nsReturn.length, repeatedValue: 0)
            nsReturn.getBytes(&bytes, length: nsReturn.length)
            return bytes
        } catch let error as NSError {
            JKLog.ErrorLog("读取文件字节数组失败.原因为:" + error.localizedDescription);
        }
        return []
    }
    
    /**
     * 读取Assets文件(默认UTF-8)
     * @param tPath 文件路径地址
     * @return 返回文件字符串
     */
    class public func ReadAssetsFile(tPath: String , tEncoding: String = "UTF-8") -> String
    {
        let tFileName = JKConvert.toNSString(tPath).stringByDeletingPathExtension
        let tFileType = JKConvert.toNSString(tPath).pathExtension
        guard let tAssetsPath = NSBundle.mainBundle().pathForResource(tFileName, ofType: tFileType) else { return "" }
        return JKFile.ReadFile(tAssetsPath, tEncoding: tEncoding)
    }
    
    /**
     * 读取Assets文件(默认UTF-8)
     * @param tPath 文件路径地址
     * @return 返回文件字符串
     */
    class public func ReadAssets(tPath: String) -> [UInt8]
    {
        let tFileName = JKConvert.toNSString(tPath).stringByDeletingPathExtension
        let tFileType = JKConvert.toNSString(tPath).pathExtension
        guard let tAssetsPath = NSBundle.mainBundle().pathForResource(tFileName, ofType: tFileType) else { return [] }
        return JKFile.ReadBytes(tAssetsPath)
    }
    
    /**
     * 获取文件后缀名
     * @param tPath 文件路径地址
     * @return 返回文件后缀名字符串
     */
    class public func GetFileExtension(tPath: String) -> String
    {
        guard IsFile(tPath) else { return ""}
        return Path(tPath).`extension` ?? ""
    }
    
    /**
     * 获取文件文件名
     * @param tPath 文件路径地址
     * @return 返回不带扩展名的文件名字符串
     */
    class public func GetBaseName(tPath: String) -> String
    {
        guard IsFile(tPath) else { return ""}
        return Path(tPath).lastComponentWithoutExtension
    }
    
    /**
     * 获取总存储空间
     * @return 返回总存储空间字节大小
     */
    class public func GetSDCardSize() -> Int64
    {
        do {
            let systemAttributes = try NSFileManager.defaultManager().attributesOfFileSystemForPath(NSHomeDirectory() as String)
            let space = (systemAttributes[NSFileSystemSize] as? NSNumber)?.longLongValue
            return space ?? 0
        } catch {
            return 0
        }
    }
    
    /**
     * 获取可用存储空间
     * @return 返回可用存储空间字节大小
     */
    class public func GetSDCardAvailableSize() -> Int64
    {
        do {
            let systemAttributes = try NSFileManager.defaultManager().attributesOfFileSystemForPath(NSHomeDirectory() as String)
            let freeSpace = (systemAttributes[NSFileSystemFreeSize] as? NSNumber)?.longLongValue
            return freeSpace ?? 0
        } catch {
            return 0
        }
    }
    
}