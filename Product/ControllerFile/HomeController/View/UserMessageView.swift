//
//  UserMessageView.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

typealias openListSetView = (logo: Int) -> Void

class UserMessageView: UIView {

    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    var OnlyLogo:Int!
    
    var myOpenList:openListSetView?
    
    func initWithOpenList(sender: openListSetView){
        myOpenList = sender
    }
    
    @IBAction func shareClick(sender: UIButton) {
        
        if myOpenList != nil{
            myOpenList!(logo: OnlyLogo)
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
