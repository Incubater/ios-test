//
//  JKThread.swift
//  JKFramework
//
//  Created by Cjj on 16/2/2.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import Async

public class JKThread
{
    public typealias callback = () -> Void
    
    public init() {
    }
    
    /**
    * 执行短期线程功能
    * @param l 线程功能监听
    */
    public func Start(onThread: callback,onMain: callback)
    {
        Async.background {
            onThread();
        }.main {
            onMain();
        }
    }
   
}