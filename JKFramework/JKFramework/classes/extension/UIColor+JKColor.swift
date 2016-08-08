//
//  ChineseTraditionalColors.swift
//  ChineseTraditionalColors
//
//  Created by Zhixuan Lai on 11/2/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import Foundation

extension UIColor {
    
    public convenience init(tHex:String){
        tHex.md5()
        
        var tColor = tHex;
        if (tHex.hasPrefix("#")) {
            tColor = tHex.substringFromIndex(tHex.startIndex.advancedBy(1))
        }
        
        if (tColor.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 8)   //ARGB
        {
            let tAlpha = tColor.substringWithRange(tColor.startIndex ..< tColor.startIndex.advancedBy(2))
            let nAlpha = Int(tAlpha,radix: 16);
            let tRed = tColor.substringWithRange(tColor.startIndex.advancedBy(2) ..< tColor.startIndex.advancedBy(4))
            let nRed = Int(tRed,radix: 16);
            let tGreen = tColor.substringWithRange(tColor.startIndex.advancedBy(4) ..< tColor.startIndex.advancedBy(6))
            let nGreen = Int(tGreen,radix: 16);
            let tBlue = tColor.substringWithRange(tColor.startIndex.advancedBy(6) ..< tColor.startIndex.advancedBy(8))
            let nBlue = Int(tBlue,radix: 16);
            
            self.init(colorLiteralRed: JKConvert.toFloat(nRed!)/255.0, green: JKConvert.toFloat(nGreen!)/255.0, blue: JKConvert.toFloat(nBlue!)/255.0, alpha: JKConvert.toFloat(nAlpha!)/255.0);
        }
        else {  //RGB
            let tRed = tColor.substringWithRange(tColor.startIndex ..< tColor.startIndex.advancedBy(2))
            let nRed = Int(tRed,radix: 16);
            let tGreen = tColor.substringWithRange(tColor.startIndex.advancedBy(2) ..< tColor.startIndex.advancedBy(4))
            let nGreen = Int(tGreen,radix: 16);
            let tBlue = tColor.substringWithRange(tColor.startIndex.advancedBy(4) ..< tColor.startIndex.advancedBy(6))
            let nBlue = Int(tBlue,radix: 16);
            self.init(colorLiteralRed: JKConvert.toFloat(nRed!)/255.0, green: JKConvert.toFloat(nGreen!)/255.0, blue: JKConvert.toFloat(nBlue!)/255.0, alpha: 1);
        }
    }
    
    
    public convenience init(nRed:Int,nGreen:Int,nBlue:Int){
        self.init(colorLiteralRed: JKConvert.toFloat(nRed)/255.0, green: JKConvert.toFloat(nGreen)/255.0, blue: JKConvert.toFloat(nBlue)/255.0, alpha: 1);
    }
    
}