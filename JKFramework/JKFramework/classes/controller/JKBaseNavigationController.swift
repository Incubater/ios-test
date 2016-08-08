//
//  JKBaseUIViewController.swift
//  JKFramework
//
//  Created by Cjj on 16/2/16.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKBaseNavigationController: UINavigationController{

    /**界面参数集合*/
    public var a_tParam:[String: AnyObject] = [String:AnyObject]();
    
    override public func loadView() {
        super.loadView()
        if (self.topViewController != nil)
        {
            JKControllerManager.SetParameter(self.topViewController!,a_tParam: a_tParam);
        }
    }
    
    /**
     进入界面
     
     - parameter tViewController: 界面storyboard名字
     */
    public func StartStoryBoard(tViewController:String)
    {
        let vcController = UIStoryboard(name: tViewController, bundle: nil).instantiateInitialViewController();
        if (vcController as? JKBaseNavigationController != nil)
        {
            presentViewController(vcController!, animated: true, completion: nil);
        }
        else {
            pushViewController(vcController!, animated: true);
        }
    }
    
    
    /**
     进入界面
     - parameter tViewController: 界面storyboard名字
     - parameter a_tParam: 传递参数
     */
    public func StartStoryBoard(tViewController:String,a_tParam:[String: AnyObject])
    {
        let vcController = UIStoryboard(name: tViewController, bundle: nil).instantiateInitialViewController();
        JKControllerManager.SetParameter(vcController!,a_tParam: a_tParam);
        if (vcController as? JKBaseNavigationController != nil)
        {
            presentViewController(vcController!, animated: true, completion: nil);
        }
        else {
            pushViewController(vcController!, animated: true);
        }
    }
    
    /**
     进入界面
     - parameter tViewController: 界面storyboard名字
     - parameter a_tParam: 传递参数
     - parameter mtsAnimation: 界面动画
     */
    public func StartStoryBoard(tViewController:String,a_tParam:[String: AnyObject],mtsAnimation:UIModalTransitionStyle)
    {
        let vcController = UIStoryboard(name: tViewController, bundle: nil).instantiateInitialViewController();
        JKControllerManager.SetParameter(vcController!,a_tParam: a_tParam);
        vcController?.modalTransitionStyle = mtsAnimation;
        if (vcController as? JKBaseNavigationController != nil)
        {
            presentViewController(vcController!, animated: true, completion: nil);
        }
        else {
            pushViewController(vcController!, animated: true);
        }
    }
    
    /**
     进入界面
     
     - parameter tViewController: 界面storyboard名字
     - parameter mtsAnimation: 界面动画
     */
    public func StartStoryBoard(tViewController:String,mtsAnimation:UIModalTransitionStyle)
    {
        let vcController = UIStoryboard(name: tViewController, bundle: nil).instantiateInitialViewController();
        vcController?.modalTransitionStyle = mtsAnimation;
        if (vcController as? JKBaseNavigationController != nil)
        {
            presentViewController(vcController!, animated: true, completion: nil);
        }
        else {
            pushViewController(vcController!, animated: true);
        }
    }

}