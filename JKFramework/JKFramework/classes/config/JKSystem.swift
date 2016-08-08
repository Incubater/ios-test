//
//  JKSystem.swift
//  JKFramework
//
//  Created by Cjj on 16/2/17.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import ReachabilitySwift
import Device
import AVFoundation
import AdSupport

public class JKSystem {
    
    
    /**
    * 获取当前正在运行的Controller
    * @return 当前运行的Controller,获取失败返回null
    */
    public class func GetCurrentController()->JKBaseViewController?
    {
        if (JKControllerManager.getAllController().count - 1>=0)
        {
                  return JKControllerManager.getAllController()[JKControllerManager.getAllController().count - 1];
        }
//        for (var i=JKControllerManager.getAllController().count - 1; i>=0; i -= 1)
//        {
//            //if (JKControllerManager.getAllController().get(i).IsRun())
//            return JKControllerManager.getAllController()[i];
//        }
        return nil;
    }
    
    /**
     * 获取屏幕状态
     * @return 横屏为0,竖屏为1
     */
    public class func GetScreenOrientation()->Int
    {
        if (UIScreen.mainScreen().bounds.width > UIScreen.mainScreen().bounds.height)
        {
            return 0;
        }
        else
        {
            return 1;
        }
    }
    
    /**
     * 获取屏幕可显示宽高(包括状态栏,不包括虚拟按钮)
     * @param nOrientation 横屏为0,竖屏为1
     * @return 返回x为宽y为高
     */
    public class func GetScreenOrientation(nOrientation:Int)->CGPoint
    {
        return CGPoint(x: UIScreen.mainScreen().bounds.width,y: UIScreen.mainScreen().bounds.height);
    }
    
    /**
     * 获取手机状态栏高度
     * @return > 0 success; <= 0 fail
     */
    public class func GetStatusHeight()->Int
    {
        return Int(UIScreen.mainScreen().bounds.origin.y);
    }
    
    /**
    * 打开软键盘
    * @param vView 打开软键盘的视图
    */
    public class func OpenKeyboard(vView:UIView)
    {
        vView.becomeFirstResponder();
    }
    
    
    /**
     * 关闭软键盘
     */
    public class func CloseKeyboard()
    {
        let CurrentController = JKSystem.GetCurrentController();
        CurrentController?.view.endEditing(true);
    }
    
    /**
    * 关闭软键盘
    * @param vView 关闭软键盘的视图
    */
    public class func CloseKeyboard(vView:UIView)
    {
        vView.resignFirstResponder();
    }
    
    /**
     检查是否为平板
     
     - returns: true表示为平板
     */
    public class func IsTable()->Bool
    {
        return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
    }
    
    /**
     获取屏幕密度
     
     - returns: 手机密度
     */
    public class func GetDensity()->Float
    {
        return Float(UIScreen.mainScreen().scale);
    }
    
    /**
     是否连接网络
     
     - returns: true表示已连接
     */
    public class func IsNetwork()->Bool
    {
        do
        {
            let reachability = try Reachability.reachabilityForInternetConnection()
            
            //判断连接类型
            if reachability.isReachable() {
                return true;
            }
        }
        catch {
            
        }
        return false;
    }
    
    /**
     是否连接wifi
     
     - returns: true表示连接wifi
     */
    public class func IsWifi()->Bool
    {
        do
        {
            let reachability = try Reachability.reachabilityForInternetConnection()

            //判断连接类型
            if reachability.isReachableViaWiFi() {
                return true;
            }
        }
        catch {
            
        }
        return false;
    }
    
    /**
     获取手机电量
     
     - returns: 手机电量
     */
    public class func GetBatteryPer()->Int
    {
        UIDevice.currentDevice().batteryMonitoringEnabled = true;
        return (Int)(UIDevice.currentDevice().batteryLevel*100);
    }
    
    /**
     获取设备详细型号
     
     - returns: 设备详细型号
     */
    public class func GetDevice()->String
    {
        return Device.version().rawValue;
    }
    
    /**
     获取系统版本号
     
     - returns: 系统版本号
     */
    public class func GetSDKVersion()->Int
    {
        var a_tVersion = JKAnalysis.Split(UIDevice.currentDevice().systemVersion, tDelimiter: ".");
        var nBack = 0;
        for i in 0 ..< a_tVersion.count
        {
            switch (i)
            {
            case 0:
                nBack += JKConvert.toInt(a_tVersion[i]) * 10000000;
                break;
            case 1:
                nBack += JKConvert.toInt(a_tVersion[i]) * 100000;
                break;
            case 2:
                nBack += JKConvert.toInt(a_tVersion[i]) * 1000;
                break;
            default:
                nBack += JKConvert.toInt(a_tVersion[i]);
                break;
            }
        }
        return nBack;
    }
    
    /**
     获取程序外部版本号
     
     - returns: 程序外部版本号
     */
    public class func GetVersionString()->String
    {
        var a_bdInfo = NSBundle.mainBundle().infoDictionary;
        return a_bdInfo!["CFBundleShortVersionString"] as! String;
    }
    
    /**
     获取程序外部版本号
     
     - returns: 程序外部版本号
     */
    public class func GetVersionCode()->String
    {
        var a_bdInfo = NSBundle.mainBundle().infoDictionary;
        return a_bdInfo!["CFBundleVersion"] as! String;
    }
    
    /**
     打开浏览器
     
     * @param tUrl 浏览器地址
     */
    public class func OpenBrowser(tUrl:String)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: tUrl)!)
    }
    
    /**
     * 清除应用所有数据
     */
    public class func CleanCache(){
        JKFile.DeleteFile(JKFile.GetPublicCachePath());
    }
    
    /**
     * 获取总内存空间
     * @return 返回总内存空间字节大小
     */
    class public func GetSystemMemorySize() -> Int64
    {
        return Int64(NSProcessInfo().physicalMemory)
    }
    
    /**
     * 获取可用内存空间
     * @return 返回可用内存空间字节大小
     */
    class public func GetRemainSystemMemorySize() -> Int64
    {
        let HOST_VM_INFO_COUNT: mach_msg_type_number_t = mach_msg_type_number_t(sizeof(vm_statistics_data_t) / sizeof(integer_t))
        
        let host: host_t = mach_host_self()
        
        var pageSize: vm_size_t = vm_size_t()
        let hostPageSizeKernStatus: kern_return_t = host_page_size(host, &pageSize)
        guard hostPageSizeKernStatus == KERN_SUCCESS else {
            return 0
        }
        
        var stats: vm_statistics_data_t = vm_statistics_data_t()
        var count: mach_msg_type_number_t = HOST_VM_INFO_COUNT
        
        let kernStatus: kern_return_t = withUnsafeMutablePointer(&stats) {
            return host_statistics(host, HOST_VM_INFO, host_info_t($0), &count)
        }
        
        guard kernStatus == KERN_SUCCESS else {
            return 0
        }
        
        return Int64(stats.free_count) * Int64(pageSize)
    }
    
    
    /**
     * 获取是否越狱
     * @return 返回是否越狱
     */
    class public func IsRoot() -> Bool
    {
        var jailbroken = false;
        let cydiaPath = "/Applications/Cydia.app";
        let aptPath = "/private/var/lib/apt/";
        if (NSFileManager.defaultManager().fileExistsAtPath(cydiaPath))
        {
            jailbroken = true;
        }
        if (NSFileManager.defaultManager().fileExistsAtPath(aptPath))
        {
           jailbroken = true;
        }
        return jailbroken;
    }
    
    /**
     * 打开手电筒
     */
    
    public class func OpenFlashLight()
    {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device != nil && device.hasTorch)
        {
            do
            {
                try device.lockForConfiguration()
                device.torchMode=AVCaptureTorchMode.On
                device.unlockForConfiguration()
            }
            catch
            {
                
            }
        }
    }
    
    /**
     * 关闭手电筒
     */
    public class func CloseFlashLight()
    {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device != nil && device.hasTorch)
        {
            do
            {
                try device.lockForConfiguration()
                device.torchMode=AVCaptureTorchMode.Off
                device.unlockForConfiguration()
            }
            catch
            {
                
            }
        }
    }
    
    /**
     * 查看是否在主线程
     * @return true表示在主线程
     */
    public class func IsMainThread()->Bool
    {
         return NSRunLoop.currentRunLoop() == NSRunLoop.mainRunLoop();
    }
    
    /**
     * 获取android设备唯一标示
     * @return android唯一标示字符串
     */
    public class func GetGUID() ->String {
        if (Device.type() == Type.Simulator)
        {
            return "00000000-0000-0000-0000-000000000000";
        }
        else {
            return ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString;
        }
    }
}
