//
//  JKLabel.swift
//  JKFramework
//
//  Created by Cjj on 16/3/3.
//  Copyright © 2016年 Cjj. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

@IBDesignable
public  class JKVideoView : UIView {

    /// 视频播放器
    var avpvcController:AVPlayerViewController?
    /// 视频内容item
    var playerItem:AVPlayerItem?;
    /// 预处理监听
    var mOnPreparedListener: OnPreparedListener?;
    /// 预处理事件
    public typealias OnPreparedListener = (player:AVPlayer) -> Void
    
    
    var player : AVPlayer {
        
        get {
            let layer = self.layer as! AVPlayerLayer
            return layer.player!
        }
        
        set(newPlayer) {
            
            let layer = self.layer as! AVPlayerLayer
            layer.player = newPlayer
        }
    }
    
    override public class func layerClass() -> AnyClass {
        return AVPlayerLayer.self
    }
    
    public override func awakeFromNib()
    {
        super.awakeFromNib();
    }
    
    public func SetVideoURL(urUrl:NSURL)
    {
        self.playerItem = AVPlayerItem.init(URL: urUrl)
        self.playerItem!.addObserver(self, forKeyPath: "status", options: .New, context:nil)
        self.player = AVPlayer.init(playerItem: self.playerItem!)
    }
    
    /**
     设置播放器控制器
     
     - parameter avpvcController: 控制器对象
     */
    public func SetMediaController(avpvcController:AVPlayerViewController)
    {
        self.avpvcController = avpvcController;
        self.avpvcController!.player = self.player
        self.avpvcController!.videoGravity = AVLayerVideoGravityResizeAspect;
        self.avpvcController!.showsPlaybackControls = true
        self.avpvcController!.view.frame = self.frame
        self.addSubview(self.avpvcController!.view)
    }
    
    /**
     设置预处理监听
     - parameter l: 监听事件
     */
    public func SetOnPreparedListener(l:OnPreparedListener)
    {
        self.mOnPreparedListener = l
    }
    
    /**
     视频播放
     */
    public func Start()
    {
        self.player.play()
    }
    
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "status" {
            let playItem:AVPlayerItem = object as! AVPlayerItem
            if playItem.status == AVPlayerItemStatus.ReadyToPlay {
                self.mOnPreparedListener?(player: self.player)
            }
        }
        
    }
}
