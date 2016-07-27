//
//  FriendsViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/7/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class FriendsViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableview:UITableView!
    var dataArr:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "我的好友"
        
        /*
         EMError *error = nil;
         NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
         if (!error) {
         NSLog(@"获取成功 -- %@",buddyList);
         }
         */
        
        tableview = UITableView(frame: CGRect(x: 0, y: 64, width: KScreenWidth, height: KScreenHeight))
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 40
        tableview.separatorStyle = .None
        self.view.addSubview(tableview)
        
        dataArr = EMClient.sharedClient().contactManager.getContactsFromServerWithError(nil)
        if dataArr.count > 0{
            for (_,value) in dataArr.enumerate(){
                print(value)
            }
            tableview.reloadData()
        }
        
    }
    
    override func backClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArr == nil{
            return 0
        }
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let str = "cellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(str)
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: str)
            cell!.backgroundColor = UIColor.clearColor()
        }
        cell!.textLabel!.text = isNullStr(dataArr[indexPath.row])
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let svc = MessageViewController()
        svc.title = isNullStr(dataArr[indexPath.row])
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
