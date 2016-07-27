//
//  RootViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var scrollView:UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = MyBackColor
        
        let back = UIBarButtonItem(title: "< 返回", style: .Bordered, target: self, action: #selector(RootViewController.backClick))
        back.tintColor = MyThemeColor
        self.navigationItem.leftBarButtonItem = back
        
//        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: MyThemeColor]
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "outagesNotfication", name: outages, object: nil)
        
    }
    
    func backClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //断网情况
    func outagesNotfication(){
    
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
