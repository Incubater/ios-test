//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

//@IBDesignable
public  class JKViewPager : UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    /// 布局
    private var flowLayout:UICollectionViewFlowLayout;
    /// 是否为无限轮播
    private var bMode = false;
    /// 是否为自动滚动
    private var bAutoScroll = false;
    /// 自动滚动间隔(毫秒)
    private var nInterVal = 2000;
    /// 真实数据数
    private var nRealCount = 0;
    /// 起始索引
    private var nStartIndex = 0;
    /// 结束索引
    private var nEndIndex = 0;
    /// 初始化目标位置(-2表示没有目标,-1表示初始化完毕)
    private var nTargetItem = -2;
    /// 计时器
    private var ntTimer:NSTimer?;
    /// 翻页监听
    private var mListener: OnChanged?;
    /// 滑动监听
    private var mListener2: OnScroll?;
    /// 点击监听
    private var mOnItemListener: OnItemListener?;
    /// 适配器
    private var adapter:JKPagerAdapter?;
    /// 圆点指示器
    private var upcPageControl:UIPageControl?;
    /// 滑动改变回调 (nCurrentPos:当前视图索引位置,nDirection滑动方向向右滚为正,向左走位负,bSuccess滑动成功为true回弹为false)
    public typealias OnChanged = (nCurrentPos:Int,nDirection:Int,bSuccess:Bool) -> Void
    /// 滑动与拖动中的各个界面状态 (nCurrentPos:界面所在索引位置(从0开始),vView界面布局对象,fScale界面与当前屏幕的位置(0为正中间,1为界面在当前屏幕左边,负数反之,支持浮点位置))
    public typealias OnScroll = (nCurrentPos:Int,vView:UIView?,fScale:Float) -> Void
    /// item点击事件
    public typealias OnItemListener = (adapter:JKPagerAdapter,vView:UIView?,nPosition:Int) -> Void
    
    
    /// 循环节点倍数
    private let RECYCLE_ITEMBIT = 5000;
    
    public required init?(coder aDecoder: NSCoder)
    {
        self.flowLayout = UICollectionViewFlowLayout(coder: aDecoder)!;
        super.init(coder: aDecoder)
    }
    
    deinit{
        ntTimer?.invalidate();
    }
    
    public override func awakeFromNib()
    {        
        super.awakeFromNib();
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal;

//        self.bounces = false;
        self.collectionViewLayout = flowLayout;
        self.pagingEnabled = true;
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
        self.scrollsToTop = false;
        self.delegate = self;
        self.dataSource = self;
    }
    
    /**
     设置点击事件监听
     
     - parameter mListener: 监听回调
     */
    public func SetOnItemClickListener(mListener:OnItemListener)
    {
        self.mOnItemListener = mListener
        self.delegate = self;
        self.dataSource = self;
    }
    
    /**
     设置圆点指示器
     
     - parameter pageControl: 圆点指示器
     */
    public func SetPageIndicator(pageControl:UIPageControl)
    {
        self.upcPageControl = pageControl;
    }
    
    /**
     是否为无限轮播模式
     
     - parameter bMode: true为无限模式
     */
    public func SetMode(bMode:Bool)
    {
        self.bMode = bMode;
    }
    
    /**
     设置当前项
     
     - parameter nItem:   当前索引
     - parameter bScroll: true表示为有滑动动画
     */
    public func SetCurrentItem(nItem:Int,bScroll:Bool)
    {
        if (bMode)
        {
            if (nRealCount != 0)
            {
                self.scrollToItemAtIndexPath(NSIndexPath.init(forItem: nItem, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: bScroll);
            }
            else {
                nTargetItem = nItem;
            }
        }
        else {
            if (nItem >= 0 && nItem < nRealCount)
            {
             self.scrollToItemAtIndexPath(NSIndexPath.init(forItem: nItem, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: bScroll);
            }
            else {
                nTargetItem = nItem;
            }
        }
    }
    
    public func GetCurrentItem()->Int
    {
//        if (
//        {
//            return self.indexPathsForVisibleItems()[0].item;
//        }
//        else {
//            return 0;
//        }
        return self.indexPathForItemAtPoint(self.contentOffset)?.item ?? -1;
    }

    /**
     开启自动滑动
     
     - parameter nInterVal: 滑动间隔
     */
    public func StartAutoScroll(nInterVal:Int)
    {
        bAutoScroll = true;
        self.nInterVal = nInterVal;
        ntTimer = NSTimer.scheduledTimerWithTimeInterval(JKConvert.toDouble(nInterVal)/1000.0, target: self, selector:#selector(JKViewPager.NextPage as (JKViewPager) -> () -> ()), userInfo: nil, repeats: true);
    }
    
    /**
     停止自动滑动
     */
    public func StopAutoScroll()
    {
        bAutoScroll = false;
        ntTimer?.invalidate();
    }
    
    /**
     设置视图适配器
     
     - parameter adapter: 适配器对象
     */
    public func SetAdapter(adapter:JKPagerAdapter)
    {
        self.adapter = adapter;
        self.registerClass(JKPageHolder.classForCoder(), forCellWithReuseIdentifier: "JKPageHolder");
        self.adapter!.SetViewPager(self);        
        self.reloadData()
    }
    
    /**
     滑动下一页
     */
    func NextPage()
    {
        SetCurrentItem(GetCurrentItem() + 1, bScroll: true);
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        nRealCount = self.adapter!.collectionView(collectionView,numberOfItemsInSection : section);
        self.upcPageControl?.numberOfPages = nRealCount;
        if (self.bMode)
        {
            return nRealCount * RECYCLE_ITEMBIT;
        }
        else {
            return nRealCount;
        }
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        return self.adapter!.collectionView(collectionView,cellForItemAtIndexPath : indexPath);
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return self.frame.size;
    }
    
    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath)
    {
        if (nTargetItem == -2)  //初始化
        {
            if (self.bMode)
            {
                 SetCurrentItem(nRealCount * RECYCLE_ITEMBIT/2, bScroll: false);
            }
            nTargetItem = -1;
        }
        else if (nTargetItem != -1) {
            SetCurrentItem(nTargetItem, bScroll: false);
            nTargetItem = -1;
        }
    }
    
    
    public func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if (bMode)
        {
            for i in max(0,GetCurrentItem()) ..< min(nRealCount * RECYCLE_ITEMBIT, GetCurrentItem() + 2)
            {
                let fScale:Float = Float(self.contentOffset.x/self.frame.width);
                mListener2?(nCurrentPos: i,vView: self.cellForItemAtIndexPath(NSIndexPath.init(forItem: i, inSection: 0))?.contentView,fScale: fScale - Float(i));
            }
        }
        else {
            for i in max(0,GetCurrentItem()) ..< min(nRealCount, GetCurrentItem() + 2)
            {
                let fScale:Float = Float(self.contentOffset.x/self.frame.width);
                mListener2?(nCurrentPos: i,vView: self.cellForItemAtIndexPath(NSIndexPath.init(forItem: i, inSection: 0))?.contentView,fScale: fScale - Float(i));
            }
        }
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        mOnItemListener?(adapter: self.adapter!, vView: self.cellForItemAtIndexPath(NSIndexPath.init(forItem: indexPath.item, inSection: 0))?.contentView, nPosition: indexPath.item)
    }
    
    public func scrollViewWillBeginDecelerating(scrollView: UIScrollView){
        nEndIndex = self.GetCurrentItem();
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        ntTimer?.invalidate()
    }

    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if (bAutoScroll)
        {
            ntTimer = NSTimer.scheduledTimerWithTimeInterval(JKConvert.toDouble(nInterVal)/1000.0, target: self, selector:#selector(JKViewPager.NextPage as (JKViewPager) -> () -> ()), userInfo: nil, repeats: true);
        }

    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        var nDirection = 0;
        let bSucess = self.GetCurrentItem() != nStartIndex;
        if (bSucess)
        {
            nDirection = (self.GetCurrentItem() - nStartIndex) > 0 ? 1 : -1;
        }
        else {
            nDirection = (nEndIndex - self.GetCurrentItem()) == 0 ? 1 : -1;
        }
        mListener?(nCurrentPos: self.GetCurrentItem(),nDirection: nDirection,bSuccess: bSucess);
        self.upcPageControl?.currentPage = self.GetCurrentItem() % nRealCount;
        nStartIndex = self.GetCurrentItem();
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView)
    {
        var nDirection = 0;
        let bSucess = self.GetCurrentItem() != nStartIndex;
        if (bSucess)
        {
            nDirection = (self.GetCurrentItem() - nStartIndex) > 0 ? 1 : -1;
        }
        else {
            nDirection = (nEndIndex - self.GetCurrentItem()) == 0 ? 1 : -1;
        }
        mListener?(nCurrentPos: self.GetCurrentItem(),nDirection: nDirection,bSuccess: bSucess);
        self.upcPageControl?.currentPage = self.GetCurrentItem() % nRealCount;
        nStartIndex = self.GetCurrentItem();
    }
 
    /**
     设置滑动事件
     
     - parameter OnChanged: 滑动后改变回调
     */
    public func SetOnChangeListener(tmp1:OnChanged,tmp2:OnScroll)
    {
        self.mListener = tmp1;
        self.mListener2 = tmp2;
        self.delegate = self;
        self.dataSource = self;
    }
    
    class JKPageHolder : UICollectionViewCell {
        
    }
}
