//
//  JKControllerManager.swift
//  JKFramework
//
//  Created by Cjj on 16/2/18.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

public class JKControllerManager {
    
    
    
    /**Controller跟踪结构*/
    public static var AllController:[JKBaseViewController] = [JKBaseViewController]()

    
    public class func getAllController()->[JKBaseViewController] {
        return self.AllController;
    }

    public class func AddController(jkbvController:JKBaseViewController) {
        self.AllController.append(jkbvController);
    }
    
    public class func SetController(nIndex:Int,jkbvController:JKBaseViewController) {
        self.AllController[nIndex] = jkbvController;
    }
    
    public class func RemoveController(nIndex:Int) {
        if (nIndex < self.AllController.count)
        {
            self.AllController.removeAtIndex(nIndex);   
        }
    }
    
    /**
    * 是否Controller全部被回收
    * @return
    */
    public class func isNull()->Bool
    {
//        return AllController == nil;
        return false;
    }
    
    /**
    * 重置Controller信息
    */
    public class func Reset()
    {
        AllController = [JKBaseViewController]()
    }

    /**
    * 废弃所有Controller信息
    */
    public class func Abandon()
    {
        for i in 0 ..< AllController.count
        {
            AllController[i].setAbandon(true);
        }
    }
    
    /**
    * 退出所有Controller
    */
    public class func Exit()
    {
        for i in 0 ..< AllController.count
        {
            AllController[i].finish();
        }
    }
    
    /**
     * 退出所有Controller
     */
    public class func SetParameter(vcController:UIViewController,a_tParam:[String: AnyObject])
    {
        if (vcController as? JKBaseNavigationController != nil)
        {
            (vcController as! JKBaseNavigationController).a_tParam = a_tParam;
        }
        else if (vcController as? JKBaseViewController != nil)
        {
            (vcController as! JKBaseViewController).a_tParam = a_tParam;
        }
        else if (vcController as? JKBaseTabbarController != nil)
        {
            (vcController as! JKBaseTabbarController).a_tParam = a_tParam;
        }

    }
}