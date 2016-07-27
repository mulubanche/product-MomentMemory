//
//  MyShowLabel.swift
//  LcwangTravel
//
//  Created by 旅程网 on 16/4/20.
//  Copyright © 2016年 lcwang. All rights reserved.
//

import UIKit


class MyShowLabel: UILabel {
    
    var timer = NSTimer()
    
    static var sharedInstance : MyShowLabel {
        struct Static {
            static let instance : MyShowLabel = MyShowLabel()
        }
        return Static.instance
    }

    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.textAlignment = NSTextAlignment.Center
        self.textColor = UIColor.whiteColor()
        self.backgroundColor = MyColorBlack
        self.font = UIFont.systemFontOfSize(16)
        
    }
    
    func setText(text:NSString,positions position:Int){
    
        super.text = text as String
        
        kWindow.addSubview(self)
        
        self.frame = CGRectMake(0, 0, self.getStringWidthWithString(text), (25/560)*KScreenHeight)
        
        if position == 1{
        
            self.center = CGPointMake(KScreenWidth/2, KScreenHeight/2)
        }else if position == -1{
        
            self.center = CGPointMake(KScreenWidth/2, KScreenHeight-100)
        }else{
        
            self.center = CGPointMake(KScreenWidth/2, KScreenHeight-70)
        }
        
        self.timer.invalidate()
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MyShowLabel.removeSelf(_:)), userInfo: nil, repeats: false)
        
        
    }
    
    func removeSelf(timer:NSTimer){
    
        self.removeFromSuperview()
    }
    
    
    func getStringWidthWithString(string:NSString) -> CGFloat {
        
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(16)]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
    
        let rect:CGRect = string.boundingRectWithSize(CGSizeMake(20, 222222), options: option, attributes: attributes, context: nil)
        return rect.size.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


