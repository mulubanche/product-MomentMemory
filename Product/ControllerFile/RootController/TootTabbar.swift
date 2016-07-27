//
//  TootTabbar.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

typealias releaseClick = () -> Void

class TootTabbar: UITabBar {

    var tabbarButton:UIButton!
    var myRelease:releaseClick?
    
    func initWithRelease(sender: releaseClick){
        myRelease = sender
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let button = UIButton()
        button.setImage(UIImage(named: "tabbar_release"), forState: .Normal)
        button.adjustsImageWhenHighlighted = false
        var temp = button.frame
        temp.size = button.currentImage!.size
        button.frame = CGRectMake(0, 0, 54, 54)
        button.addTarget(self, action: #selector(TootTabbar.buttonClick), forControlEvents: .TouchUpInside)
        self.addSubview(button)
        tabbarButton = button
    }
    
    func buttonClick(){
        if myRelease != nil{
            myRelease!()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var temp = self.tabbarButton.center
        temp.x = self.frame.size.width/2
        temp.y = self.frame.size.height/2-10
        self.tabbarButton.center = temp
        
        let tabbarW = self.frame.size.width/3
        var index:CGFloat = 0
        for (_, value) in self.subviews.enumerate(){
            let cls = NSClassFromString("UITabBarButton")
            if value.isKindOfClass(cls!){
                var temps = value.frame
                temps.size.width = tabbarW
                temps.origin.x = index*tabbarW
                value.frame = temps
                index += 1
                if index == 1{
                    index += 1
                }
            }
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
