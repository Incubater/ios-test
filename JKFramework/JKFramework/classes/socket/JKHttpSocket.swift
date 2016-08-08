 //
//  JKHttpSocket.swift
//  JKFramework
//
//  Created by Cjj on 16/2/1.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import Alamofire

public class JKHttpSocket
{
    /**发送模式(0为Get类型,1为Post类型)*/
    private var nMode = 0;
    /**访问地址*/
    private var tUrl = "";
    /**内容下载地址*/
    private var tDownPath = "";
    /**接受内容*/
    private var rsResponse:Response<NSData, NSError>?
    /**Post参数类型(-1为无参数,0为流类型,1为url键值对类型,2位json类型)*/
    private var nPostParam = -1;
   	/** 表单构造对象 */
    private var a_tParam:[String: AnyObject] = [String:AnyObject]();
    /** 表头*/
    private var a_theaders = [String:String]();
    /** http管理对象*/
    private var rbSend:Manager?
    /**请求对象*/
    private var rRequest:Request?;
    /**发送成功回调*/
    public typealias receiveOK = (h_header:NSDictionary,tBack:String,a_byByte:[UInt8]) -> Void
    /**发送失败回调*/
    public typealias receiveFaild = (nCode:Int) -> Void

    
    public init() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 10    // 秒
        config.timeoutIntervalForResource = 10
        self.rbSend = Manager(configuration: config)
        rbSend?.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: NSURLSessionAuthChallengeDisposition = .PerformDefaultHandling
            var credential: NSURLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = NSURLSessionAuthChallengeDisposition.UseCredential
                credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .CancelAuthenticationChallenge
                } else {
                    credential = self.rbSend?.session.configuration.URLCredentialStorage?.defaultCredentialForProtectionSpace(challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .UseCredential
                    }
                }
            }
            return (disposition, credential)
        }
    }
    
    /**
    * 设置类型
    * @param tType	设置类型为"post"或"get"(无视大小写)
    * @param tUrl	请求的网络地址
    * @return 返回0表示成功,1表示URL不正确,2表示网络错误
    */
    
    public func InitType(tType:String,tUrl:String)->Int
    {
        if (tType.lowercaseString == "get")
        {
            nMode = 0;
        }
        else
        {
            nMode = 1;
        }
        self.tUrl = tUrl;
        return 0;
    }
    
    /**
     * 设置Post参数
     * @param tValue 字符串类型参数
     */
    public func SetParameterSteam(tValue:String) {
        nPostParam = 0;
//        a_tParam[] = tValue;
    }
    
    /**
     * 设置Post参数
     * @param tKey 键
     * @param tValue 值
     */
    public func SetParameterUrl(tKey:String,tValue:String) {
        nPostParam = 1;
        a_tParam[tKey] = tValue;
    }
    
    /**
     * 设置Post参数
     * @param tValue json字符串
     */
    public func SetParameterJson(tValue:String) {
        nPostParam = 2;
        do
        {
            let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(NSData(bytes: JKConvert.toByteArray(tValue)),options: NSJSONReadingOptions.AllowFragments)
            a_tParam = (json as? [String: AnyObject])!;
        }
        catch _ as NSError {
        }
    }
    
    /**
    * 设置表头
    * @param tKey  表头键名
    * @param tValue 表头值
    */
    public func SetHead(tKey:String,tValue:String)
    {
        a_theaders[tKey] = tValue;
    }
    
    /**
    * 发送Http协议
    * @param m_socketTmp http回调
    */
    public func SendAsync(ReciveOK: receiveOK,ReciveFaild: receiveFaild)
    {
        if (1 == nMode)
        {
            if (nPostParam == 0)
            {
                //rRequest = rbSend.request(.POST, tUrl,parameters:a_tParam,headers:a_theaders);
            }
            else if (nPostParam == 1)
            {
                rRequest = rbSend?.request(.POST, tUrl,parameters:a_tParam,headers:a_theaders);
            }
            else if (nPostParam == 2)
            {
                rRequest = rbSend?.request(.POST, tUrl,parameters:a_tParam,encoding: .JSON,headers:a_theaders);
            }
        }
        else {
            rRequest = rbSend?.request(.GET, tUrl);
        }
        
       rRequest?.responseData { response in
            self.rsResponse = response;
            if (response.result.isSuccess)
            {
                ReciveOK(h_header: NSDictionary(),tBack: JKConvert.toString(response.result.value!.arrayOfBytes()),a_byByte:response.result.value!.arrayOfBytes());
            }
            else {
                if (response.result.error?.code == -1001)
                {
                    ReciveFaild(nCode: -3);
                    return;
                }
                else if (response.result.error?.code == -999){
                    ReciveFaild(nCode: -4);
                    return;
                }
                ReciveFaild(nCode: -2);
            }
        }
    }
    
    /**
    * 停止发送http
    */
    public func StopSend()
    {
        rRequest?.cancel();
    }
    
    /**
    * 获取返回码
    * @return 返回http失败码
    */
    private func GetCode()->Int
    {
        return Int(rsResponse?.response?.statusCode ?? -1);
    }
    
}