//
//  JKExceptionController.swift
//  JKFramework
//
//  Created by Cjj on 16/2/26.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import SnapKit

public class JKExceptionController: JKBaseViewController,UITextFieldDelegate{

    
    /**ScrollView*/
    private var svScroll = UIScrollView();
    /**崩溃文字控件*/
    private var clDesc = UILabel();
    /**反射函数输入*/
    private var tfInput = UITextField();
    /**调试按钮*/
    private var cbTest = UIButton(type: UIButtonType.System);
    /**退出按钮*/
    private var cbExit = UIButton(type: UIButtonType.System);
    
    override public func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor();
        
        InitView();
        InitListener();
        InitData();
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad();
        clDesc.sizeToFit();
        svScroll.contentSize.height = clDesc.frame.height;
        tfInput.delegate = self;
    }
    
    override public func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }


    func InitView()
    {
        self.view.addSubview(svScroll);
        
        clDesc.frame = CGRect(x:10,y: 0,width: JKSystem.GetScreenOrientation(1).x - 20,height:0);
        clDesc.textAlignment = NSTextAlignment.Left
        clDesc.contentMode = UIViewContentMode.Top
        clDesc.lineBreakMode = NSLineBreakMode.ByWordWrapping
        clDesc.numberOfLines = 0;
        clDesc.font = UIFont.systemFontOfSize(10);
        svScroll.addSubview(clDesc);
        
        cbTest.setTitle("调试", forState: UIControlState.Normal);
        cbTest.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(cbTest);
        
        cbExit.setTitle("退出", forState: UIControlState.Normal);
        cbExit.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(cbExit);
    
        tfInput.placeholder = "请输入反射函数";
        tfInput.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(tfInput);


        tfInput.snp_makeConstraints(closure: {make in
            make.height.equalTo(30)
            make.bottom.equalTo(cbExit.snp_top).offset(-10);
            make.left.equalTo(10)
            make.right.equalTo(-10)
        })
        
        tfInput.snp_remakeConstraints(closure: {make in
            make.width.height.equalTo(0)
            make.left.equalTo(self.view.snp_left)
            make.bottom.equalTo(cbExit.snp_top);
        })
        
        cbExit.snp_makeConstraints(closure: {make in
            make.height.equalTo(30)
            make.left.equalTo(cbTest.snp_right).offset(10)
            make.right.equalTo(self.view.snp_right).offset(-10)
            make.bottom.equalTo(self.view.snp_bottom).offset(-10);
        })
        
        cbTest.snp_makeConstraints(closure: {make in
            make.width.equalTo(cbExit.snp_width)
            make.height.equalTo(cbExit.snp_height)
            make.left.equalTo(self.view.snp_left).offset(10)
            make.bottom.equalTo(cbExit.snp_bottom);
        })
        
        cbTest.snp_remakeConstraints(closure: {make in
            make.width.height.equalTo(0)
            make.left.equalTo(self.view.snp_left)
            make.bottom.equalTo(cbExit.snp_bottom);
        })
        
        svScroll.snp_makeConstraints(closure: {make in
            make.width.equalTo(self.view.snp_width)
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
            make.top.equalTo(self.view).offset(JKSystem.GetStatusHeight() + 10)
            make.bottom.equalTo(tfInput.snp_top)
        })
        
//        clDesc.snp_makeConstraints(closure: {make in
//            make.top.equalTo(0);
//            make.left.equalTo(10);
//            make.width.equalTo(JKSystem.GetScreenOrientation(1).x - 20);
//        })

    }
    
    func InitListener()
    {
        cbTest.addTarget(self,action:#selector(JKExceptionController.Debug),forControlEvents:UIControlEvents.TouchUpInside)
        cbExit.addTarget(self,action:#selector(JKExceptionController.Exit),forControlEvents:UIControlEvents.TouchUpInside)
    }
    
    func InitData()
    {
        clDesc.text = a_tParam["ReportText"] as? String;
    }
    
    func Debug(){
//        JKException.ExitProgram();
        JKToast.Show("反射", nType: 1);
    }
    
    
    func Exit(){
//        JKException.ExitProgram();
        abort();
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        Debug();
        return true;
    }
    
}