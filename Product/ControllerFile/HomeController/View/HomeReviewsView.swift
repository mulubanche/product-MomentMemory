//
//  HomeReviewsView.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/7/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

typealias cancelView = () -> Void

class HomeReviewsView: UIView {

    var myCancel:cancelView?
    
    func initWithCancel(sender: cancelView){
        myCancel = sender
    }
    
    @IBOutlet var textinfo: UITextView!
    
    @IBAction func CancelClick(sender: UIButton) {
        if myCancel != nil{
            myCancel!()
        }
    }
    
    @IBAction func SubmitClick(sender: UIButton) {
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
