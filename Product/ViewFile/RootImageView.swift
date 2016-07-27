//
//  RootImageView.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/21.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class RootImageView: UIImageView {

    var _target:AnyObject?
    var _action:Selector?
    
    var trueImage:UIImage?
    var falseImage:UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
    }
    
    func addTarget(target:AnyObject, action:Selector){
        _target = target
        _action = action
    }
    
    func selectedImage(image: String, ret: Bool){
        if ret{
            trueImage = UIImage(named: image)
        }else{
            falseImage = UIImage(named: image)
        }
    }
    
    func selected(ret: Bool){
        if ret{
            self.image = trueImage
        }else{
            self.image = falseImage
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if _target != nil{
            _target!.performSelector(_action!, withObject: self)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
