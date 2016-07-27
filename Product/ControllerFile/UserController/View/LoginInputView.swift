//
//  LoginInputView.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/23.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class LoginInputView: UIView {

    var textfiled:UITextField!
    
    init(frame: CGRect, placeStr: String) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = 22
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1.0
        
        textfiled = UITextField(frame: CGRect(x: 22, y: 8, width: frame.width-34, height: 30))
        textfiled.backgroundColor = UIColor.clearColor()
        textfiled.clearButtonMode = .Always
        textfiled.placeholder = placeStr
        textfiled.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor")
        textfiled.textColor = UIColor.whiteColor()
        self.addSubview(textfiled)
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
