//
//  MyView.swift
//  LcwangTravel
//
//  Created by 班车陌路 on 16/4/10.
//  Copyright © 2016年 lcwang. All rights reserved.
//

import UIKit

class MyView: UIView {

    var _target:AnyObject?
    
    var _action:Selector?
    
    func addTarget(target:AnyObject, action:Selector)
    {
        _target = target
        
        _action = action
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if _target != nil
        {
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
