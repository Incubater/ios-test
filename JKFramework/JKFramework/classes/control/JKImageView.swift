//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation

@IBDesignable
public  class JKImageView : UIImageView {
    
    /// 加载中时的图片
    private var uiLoadingImage:UIImage?
    /// 图片配置
    private var sdwioOptions:SDWebImageOptions = SDWebImageOptions();
    /// 加载完成监听
    private var mListener: FinishLoad?;
    /// 加载进度监听
    private var mListener2: LoadingProgress?;
    /// 图片加载完成时回调
    public typealias FinishLoad = (bSuccess:Bool) -> Void
    /// 图片加载进度[0~100]
    public typealias LoadingProgress = (nPercent:Int) -> Void
    /**目标图片宽度*/
    private var nTargetWidth = 0;
    /**目标图片高度*/
    private var nTargetHeight = 0;
  
    
    public override func awakeFromNib(){
        super.awakeFromNib();
        sdwioOptions = SDWebImageOptions(rawValue: SDWebImageOptions.RetryFailed.rawValue + SDWebImageOptions.LowPriority.rawValue);
    }
    
    /**
     图片加载监听
     
     - parameter mListener:  加载完成监听
     - parameter mListener2: 加载进度监听
     */
    public func SetUpdateListener(mListener:FinishLoad,mListener2:LoadingProgress)
    {
        self.mListener = mListener;
        self.mListener2 = mListener2;
    }
    
    /**
     加载url图片
     
     - parameter tUrl: url地址
     */
    public func SetImageHttp(tUrl:String)
    {
        sd_setImageWithURL(NSURL(string: tUrl),placeholderImage: uiLoadingImage,options: sdwioOptions,progress: { (n1, n2) in
            if (n2 > 0)
            {
                self.mListener2?(nPercent: n1*100/n2);
            }
            }, completed: { (uiImage, error, cacheType, url) in
                if (error == nil)
                {
                    if (uiImage != nil)
                    {
                        self.nTargetWidth = Int(uiImage.size.width);
                        self.nTargetHeight = Int(uiImage.size.height);

                    }
                    self.mListener?(bSuccess: true);
                    if (cacheType != SDImageCacheType.None)
                    {
                         self.mListener2?(nPercent: 100);
                    }
                }
                else {
                    self.nTargetWidth = 0;
                    self.nTargetHeight = 0;
                    self.mListener?(bSuccess: false);
                }
        });

    }
    
    /**
     加载资源图片
     
     - parameter tName: 图片名字
     */
    public func SetImageResource(tName:String)
    {
        image = UIImage(named: tName);
        self.mListener?(bSuccess: image != nil);
        if (image != nil)
        {
            self.mListener2?(nPercent: 100);
        }
    }
    
    /**
     * 获取目标宽度
     */
    public func GetTargetWidth()->Int
    {
        return nTargetWidth;
    }
    
    /**
     * 获取目标高度
     */
    public func GetTargetHeight()->Int
    {
        return nTargetHeight;
    }

    /**
     设置加载图片配置
     
     - parameter uiLoadingImage: 加载默认图
     */
    public func SetLoadingImage(uiLoadingImage:UIImage?)
    {
        self.uiLoadingImage = uiLoadingImage;
    }
}
