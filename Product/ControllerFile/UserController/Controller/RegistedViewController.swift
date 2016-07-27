//
//  RegistedViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/25.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class RegistedViewController: UIViewController {

    
    @IBOutlet var username: UITextField!
    @IBOutlet var pwd: UITextField!
    @IBOutlet var ConfirmPwd: UITextField!
    
    
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
    
    @IBAction func registerClick(sender: UIButton) {

        let user = username.text
        let pws1 = pwd.text
        let pws2 = ConfirmPwd.text
        if user == "" || user == nil{
            KShowLabel.setText("请输入用户名！", positions: 1)
            return
        }
        if pws1 != pws2{
            KShowLabel.setText("密码不一致！", positions: 1)
            return
        }
        
        let error = EMClient.sharedClient().registerWithUsername(user, password: pws2)
        if error == nil{
            KShowLabel.setText("注册成功！", positions: 1)
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            KShowLabel.setText("注册失败,ID号重复或无效", positions: 1)
        }
    }
    
    @IBAction func rigisterBackClick(sender: UIButton) {
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
