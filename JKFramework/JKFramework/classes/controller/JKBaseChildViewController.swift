//
//  JKBaseUIViewController.swift
//  JKFramework
//
//  Created by Cjj on 16/2/16.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

public class JKBaseChildViewController: UIViewController {
    
    /**智能键盘返回设置*/
    public var iqkrhHandler:IQKeyboardReturnKeyHandler?;


    override public func loadView() {
        super.loadView()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad();
        iqkrhHandler = IQKeyboardReturnKeyHandler(controller: self);
        iqkrhHandler?.lastTextFieldReturnKeyType = UIReturnKeyType.Send;
        iqkrhHandler?.addResponderFromView(self.view);
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
    }
    
    deinit{
        iqkrhHandler = nil;
    }
}