//
//  ReviewModel.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/7/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class ReviewModel: NSObject {

    //user_name, user_icon, to_name, to_icon, message_info, message_time, review_number
    var user_name:String!
    var user_icon:String!
    var to_name:String!
    var to_icon:String!
    var review_info:String!
    var review_time:String!
    var review_number:String!
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
