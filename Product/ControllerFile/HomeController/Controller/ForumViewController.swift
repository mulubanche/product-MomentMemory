//
//  ForumViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/21.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class ForumViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {

    var tableview:UITableView!
    var topImageView:RootImageView!
    var navigationRet:Bool = true
    var navigationView:RootNavigationView!  //自定义导航栏位置
    var dataArr:NSMutableArray?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        
        if navigationRet{
            UIApplication.sharedApplication().statusBarStyle = .LightContent
        }else{
            UIApplication.sharedApplication().statusBarStyle = .Default
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createUIView()
    }
    
    func createUIView(){
        
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight-49), style: .Plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.clearColor()
        self.view.addSubview(tableview)
        tableview.estimatedRowHeight = 180
        tableview.separatorStyle = .None
        tableview.rowHeight = UITableViewAutomaticDimension     //自动行高
//        tableview.layer.masksToBounds
        //设置头部图片
        let imageView = RootImageView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 180/320*KScreenWidth))
        imageView.image = UIImage(named: "home_top_img.jpg")
        imageView.contentMode = .ScaleAspectFill
        topImageView = imageView
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 180/320*KScreenWidth))
        view.backgroundColor = UIColor.clearColor()
        view.clipsToBounds = true
        
        tableview.tableHeaderView = view
        
        let allView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight-49))
        allView.addSubview(imageView)
        
        tableview.backgroundView = allView
        
        navigationView = RootNavigationView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 64), leftImg: "left_menu_w", leftSelImg: "left_menu_r", title: "看看动态", rightImg: "", rightSelImg: "")
        self.view.addSubview(navigationView)
        navigationView.initWithLeft {
            
            let userState = kUserD().objectForKey(username)
            
            if userState == nil{
                let svc = LoginViewController()
                self.presentViewController(svc, animated: true, completion: nil)
                return
            }
            
            if isNullStr(userState!) == ""{
                let svc = LoginViewController()
                self.presentViewController(svc, animated: true, completion: nil)
                return
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName(openLeftMeun, object: self)
        }
        navigationView.initWithRight {
            print("右边按钮事件")
        }
        
        loadingData()
    }
    
    func loadingData(){
        let path: String = NSBundle.mainBundle().pathForResource("homejsonfile", ofType: "json")!
        let nsUrl = NSURL(fileURLWithPath: path)
        let nsData: NSData = NSData(contentsOfURL: nsUrl)!
        //读取Json数据
        var jsonData:AnyObject?
        do {
            try jsonData = NSJSONSerialization.JSONObjectWithData(nsData, options: .AllowFragments)
        }catch{
            print("窝草")
        }
        if jsonData != nil{
//            print(jsonData)
            
            let dictArr = (jsonData as! NSDictionary).objectForKey("data") as! NSArray
            if dataArr == nil{
                dataArr = NSMutableArray()
            }
            for (_, value) in dictArr.enumerate(){
                dataArr!.addObject(value)
            }
        }
        
        
        
        //读取普通数据
        
        
        //读取数组类型数据
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArr == nil{
            return 0
        }
        return dataArr!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let str = "cellID\(indexPath.row)"
        var cell = tableview.dequeueReusableCellWithIdentifier(str) as? HomeTableViewCell
        if cell == nil{
            cell = HomeTableViewCell(style: .Default, reuseIdentifier: str)
            cell?.backgroundColor = UIColor.clearColor()
        }
        cell!.transmitData(dataArr![indexPath.row] as! NSDictionary, tag: indexPath.row)
        cell!.messageView.initWithOpenList { (logo) in

            let rectInTableView = tableView.rectForRowAtIndexPath(indexPath)
            let rectInSuperview = tableView.convertRect(rectInTableView, toView: tableView.superview)
            
            PellTableViewSelect.addPellTableViewSelectWithWindowFrame(CGRectMake(KScreenWidth-100, rectInSuperview.origin.y-18, 150, 200), selectData: ["分享","收藏","举报"], images: ["saoyisao.png","jiahaoyou.png","diannao.png"], action: { (index) in
                print("选中的是第\(index)个")
                }, animated: true)
        }
        cell!.initWithShowImageView { (dict) in
            let win = UIApplication.sharedApplication().windows.first
            let img = ShowImageView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight))
            win!.addSubview(img)
            
            img.transmitShowImg(dict)
        }
        cell!.initWithCommentType { 
            let view = WindowsView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight))
            self.view.addSubview(view)
        }
        tableView.rowHeight = cell!.returnCellHeight()
        return cell!
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var rect = self.topImageView.frame
        if scrollView.contentOffset.y > 0{
            rect.origin.y = -scrollView.contentOffset.y
            topImageView.frame = rect
        }else{
            rect.origin.y = 0
            rect.size.height = 200 - scrollView.contentOffset.y
            topImageView.frame = rect
        }
        
        if scrollView.contentOffset.y > 180/320*KScreenWidth-64{
            navigationView.updateBackViewState(true)
            UIApplication.sharedApplication().statusBarStyle = .Default
            navigationRet = false
        }else{
            navigationView.updateBackViewState(false)
            UIApplication.sharedApplication().statusBarStyle = .LightContent
            navigationRet = true
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func createData(){
        
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
