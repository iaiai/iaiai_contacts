//
//  ColorUtil.swift
//  xapp
//
//  Created by iaiai on 2017/12/5.
//  Copyright © 2017年 xapp. All rights reserved.
//

import UIKit

class ColorUtil: NSObject {
    
    /**
     * 颜色转换 IOS中十六进制的颜色转换为UIColor
     * @param color 十六进制颜色如(#ffffff)
     * @return UIColor 返回ios中可用的颜色类
     **/
    static func colorWithHexString(color:String)->UIColor{
        return colorWithHexString(color:color,alpha:1)
    }
    
    /**
     * 颜色转换 IOS中十六进制的颜色转换为UIColor
     * @param color 十六进制颜色如(#ffffff)
     * @return UIColor 返回ios中可用的颜色类
     **/
    static func colorWithHexString(color:String,alpha:CGFloat = 1)->UIColor{
        // 去除空格等
        var cString: String = color.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 去除#
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        // 必须为6位
        if (cString.count != 6) {
            return UIColor.gray
        }
        // 红色的色值
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        // 字符串转换
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    /**
     * 把颜色转成UIImage
     **/
    static func colorToImage(color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /**
     * 随机色
     **/
    static func randomColor()->UIColor{
        return randomColor(alpha:1)
    }
    
    /**
     * 随机色
     **/
    static func randomColor(alpha:CGFloat = 1)->UIColor{
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}
