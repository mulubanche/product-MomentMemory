//
//  AppDelegate.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController
import AFNetworking
//import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, EMClientDelegate, GeTuiSdkDelegate {

    var window: UIWindow?
    var mfs:MFSideMenuContainerViewController!
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        mfs = MFSideMenuContainerViewController()
        mfs.leftMenuViewController = LeftViewController()
//        mfs.rightMenuViewController = RightViewController()
        mfs.centerViewController = RootTabbarViewController()
//        mfs.centerViewController = createTabBar()
        self.window!.rootViewController = mfs
        
        UMAnalyticsConfig().appKey = "57676484e0f55a519f003d2f"
        UMAnalyticsConfig().channelId = "App_Store"
        
//        IQKeyboardManager.sharedManager().enable = true
//        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
//        //[[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:0];
//        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        //监听网络状态
        MonitorNetworkState()
        
        //环信
        huanxinSDK()
        
        //个推
        getuiSDK()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.openLeftMenuClick), name: openLeftMeun, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.closeLeftMenuClick), name: closeLeftMeun, object: nil)
        
        return true
    }
    
    func MonitorNetworkState(){

        EMClient.sharedClient().addDelegate(self, delegateQueue: nil)
        
        NSURLCache.sharedURLCache().memoryCapacity = 5*1024*1024
        NSURLCache.sharedURLCache().diskCapacity = 5*1024*1024
        let manager = NetworkingTools.sharedManager()
        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock { (status) in
            switch status{
            case AFNetworkReachabilityStatus.NotReachable:
                manager.requestSerializer.cachePolicy = .ReturnCacheDataDontLoad
                let alertView = YoYoAlertView(title: "网络异常", message: "当前没有网络，请检查你的网络设置", cancelButtonTitle: "确定", sureButtonTitle: "网络设置")
                alertView.show()
                alertView.clickIndexClosure({ (index) in
                    if index == 2{
                        UIApplication.sharedApplication().openURL(NSURL(string: "prefs:root=WIFI")!)
                    }
                })
                break
            case AFNetworkReachabilityStatus.ReachableViaWWAN:
                manager.requestSerializer.cachePolicy = .ReturnCacheDataElseLoad
                KShowLabel.setText("当前为手机数据流量", positions: 1)
                break
            case AFNetworkReachabilityStatus.ReachableViaWiFi:
                manager.requestSerializer.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
                KShowLabel.setText("当前为WIFI", positions: 1)
                break
            default:
                break
            }
        }
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
    }
    
    //个推相关设置
    func getuiSDK()
    {
        GeTuiSdk.startSdkWithAppId("dpf3rnClsoAwEKaRLDYe75", appKey: "pCG2pPD3UP7uRsvFkcte29", appSecret: "jkjeJHgSk97JorqDVk0FA3", delegate: self)
        ObjectFile().registerUserNotification()
    }
    
    //远程通知注册成功委托
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        var token = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "<>"))
        token = token.stringByReplacingOccurrencesOfString(" ", withString: "")
        GeTuiSdk.registerDeviceToken(token)
    }
    
    //远程通知注册失败委托
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("远程通知注册失败委托" + error.localizedDescription)
    }
    
    //APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台)
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        let record = "APN\(NSDate()),\(userInfo)"
        print(record)
        GeTuiSdk.clearAllNotificationForNotificationBar()
        UIApplication.sharedApplication().applicationIconBadgeNumber = 1
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    
    //唤醒推送
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        GeTuiSdk.resume()
        GeTuiSdk.setBadge(1)
        //        UIApplication.sharedApplication().applicationIconBadgeNumber = 1
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    
    //SDK启动成功返回
    func GeTuiSdkDidRegisterClient(clientId: String!) {
        print("ClientID = \(clientId)")
    }
    
    //SDK遇到错误回调
    func GeTuiSdkDidOccurError(error: NSError!) {
        print("推送SDK调用出错 ＝ \(error.localizedDescription)")
    }
    
    //SDK收到透传消息回调
    func GeTuiSdkDidReceivePayloadData(payloadData: NSData!, andTaskId taskId: String!, andMsgId msgId: String!, andOffLine offLine: Bool, fromGtAppId appId: String!) {
        
        var payloadMsg:NSString!
        if payloadData != nil{
            payloadMsg = NSString(bytes: payloadData.bytes, length: payloadData.length, encoding: NSUTF8StringEncoding)
        }
        print("taskId=\(taskId);messageId=\(msgId);payloadMsg=\(payloadMsg)")
        GeTuiSdk.sendFeedbackMessage(90001, taskId: taskId, msgId: msgId)
    }
    
    //SDK收到sendMessage消息回调
    func GeTuiSdkDidSendMessage(messageId: String!, result: Int32) {
        
        print("收到sendMessage消息回调 sendmessage=\(messageId) result=\(result)")
    }
    
    //SDK运行状态通知
    func GeTuiSDkDidNotifySdkState(aStatus: SdkStatus) {
        
        switch aStatus
        {
        case SdkStatusStarting:
            print("正在启动")
            break
        case SdkStatusStarted:
            print("启动")
            break
        case SdkStatusStoped:
            print("停止")
            break
        default:
            break
        }
    }
    
    //SDK设置推送模式回调
    func GeTuiSdkDidSetPushMode(isModeOff: Bool, error: NSError!) {
        if error != nil
        {
            print("推送回调出现异常:\(error.localizedDescription)")
            return
        }
        print("推送回调:\(isModeOff ? "开启" : "关闭")")
    }
    
    
    
    
    //EMClient代理方法
    //自动登录错误
    func didAutoLoginWithError(aError: EMError!) {
        KShowLabel.setText("自动登录出现错误", positions: 1)
    }
    //重连
    func didConnectionStateChanged(aConnectionState: EMConnectionState) {
        if aConnectionState == EMConnectionConnected{
            KShowLabel.setText("已登录", positions: 1)
        }else{
            KShowLabel.setText("已断网", positions: 1)
            NSNotificationCenter.defaultCenter().postNotificationName(outages, object: nil)
        }
    }
    //当前登录账号在其它设备登录时会接收到该回调
    func didLoginFromOtherDevice() {
        KShowLabel.setText("您的账号在另一台设备登录！", positions: 1)
        kUserD().setValue("", forKey: username)
        kUserD().synchronize()
    }
    //当前登录账号已经被从服务器端删除时会收到该回调
    func didRemovedFromServer() {
        KShowLabel.setText("您的账号已无效！", positions: 1)
        kUserD().setValue("", forKey: username)
        kUserD().synchronize()
    }
    
    func huanxinSDK(){
        let options = EMOptions.init(appkey: "jcd324#momentmemory")
        options.apnsCertName = "moment_deve_push"
        EMClient.sharedClient().initializeSDKWithOptions(options)
    }
    
    func openLeftMenuClick(){
        mfs.menuState = MFSideMenuStateLeftMenuOpen
    }
    func closeLeftMenuClick(){
        mfs.menuState = MFSideMenuStateClosed
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    //APP进入后台
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        EMClient.sharedClient().applicationDidEnterBackground(application)
        NSNotificationCenter.defaultCenter().postNotificationName(colselogin, object: nil)
    }

    //APP将要从后台返回
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        EMClient.sharedClient().applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait;
    }

}

