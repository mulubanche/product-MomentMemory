//
//  WindowsView.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/7/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit
import RBBAnimation

class WindowsView: UIView {

    var backView:UIView!
    var review:HomeReviewsView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
//        let window = UIApplication.sharedApplication().windows.last! as UIWindow
//        window.addSubview(self)
        
//        backView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight))
//        backView.backgroundColor = RGBA(117, g: 117, b: 117, a: 0.0)
//        self.addSubview(backView)
        
        review = NSBundle.mainBundle().loadNibNamed("HomeReviewView", owner: nil, options: nil).first as! HomeReviewsView
        review.frame = CGRect(x: 15, y: -160/320*KScreenWidth, width: KScreenWidth-30, height: 160/320*KScreenWidth)
        review.initWithCancel { 
            UIView.animateWithDuration(0.3, animations: {
//                self.backView.alpha = 0.0
                self.review.alpha = 0.0
            }) { (ret) in
                self.removeFromSuperview()
            }
        }
        
        self.addSubview(review)
        
//        UIView.animateWithDuration(0.3) { 
//            self.backView.alpha = 0.5
//        }

        let animation = RBBTweenAnimation()
        animation.keyPath = "position.y"
        animation.fromValue = 0
        animation.toValue = KScreenHeight/2
        animation.duration = 1
        animation.easing = RBBEasingFunctionEaseOutBounce
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        review.layer.addAnimation(animation, forKey: nil)
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
