//
//  JKBaseUIViewController.swift
//  JKFramework
//
//  Created by Cjj on 16/2/16.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import MBProgressHUD

public class JKBaseViewController: UIViewController {
    
    /**Controller索引*/
    public var nIndex = -1;
    /**智能键盘返回设置*/
    public var iqkrhHandler:IQKeyboardReturnKeyHandler?;
    /**界面参数集合*/
    public var a_tParam:[String: AnyObject] = [String:AnyObject]();
    /**Controller被废弃*/
    private var bAbandon = false;
    /**Controller是否锁屏中*/
    private var bLock = false;
    /**Controller是否运行中*/
    private var bRun = false;
    /**Controller是否暂停*/
    private var bPause = false;
    /**锁屏对话框对象*/
    private var jkpdDialog:JKProgressDialog?
    /**segue参数集合*/
    private var a_tTmp:[String: AnyObject] = [String:AnyObject]();

    override public func loadView() {
        super.loadView()
        
        bRun = true;
        nIndex = JKControllerManager.getAllController().count;
        
        /*当前和上一页全部是Tabbar则不新增*/
        var AllController = JKControllerManager.getAllController();
        if (nIndex != 0 && AllController[nIndex-1].tabBarController !=  nil && tabBarController != nil)
        {
            nIndex -= 1;
            JKControllerManager.SetController(nIndex-1, jkbvController: self);
        }
        else {
            JKControllerManager.AddController(self);
        }        
     
        automaticallyAdjustsScrollViewInsets = false;
        
        if (JKDebug.nDebug != 0)
        {
            NSSetUncaughtExceptionHandler { exception in
                let jkeException = JKException(tReflect: JKDebug.tReflect);
                jkeException.uncaughtException(exception);
            }
        }
        jkpdDialog = InitProgressDialog()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad();        
        iqkrhHandler = IQKeyboardReturnKeyHandler(controller: self);
        iqkrhHandler?.lastTextFieldReturnKeyType = UIReturnKeyType.Send;
        iqkrhHandler?.addResponderFromView(self.view);
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        if (!bAbandon)
        {
            bRun = true;
            if (nIndex < JKControllerManager.getAllController().count)
            {
                JKControllerManager.SetController(nIndex, jkbvController: self);
            }
        }
        bPause = false;
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        bPause = true;
    }
    
    deinit{
        iqkrhHandler = nil;
    }
    
    /**
     进入界面
     
     - parameter tViewController: 界面storyboard名字
     */
    public func StartStoryBoard(tViewController:String)
    {
        if (bRun)
        {
            bRun = false;
            let vcController = UIStoryboard(name: tViewController, bundle: nil).instantiateInitialViewController();
            if (navigationController != nil)
            {
                if (vcController as? JKBaseNavigationController != nil)
                {
                    presentViewController(vcController!, animated: true, completion: nil);
                }
                else {
                    if (tabBarController == nil)
                    {
                        navigationController?.pushViewController(vcController!, animated: true);
                    }
                    else {
                        presentViewController(vcController!, animated: true, completion: nil);
                    }

                }
            }
            else {
                presentViewController(vcController!, animated: true, completion: nil);
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
        if (bRun)
        {
            bRun = false;
            let vcController = UIStoryboard(name: tViewController, bundle: nil).instantiateInitialViewController();
            JKControllerManager.SetParameter(vcController!,a_tParam: a_tParam);
            if (navigationController != nil)
            {
                if (vcController as? JKBaseNavigationController != nil)
                {
                    presentViewController(vcController!, animated: true, completion: nil);
                }
                else {
                    if (tabBarController == nil)
                    {
                        navigationController?.pushViewController(vcController!, animated: true);
                    }
                    else {
                        presentViewController(vcController!, animated: true, completion: nil);
                    }
                }
            }
            else {
                presentViewController(vcController!, animated: true, completion: nil);
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
        if (bRun)
        {
            bRun = false;
            let vcController = UIStoryboard(name: tViewController, bundle: nil).instantiateInitialViewController();
            JKControllerManager.SetParameter(vcController!,a_tParam: a_tParam);
            vcController?.modalTransitionStyle = mtsAnimation;
            if (navigationController != nil)
            {
                if (vcController as? JKBaseNavigationController != nil)
                {
                    presentViewController(vcController!, animated: true, completion: nil);
                }
                else {
                    if (tabBarController == nil)
                    {
                        navigationController?.pushViewController(vcController!, animated: true);
                    }
                    else {
                        presentViewController(vcController!, animated: true, completion: nil);
                    }

                }

            }
            else {
                presentViewController(vcController!, animated: true, completion: nil);
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
        if (bRun)
        {
            bRun = false;
            let vcController = UIStoryboard(name: tViewController, bundle: nil).instantiateInitialViewController();
            vcController?.modalTransitionStyle = mtsAnimation;
            if (navigationController != nil)
            {
                if (vcController as? JKBaseNavigationController != nil)
                {
                    presentViewController(vcController!, animated: true, completion: nil);
                }
                else {
                    if (tabBarController == nil)
                    {
                        navigationController?.pushViewController(vcController!, animated: true);
                    }
                    else {
                        presentViewController(vcController!, animated: true, completion: nil);
                    }
                }

            }
            else {
                presentViewController(vcController!, animated: true, completion: nil);
            }
        }
    }
    
    /**
     进入界面
     
     - parameter tSegue: 界面tSegue标志
     */
    public func StartSegue(tSegue:String)
    {
        if (bRun)
        {
            bRun = false;
            performSegueWithIdentifier(tSegue,sender: self);
        }
    }
    
    /**
     进入界面
     - parameter tSegue: 界面tSegue标志
     - parameter a_tParam: 传递参数
     */
    public func StartSegue(tSegue:String,a_tParam:[String: AnyObject])
    {
        if (bRun)
        {
            bRun = false;
            a_tTmp = a_tParam;
            performSegueWithIdentifier(tSegue,sender: self);
        }
    }
    
    
    
    /**
     进入界面
     
     - parameter vcController: 界面对象
     */
    public func StartViewController(vcController:UIViewController)
    {
        if (bRun)
        {
            bRun = false;
            if (navigationController != nil)
            {
                if (vcController as? JKBaseNavigationController != nil)
                {
                    presentViewController(vcController, animated: true, completion: nil);
                }
                else {
                    if (tabBarController == nil)
                    {
                        navigationController?.pushViewController(vcController, animated: true);
                    }
                    else {
                        presentViewController(vcController, animated: true, completion: nil);
                    }

                }
            }
            else {
                presentViewController(vcController, animated: true, completion: nil);
            }
        }
    }

    /**
     进入界面
     - parameter vcController: 界面对象
     - parameter a_tParam: 传递参数
     */
    public func StartViewController(vcController:UIViewController,a_tParam:[String: AnyObject])
    {
        if (bRun)
        {
            bRun = false;
            JKControllerManager.SetParameter(vcController,a_tParam: a_tParam);
            if (navigationController != nil)
            {
                if (vcController as? JKBaseNavigationController != nil)
                {
                    presentViewController(vcController, animated: true, completion: nil);
                }
                else {
                    if (tabBarController == nil)
                    {
                        navigationController?.pushViewController(vcController, animated: true);
                    }
                    else {
                        presentViewController(vcController, animated: true, completion: nil);
                    }

                }
            }
            else {
                presentViewController(vcController, animated: true, completion: nil);
            }
        }
    }
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController as? JKBaseViewController != nil)
        {
            (segue.destinationViewController as! JKBaseViewController).a_tParam = a_tTmp;
        }
    }
    
    /**
     退出界面
     */
    public func finish()
    {
        Finish(true);
    }
    
    public func Finish(bAnimated:Bool)
    {
        if (bRun)
        {
            bRun = false;
            if (navigationController != nil)
            {
                let nCount = navigationController?.viewControllers.count;
                navigationController!.popViewControllerAnimated(bAnimated);
                if (nCount <= 1)
                {
                    dismissViewControllerAnimated(bAnimated,completion: nil);
                }
            }
            else {
                dismissViewControllerAnimated(bAnimated,completion: nil);
            }
            if (!bAbandon)
            {
                JKControllerManager.RemoveController(nIndex);
                //恢复后面的索引序号
                for i in nIndex..<JKControllerManager.getAllController().count
                {
                    JKControllerManager.getAllController()[i].nIndex -= 1;
                }
                //恢复前一个页面的run状态
                if (JKControllerManager.getAllController().count >= nIndex)
                {
                    JKControllerManager.getAllController()[nIndex - 1].bRun = true;
                }
            }
        }
    }
    
    /**
    * Controller状态是否被废弃
    * @return true表示已废弃
    */
    public func IsAbandon()->Bool
    {
        return bAbandon;
    }
    
    /**
    * 设置是否废弃Controller
    * @param abandon true表示废弃
    */
    public func setAbandon(abandon:Bool) {
        bAbandon = abandon;
    }
    
    /**
    * Controller是否正常运作中
    * @return true表示正常运作中
    */
    public func IsRun()->Bool
    {
        return bRun;
    }
    
    /**
    * 程序是否在后台
    * @return true表示是
    */
    public func IsBackground()->Bool
    {
        return bPause;
    }
    
    /**
    * 恢复当前Activity
    */
    public func Restore()
    {
        bRun = true;
        JKControllerManager.SetController(nIndex, jkbvController: self);
    }
    
    public func InitProgressDialog()->JKProgressDialog
    {
        let pdProgressDialog = JKProgressDialog(vc: self);
        return pdProgressDialog;
    }
    
    /**
    * 锁屏对话框
    * @param tMessage 锁屏提示信息
    * @param bCancel 是否取消锁屏
    */
    public func LockScreen(tMessage:String)
    {
//        if (isFinishing())
//            return;
        if (jkpdDialog!.isShowing())
        {
            jkpdDialog?.setMessage(tMessage)
        }
        else {
            if (!bLock)
            {
                bLock = true;
                jkpdDialog = InitProgressDialog()
                jkpdDialog?.setMessage(tMessage)
                jkpdDialog?.show();
            }
        }
    }
    
    
    /**
    * 解除锁屏对话框
    */
    public func UnlockScreen()
    {
        bLock = false;
        if (jkpdDialog!.isShowing())
        {
            jkpdDialog?.dismiss()
        }        
    }
    
}