//
//  MessageViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/7/1.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class MessageViewController: RootViewController, UITableViewDelegate, UITableViewDataSource, EMChatManagerDelegate {

    var sendmessageview:SendMessageView!
    var tableview:UITableView!
    var data = []
    var ret = true
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        EMClient.sharedClient().chatManager.addDelegate(self, delegateQueue: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        EMClient.sharedClient().chatManager.removeDelegate(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        tableview = UITableView(frame: CGRect(x: 0, y: 64, width: KScreenWidth, height: KScreenHeight-64-50), style: .Plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .None
        tableview.bounces = false
//        tableview.contentOffset = CGPointMake(CGFloat(MAXFLOAT), CGFloat(MAXFLOAT))
        self.tableview.setContentOffset(CGPointMake(CGFloat(MAXFLOAT), CGFloat(MAXFLOAT)), animated: false)
        tableview.backgroundColor = UIColor.clearColor()
        self.view.addSubview(tableview)
        
        sendmessageview = SendMessageView(frame: CGRect(x: 0, y: CGRectGetMaxY(tableview.frame)+10, width: KScreenWidth, height: 40))
        var number = 0
        sendmessageview.initWithRetuenText { (text) in
            
            //删除首尾换行符
            let str = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            let time = "\(NSDate())"
            
            let model = ReviewModel()
            model.user_name = "1"
            model.to_name = "2"
            model.user_icon = "user_icon4"
            model.to_icon = "user_icon1"
            model.review_number = "\(number%2)"
            model.review_info = str
            model.review_time = time
            
            MyDBManager().insertWithReview(model)
            
            number += 1
//            self.tableview.setContentOffset(CGPointMake(CGFloat(MAXFLOAT), CGFloat(MAXFLOAT)), animated: false)
            self.tableview.contentOffset = CGPointMake(CGFloat(MAXFLOAT), CGFloat(MAXFLOAT))
            self.parsingData()
            
            
            //构造消息
            dispatch_async(dispatch_get_main_queue(), {
                let body = EMTextMessageBody(text: str)
                let from = EMClient.sharedClient().currentUsername
                let message = EMMessage(conversationID: isNullStr(kUserD().objectForKey(username)!), from: from, to: self.title, body: body, ext: ["time" : time])
                message.chatType = EMChatTypeChat
                
                //发送消息
                EMClient.sharedClient().chatManager.asyncSendMessage(message, progress: nil, completion: { (message, error) in
                    print(message)
                    print(error.errorDescription)
                    print(error.description)
                    print(error.debugDescription)
                })
                
            })
            
            
        }
        self.view.addSubview(sendmessageview)
        
        parsingData()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MessageViewController.keyboardWasShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MessageViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func parsingData(){
        let db = MyDBManager().selectedWithReview("1", to_name: "2")
        data = db
        tableview.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let str = "cell\(indexPath.row)"
        var cell = tableview.dequeueReusableCellWithIdentifier(str) as? MessageViewTableViewCell
        if cell == nil{
            cell = MessageViewTableViewCell(style: .Default, reuseIdentifier: str)
            cell!.selectionStyle = .None
            cell!.backgroundColor = UIColor.clearColor()
        }
        cell!.transmit(data[indexPath.row] as! ReviewModel)
        tableView.rowHeight = cell!.returncellheight()
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sendmessageview.textview.resignFirstResponder()
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        sendmessageview.textview.resignFirstResponder()
    }

    
    //接收消息
    //在线消息
    func didReceiveMessages(aMessages: [AnyObject]!) {
        
        for (_, value) in aMessages.enumerate(){
            let msgBody:EMMessageBody = value.body
            switch msgBody.type {
            case EMMessageBodyTypeText:
                let textBody = msgBody as! EMTextMessageBody
                let txt = textBody.text
                
                let time = "\(NSDate())"
                
                let model = ReviewModel()
                model.user_name = "1"
                model.to_name = "2"
                model.user_icon = "user_icon4"
                model.to_icon = "user_icon1"
                model.review_number = "1"
                model.review_info = txt
                model.review_time = time
                
                MyDBManager().insertWithReview(model)
                
                self.tableview.contentOffset = CGPointMake(CGFloat(MAXFLOAT), CGFloat(MAXFLOAT))
                self.parsingData()
                
                break
            case EMMessageBodyTypeImage:
                
                break
            case EMMessageBodyTypeLocation:
                
                break
            case EMMessageBodyTypeVideo://音频
                
                break
            case EMMessageBodyTypeFile:
                
                break
            default:
                break
            }
        }
        
        
    }
    //透传消息
    func didReceiveCmdMessages(aCmdMessages: [AnyObject]!) {
        print(aCmdMessages)
        
        for (_, value) in aCmdMessages.enumerate(){
            let body = value.body as! EMCmdMessageBody
            print(body.action)
        }
    }
    
    
    func keyboardWasShown(sender: NSNotification){
        let keyBoardFrame = sender.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        if keyBoardFrame != nil{
            UIView.animateWithDuration(0.5, animations: { 
                var frame = self.tableview.frame
                frame.origin.y = -(keyBoardFrame?.size.height)!+64
                self.tableview.frame = frame
                frame = self.sendmessageview.frame
                frame.origin.y = KScreenHeight-(keyBoardFrame?.size.height)!-40
                self.sendmessageview.frame = frame
            })
        }
    }
    func keyboardWillBeHidden(sender: NSNotification){
        var frame = self.tableview.frame
        frame.origin.y = 64
        self.tableview.frame = frame
        frame = self.sendmessageview.frame
        frame.origin.y = CGRectGetMaxY(tableview.frame)+10
        self.sendmessageview.frame = frame
        tableview.reloadData()
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
