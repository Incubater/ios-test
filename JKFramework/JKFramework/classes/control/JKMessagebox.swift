//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

@IBDesignable
public  class JKMessagebox {

    public class func Messagebox(vcController:UIViewController,tTitle:String,tMessage:String,tOK:String,OKListener:((UIAlertAction) -> Void)?,tCancel:String) {       
        let alertController = UIAlertController(title: tTitle,
                                                message: tMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: tOK, style: .Default,
                                     handler: OKListener)
        let cancelAction = UIAlertAction(title: tCancel, style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        vcController.presentViewController(alertController, animated: true, completion: nil)
    }
}
