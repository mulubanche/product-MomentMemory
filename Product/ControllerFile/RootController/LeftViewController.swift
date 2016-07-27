//
//  LeftViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/22.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class LeftViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {

    var tableview:UITableView!
    var dataArr: NSArray!
    
    let selfWidth = 200.0/320.0*KScreenWidth
    let topHeight = 220.0/375.0*KScreenWidth
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataArr = [["icon":"user_icon5", "title":"我的资料"], ["icon":"user_icon5", "title":"我的消息"], ["icon":"user_icon5", "title":"我的收藏"], ["icon":"user_icon5", "title":"手札"], ["icon":"user_icon5", "title":"退出"]]
        
                
        let img = UIImageView.newAutoLayoutView()
        img.image = UIImage(named: "meunbackimage.jpg")
        img.contentMode = .ScaleAspectFill
        self.view.addSubview(img)
        img.autoSetDimensionsToSize(CGSizeMake(10, 20))
        img.autoPinEdgeToSuperviewEdge(.Top, withInset: 0)
        img.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        img.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        img.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
        
        
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: selfWidth, height: KScreenHeight), style: .Plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.bounces = false
        tableview.separatorStyle = .None
        tableview.backgroundColor = UIColor.clearColor()
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.rowHeight = 40
        self.view.addSubview(tableview)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return topHeight
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: selfWidth, height: topHeight))
        view.backgroundColor = UIColor.clearColor()
        
        let userIcon = UIImageView(frame: CGRect(x: (selfWidth-72)/2, y: 70, width: 72, height: 72))
        userIcon.image = UIImage(named: "user_icon1")
        userIcon.layer.cornerRadius = 30
        view.addSubview(userIcon)
        
        let username = UILabel(frame: CGRect(x: 10, y: CGRectGetMaxY(userIcon.frame)+10, width: selfWidth-20, height: 20))
        username.font = fontBoldSize(14)
        username.textColor = UIColor.whiteColor()
        username.textAlignment = .Center
        username.text = "陌路班车"
        view.addSubview(username)
        return view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let str = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(str) as? LeftMeunTableViewCell
        if cell == nil{
            cell = LeftMeunTableViewCell(style: .Default, reuseIdentifier: str)
            cell!.selectionStyle = .None
            cell!.backgroundColor = UIColor.clearColor()
        }
        cell?.transmitData(dataArr[indexPath.row] as! NSDictionary)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(closeLeftMeun, object: self)
        //skipController
        NSNotificationCenter.defaultCenter().postNotificationName(skipController, object: self, userInfo: ["controllerKey":indexPath.row])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
