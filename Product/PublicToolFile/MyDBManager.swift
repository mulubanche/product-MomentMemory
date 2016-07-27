//
//  MyDBManager.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/7/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit
import Foundation
import FMDB

class MyDBManager: NSObject {

    var myDataBase:FMDatabase?
    
    override init() {
        super.init()
        openDatabase()
    }
    
    func openDatabase(){
        let path = NSHomeDirectory().stringByAppendingString("/Documents/jcd.sqlite")
        myDataBase = FMDatabase(path: path)
        if myDataBase!.open() == false{
            print("数据库打开失败")
        }else{
            let userreview = "create table if not exists userreview (kid integer primary key autoincrement, user_name varchar(255), user_icon varchar(255), to_name varchar(255), to_icon varchar(255), review_info text, review_time varchar(255), review_number varchar(255))"
            if myDataBase!.executeUpdate(userreview, withArgumentsInArray: nil) == false{
                print("userreview创建失败")
            }else{
                print("userreview创建成功")
            }
        }
    }
    
//    func insertWithReview(dict: Dictionary<String, String>) -> Bool{
    func insertWithReview(model: ReviewModel) -> Bool{
        let sql = "INSERT INTO userreview(user_name, user_icon, to_name, to_icon, review_info, review_time, review_number) VALUES(?,?,?,?,?,?,?)"
        if myDataBase!.executeUpdate(sql, withArgumentsInArray: [model.user_name!, model.user_icon!, model.to_name!, model.to_icon!, model.review_info!, model.review_time!, model.review_number!]) == false{
            return false
        }
        return true
    }
    
    func selectedWithReview(name: String, to_name: String) -> Array<ReviewModel>{

        let sql = "SELECT * FROM userreview WHERE user_name='"+name+"' AND to_name='"+to_name+"'"
        var ret:AnyObject?
        var data:Array<ReviewModel> = []
        do {
            try ret = myDataBase!.executeQuery(sql, values: nil)
            if ret == nil{
                return data 
            }
            while ret!.next() {
                let model = ReviewModel()
                model.user_name      =   ret!.stringForColumn("user_name")
                model.user_icon      =   ret!.stringForColumn("user_icon")
                model.to_name        =   ret!.stringForColumn("to_name")
                model.to_icon        =   ret!.stringForColumn("to_icon")
                model.review_info    =   ret!.stringForColumn("review_info")
                model.review_number  =   ret!.stringForColumn("review_number")
                model.review_time    =   ret!.stringForColumn("review_time")
                data.append(model)
            }
        }catch{
            return data
        }
        return data
    }
    
}
