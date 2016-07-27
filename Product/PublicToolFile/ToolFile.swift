//
//  ToolFile.swift
//  LcwangTravel
//
//  Created by 研发部ios专用 on 16/4/5.
//  Copyright © 2016年 lcwang. All rights reserved.
//

import Foundation
import UIKit


let kUserD = NSUserDefaults.standardUserDefaults
let kWindow:UIWindow =  UIApplication.sharedApplication().keyWindow!
let KShowLabel:MyShowLabel = MyShowLabel.sharedInstance

let KScreenWidth:CGFloat = UIScreen.mainScreen().bounds.width
let KScreenHeight:CGFloat = UIScreen.mainScreen().bounds.height
let MyColorGreen:UIColor = RGBA(44, g: 233, b: 104, a: 1)
let MyColorBlue:UIColor = RGBA(0, g: 171, b: 236, a: 1)
let MyColorBlack:UIColor = RGBA(54, g: 54, b: 54, a: 1)
let MyColorOrange:UIColor = RGBA(255,g: 131,b: 31,a: 1)
let MyColorGray:UIColor = RGBA(131,g: 131,b: 131,a: 1)
let MyColorWhite:UIColor = RGBA(253,g: 253,b: 253,a: 1)
let MyBackColor:UIColor = RGBA(240, g: 240, b: 240, a: 1)
let MyLabelColor:UIColor = RGBA(255, g: 158, b: 0, a:1)
let MyImgColor:UIColor = RGBA(117, g: 117, b: 117, a:1)
let MyPriceColor:UIColor = RGBA(255, g: 73, b: 41, a:1)
let MyThemeColor:UIColor = RGBA(246, g: 159, b: 91, a: 1)

//字体更换
func fontSize(size: CGFloat) -> UIFont{
    if KScreenWidth<=375{
        return UIFont.systemFontOfSize(size)
    }
    return UIFont.systemFontOfSize(size+2)
}
func fontBoldSize(size: CGFloat) -> UIFont{
    if KScreenWidth<=375{
        return UIFont.boldSystemFontOfSize(size)
    }
    return UIFont.boldSystemFontOfSize(size+2)
}

//自定义颜色
func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor
{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func CreateLabel(frame: CGRect, text: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
    let label = UILabel(frame: frame)
    label.text = text
    label.font = font
    label.textColor = textColor
    label.textAlignment = textAlignment
    return label
}

//改变图片颜色
func updateImageColor(image:UIImage, color:UIColor) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
    let ref = UIGraphicsGetCurrentContext()
    CGContextTranslateCTM(ref, 0, image.size.height)
    CGContextScaleCTM(ref, 1.0, -1.0);
    CGContextSetBlendMode(ref, .Normal);
    let rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(ref, rect, image.CGImage);
    color.setFill()
    CGContextFillRect(ref, rect);
    let newimg = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newimg
}

func createWithButtonFrame(frame:CGRect, title:String,imageName:String,font:UIFont,color:UIColor) -> UIButton{
    
    let btn = UIButton(frame: frame)
    btn.titleLabel?.font = font
    btn.setBackgroundImage(UIImage(named: imageName), forState: .Normal)
    btn.setTitle(title, forState: .Normal)
    btn.setTitleColor(color, forState: .Normal)
    btn.layer.cornerRadius = 5
    
    return btn
}

func isNullStr(obj: AnyObject) -> String{
    var str = obj
    if str.isKindOfClass(NSNull.classForCoder()) == true{
        str = ""
    }
    return str as! String
}
func isNullNumber(obj: AnyObject) -> Int{
    var str = obj
    if str.isKindOfClass(NSNull.classForCoder()) == true{
        str = 0
    }
    return str as! Int
}


//通知代理名称
let openLeftMeun:String = "LeftMeunOpen"        //打开菜单
let closeLeftMeun:String = "LeftMeunClose"      //关闭菜单
let skipController:String = "skipControllerKey" //菜单跳转
let username:String = "username"
let userkey:String = "userkey"
let colselogin:String = "colselogin"
let outages:String = "NetworkOutages"           //断网通知









//API



















