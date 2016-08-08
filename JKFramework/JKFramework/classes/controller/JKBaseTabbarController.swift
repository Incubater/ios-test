//
//  JKBaseUIViewController.swift
//  JKFramework
//
//  Created by Cjj on 16/2/16.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKBaseTabbarController: UITabBarController,UITabBarControllerDelegate{

    /**界面参数集合*/
    public var a_tParam:[String: AnyObject] = [String:AnyObject]();
    
    override public func loadView() {
        super.loadView()
        self.delegate = self;
        if (viewControllers != nil)
        {
            for i in 0 ..< viewControllers!.count
            {
                let vcController = viewControllers![i];
                JKControllerManager.SetParameter(vcController,a_tParam: a_tParam);
            }
        }
    }
    
    /**
     进入界面
     
     - parameter tViewController: 界面storyboard名字
     */
    public func StartStoryBoard(tViewController:String)
    {
        if (selectedViewController != nil)
        {
            if (selectedViewController as? JKBaseNavigationController != nil)
            {
                (selectedViewController as! JKBaseNavigationController).StartStoryBoard(tViewController);
            }
            else if (selectedViewController as? JKBaseViewController != nil)
            {
                (selectedViewController as! JKBaseViewController).StartStoryBoard(tViewController);
            }
        }
    }
    
    
    /**
     进入界面
     - parameter tViewController: 界面storyboard名字
     - parameter a_tParam: 传递参数
     */
    public func StartStoryBoard(tViewController:String,a_tParam:[String: AnyObject])
    {
        if (selectedViewController != nil)
        {
            if (selectedViewController as? JKBaseNavigationController != nil)
            {
                (selectedViewController as! JKBaseNavigationController).StartStoryBoard(tViewController,a_tParam:a_tParam);
            }
            else if (selectedViewController as? JKBaseViewController != nil)
            {
                (selectedViewController as! JKBaseViewController).StartStoryBoard(tViewController,a_tParam:a_tParam);
            }
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
        if (selectedViewController != nil)
        {
            if (selectedViewController as? JKBaseNavigationController != nil)
            {
                (selectedViewController as! JKBaseNavigationController).StartStoryBoard(tViewController,a_tParam:a_tParam,mtsAnimation: mtsAnimation);
            }
            else if (selectedViewController as? JKBaseViewController != nil)
            {
                (selectedViewController as! JKBaseViewController).StartStoryBoard(tViewController,a_tParam:a_tParam,mtsAnimation: mtsAnimation);
            }
        }
    }
    
    /**
     进入界面
     
     - parameter tViewController: 界面storyboard名字
     - parameter mtsAnimation: 界面动画
     */
    public func StartStoryBoard(tViewController:String,mtsAnimation:UIModalTransitionStyle)
    {
        if (selectedViewController != nil)
        {
            if (selectedViewController as? JKBaseNavigationController != nil)
            {
                (selectedViewController as! JKBaseNavigationController).StartStoryBoard(tViewController,mtsAnimation: mtsAnimation);
            }
            else if (selectedViewController as? JKBaseViewController != nil)
            {
                (selectedViewController as! JKBaseViewController).StartStoryBoard(tViewController,mtsAnimation: mtsAnimation);
            }
        }
    }
    
    /**
     Tabbar切换事件
     
     - parameter tabBarController: tabbar对象
     - parameter viewController:   切换的viewcontroller
     */
    public func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController)
    {
        if (viewController as? JKBaseViewController != nil)
        {
            JKControllerManager.SetController(JKControllerManager.getAllController().count-1, jkbvController: viewController as! JKBaseViewController);
        }
        else if (viewController as? JKBaseNavigationController != nil)
        {
            let currentControler = (viewController as! JKBaseNavigationController).topViewController;
            if (currentControler != nil)
            {
                JKControllerManager.SetController(JKControllerManager.getAllController().count-1, jkbvController: currentControler as! JKBaseViewController);
            }
        }
    }

}