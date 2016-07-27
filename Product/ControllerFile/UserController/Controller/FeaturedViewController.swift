//
//  FeaturedViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/28.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class FeaturedViewController: RootViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {

    var tableview:UITableView!
    var dataSource:NSArray!
    var dataArr:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableview = UITableView(frame: CGRect(x: 0, y: 64, width: KScreenWidth, height: KScreenHeight-64), style: .Plain)
        tableview.delegate = self
        tableview.dataSource = self
        self.view.addSubview(tableview)
        
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
            //            print(jsonData)
            
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
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print("updateSearchResultsForSearchController")
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
