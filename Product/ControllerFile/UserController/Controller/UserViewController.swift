//
//  UserViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class UserViewController: RootViewController, TYCircleMenuDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var menu:TYCircleMenu!
    var tableview:UITableView!
    var searchController:UISearchController!
    var dataArr:NSMutableArray!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    func selectMenuAtIndex(index: Int) {
        menu.isDismissWhenSelected = true
        UIView.animateWithDuration(0.1, animations: { 
            self.tableview.contentOffset.y = 0
            }) { (ret) in
                self.loadingData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "精选"
        
        createUIView()

        var items:Array<String> = []
        for i in 0...10{
            items.append("test_\(i)")
        }
        menu = TYCircleMenu(radious: 180, itemOffset: 0, imageArray: items, titleArray: items, menuDelegate: self)
        menu.visibleNum = 3
        self.view.addSubview(menu)
    }
    
    func createUIView(){
        
        let userBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        userBtn.setImage(UIImage(named: "left_menu_r"), forState: .Normal)
        userBtn.adjustsImageWhenHighlighted = false
        userBtn.addTarget(self, action: #selector(UserViewController.openLeftMeunClick), forControlEvents: .TouchUpInside)
        userBtn.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)

        let nagetion = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        nagetion.width = -15
        self.navigationItem.leftBarButtonItems = [nagetion, UIBarButtonItem(customView: userBtn)]
        
        tableview = UITableView(frame: CGRect(x: 0,y: 64,width: KScreenWidth, height: KScreenHeight-64-49), style: .Plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 104
        tableview.separatorStyle = .None
        tableview.backgroundColor = UIColor.clearColor()
        self.view.addSubview(tableview)
        
        let searchVC = FeaturedViewController()
        searchVC.dataSource = []
        searchController = UISearchController(searchResultsController: searchVC)
        
        searchController.searchResultsUpdater = searchVC
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "搜索精选文章"

        for (_,value) in searchController.searchBar.subviews[0].subviews.enumerate(){
            if value.isKindOfClass(NSClassFromString("UINavigationButton")!){
                let cancel = value as! UIButton
                cancel.setTitle("取消", forState: .Normal)
            }
        }
        tableview.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
        
//        tableview.autoSetDimensionsToSize(CGSizeMake(10, 10))
//        tableview.autoPinEdgeToSuperviewEdge(.Top, withInset: 64)
//        tableview.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
//        tableview.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
//        tableview.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
        
        loadingData()
    }
    
    func loadingData(){
        let path: String = NSBundle.mainBundle().pathForResource("featurefile", ofType: "json")!
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
            let dictArr = (jsonData as! NSDictionary).objectForKey("data") as! NSArray
            if dataArr == nil{
                dataArr = NSMutableArray()
            }
            for (_, value) in dictArr.enumerate(){
                dataArr!.addObject(value)
            }
            tableview.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArr == nil{
            return 0
        }
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let str = "cellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(str) as? FeatrueTableViewCell
        if cell == nil{
            cell = FeatrueTableViewCell(style: .Default, reuseIdentifier: str)
        }
        cell?.transmit(dataArr[indexPath.row] as! NSDictionary)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.navigationController!.pushViewController(WebViewController(), animated: true)
    }
    
    func openLeftMeunClick(){
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
