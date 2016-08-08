//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation


public class JKPagerAdapter : NSObject,UICollectionViewDataSource  {
    
    public var jkvpPager:JKViewPager?
    
    public func SetViewPager(jkvpPager:JKViewPager)
    {
        self.jkvpPager = jkvpPager;
    }
    
    @objc public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        fatalError("这个方法必须在子类中被重写");
    }
    
    @objc public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        fatalError("这个方法必须在子类中被重写");
    }

    /**
     刷新数据
     */
    public func notifyDataSetChanged()
    {
        jkvpPager?.reloadData();
    }
}
