//
//  RootNavigationView.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/21.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

typealias navigationLeftClick = () -> Void
typealias navigationRightClick = () -> Void

class RootNavigationView: UIView {

    private var leftView:RootImageView?
    private var rightView:RootImageView?
    private var titleLabel:UILabel?
    private var myLeft:navigationLeftClick?
    private var myRight:navigationRightClick?
    private var backView:UIView!
    private var line:UIView!
    
    func initWithLeft(sender: navigationLeftClick){
        myLeft = sender
    }
    
    func initWithRight(sender: navigationRightClick){
        myRight = sender
    }
    
    internal init(frame: CGRect, leftImg: String, leftSelImg: String, title: String, rightImg: String, rightSelImg: String) {
        super.init(frame: frame)
        
        backView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 64))
        backView.backgroundColor = RGBA(247, g: 247, b: 247, a: 1)
        backView.alpha = 0.0
        self.addSubview(backView)
        
        line = UIView(frame: CGRect(x: 0, y: 63, width: KScreenWidth, height: 1))
        line.backgroundColor = MyColorGray
        line.hidden = true
        self.addSubview(line)
        
        if leftImg != ""{
            leftView = RootImageView(frame: CGRect(x: 10, y: 30, width: 24, height: 24))
            leftView!.selectedImage(leftImg, ret: false)
            leftView!.selectedImage(leftSelImg, ret: true)
            leftView!.selected(false)
            
            self.addSubview(leftView!)
            leftView!.addTarget(self, action: #selector(RootNavigationView.leftClick))
        }
        
        if rightImg != ""{
            rightView = RootImageView(frame: CGRect(x: KScreenWidth-42, y: 26, width: 32, height: 32))
            rightView!.selectedImage(rightImg, ret: false)
            rightView!.selectedImage(rightSelImg, ret: true)
            rightView!.selected(false)
            self.addSubview(rightView!)
            rightView!.addTarget(self, action: #selector(RootNavigationView.rightClick))
        }
        
        if title != ""{
            titleLabel = UILabel(frame: CGRect(x: 50, y: 31, width: KScreenWidth-100, height: 20))
            titleLabel!.font = fontBoldSize(16)
            titleLabel!.textColor = UIColor.whiteColor()
            titleLabel!.textAlignment = .Center
            titleLabel!.text = title
            self.addSubview(titleLabel!)
        }
    }
    
    func leftClick(){
        if myLeft != nil{
            myLeft!()
        }
    }
    
    func rightClick(){
        if myRight != nil{
            myRight!()
        }
    }
    
    func updateBackViewState(set: Bool){
        if set{
            leftView?.selected(set)
            rightView?.selected(set)
            titleLabel?.textColor = MyThemeColor
            UIView.animateWithDuration(0.3, animations: {
                self.backView.alpha = 1.0
                self.line.hidden = false
            })
        }else{
            leftView?.selected(set)
            rightView?.selected(set)
            titleLabel?.textColor = UIColor.whiteColor()
            UIView.animateWithDuration(0.3, animations: {
                self.backView.alpha = 0.0
                self.line.hidden = true
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
