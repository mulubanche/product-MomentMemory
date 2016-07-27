//
//  RootTabbarViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class RootTabbarViewController: UITabBarController, FDAlertViewDelegate {

    var alertView:YoYoAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let tabbar = TootTabbar()
        tabbar.initWithRelease(releaseClick)
        self.setValue(tabbar, forKey: "tabBar")
        
        let tab = UITabBar.appearance()
        tab.backgroundImage = imageWithColor(UIColor.whiteColor())
        tab.tintColor = MyThemeColor
        tab.shadowImage = UIImage()
        
        let homeSVC:ForumViewController = ForumViewController()
        let homeNav = UINavigationController(rootViewController: homeSVC)
        homeNav.tabBarItem.image = UIImage(named: "tabbar_user_none")
        homeNav.tabBarItem.selectedImage = UIImage(named: "tabbar_user")
        homeNav.title = "陌路"
        
        let userSVC:UserViewController = UserViewController()
        let userNav = UINavigationController(rootViewController: userSVC)
        userNav.tabBarItem.image = UIImage(named: "tabbar_home_none")
        userNav.tabBarItem.selectedImage = UIImage(named: "tabbar_home")
        userNav.tabBarItem.title = "精选"
        
        self.viewControllers = [homeNav, userNav]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RootTabbarViewController.skipMyController(_:)), name: skipController, object: nil)
    }
    
    func skipMyController(object:NSNotification){
        
        let dict = object.userInfo as! NSDictionary
        let num = dict.objectForKey("controllerKey") as! Int
        
        switch num {
        case 0:
            let svc = MyDatumViewController()
            let nav = UINavigationController(rootViewController: svc)
            nav.modalTransitionStyle = .CrossDissolve
            self.presentViewController(nav, animated: true, completion: nil)
            break
        case 1:
            let svc = FriendsViewController()
            let nav = UINavigationController(rootViewController: svc)
            nav.modalTransitionStyle = .CrossDissolve
            self.presentViewController(nav, animated: true, completion: nil)
            break
        case 2:
            let svc = MyCollectionViewController()
            let nav = UINavigationController(rootViewController: svc)
            nav.modalTransitionStyle = .CrossDissolve
            self.presentViewController(nav, animated: true, completion: nil)
            break
        case 3:
            let svc = MyLetterViewController()
            let nav = UINavigationController(rootViewController: svc)
            nav.modalTransitionStyle = .CrossDissolve
            self.presentViewController(nav, animated: true, completion: nil)
            break
        case 4:            
            if alertView == nil{
                alertView = YoYoAlertView(title: "登出提醒", message: "您确定要退出登录？", cancelButtonTitle: "取 消", sureButtonTitle: "确 定")
                alertView!.show()
                //获取点击事件
                alertView!.clickIndexClosure { (index) in
                    if index == 2{
                        let error = EMClient.sharedClient().logout(true)
                        if error == nil{
                            KShowLabel.setText("退出成功！", positions: 1)
                        }else{
                            KShowLabel.setText("退出失败！账号已过期", positions: 1)
                        }
                        kUserD().setValue("", forKey: username)
                        kUserD().synchronize()
                    }
                    self.alertView = nil
                }
            }
            break
        default:
            break
        }

    }
    
    func releaseClick() -> Void{
        
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
        let svc = ReleaseViewController()
        let nav = UINavigationController(rootViewController: svc)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    func imageWithColor(color: UIColor) -> UIImage{
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        return image
    }
    
    /*
     - (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
     NSLog(@"%ld", (long)buttonIndex);
     }
     */
    func alertView(alertView: FDAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        
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
