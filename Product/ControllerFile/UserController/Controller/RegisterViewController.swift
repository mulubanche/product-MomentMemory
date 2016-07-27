//
//  RegisterViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/25.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
//    override func viewWill
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: MyThemeColor]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "注册"
        self.view.backgroundColor = UIColor.whiteColor()
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
