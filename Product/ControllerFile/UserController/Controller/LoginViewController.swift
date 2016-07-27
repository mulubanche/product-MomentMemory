//
//  LoginViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/23.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import AVKit
/*
 #import <MediaPlayer/MediaPlayer.h>
 #import <AVFoundation/AVFoundation.h>
 */

class LoginViewController: RootViewController {
    
    var playerController:AVPlayerViewController?
    var player:AVPlayer?
    var session:AVAudioSession?
    var url:NSURL?
    var retCreate:Bool = false
    
    var userInput:LoginInputView?
    var passInput:LoginInputView?
    var registerBtn:UIButton!
    var loginBtn:UIButton!
    
    var wxIcon:RootImageView!
    var wbIcon:RootImageView!
    var qqIcon:RootImageView!
    
    var mvPlayer:MPMoviePlayerController?
    
    var loginLodingView: UIActivityIndicatorView?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if retCreate == false{
            createUIVIew()
        }else{
            enterView()
        }
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        QuitCurveView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        kUserD().setValue("false", forKey: colselogin)
//        kUserD().synchronize()
        
        let msUrl = NSBundle.mainBundle().pathForResource("mv", ofType: "mp4")
        url = NSURL.fileURLWithPath(msUrl!)
        session = AVAudioSession.sharedInstance()
        do{
            try session!.setCategory(AVAudioSessionCategoryAmbient, withOptions: .AllowBluetooth)
        }catch{
            print("播放错误")
        }
//        let item = AVPlayerItem(URL: url!)
//        player = AVPlayer(playerItem: item)
//        playerController = AVPlayerViewController()
//        playerController!.player = player
//        playerController!.videoGravity = AVLayerVideoGravityResizeAspect
//        playerController!.allowsPictureInPicturePlayback = true
//        playerController!.showsPlaybackControls = true
//        self.addChildViewController(playerController!)
//        playerController!.view.translatesAutoresizingMaskIntoConstraints = true
//        playerController!.view.frame = self.view.bounds
//        self.view.addSubview(playerController!.view)
//        playerController!.player!.play()
        
        
        mvPlayer = MPMoviePlayerController(contentURL: url)
        mvPlayer!.play()
        mvPlayer!.view.frame = self.view.bounds
        self.view.addSubview(mvPlayer!.view)
        mvPlayer!.shouldAutoplay = true
        mvPlayer!.controlStyle = .None
        mvPlayer!.fullscreen = true
        mvPlayer!.repeatMode = .One
        
        
        
        let backBtn = UIButton.newAutoLayoutView()
        backBtn.adjustsImageWhenHighlighted = false
        backBtn.setImage(UIImage(named: "login_close"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(LoginViewController.backClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(backBtn)
        
        backBtn.autoSetDimensionsToSize(CGSizeMake(30, 30))
        backBtn.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        backBtn.autoPinEdgeToSuperviewEdge(.Top, withInset: 30)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.backClick), name: colselogin, object: nil)
    }
    
    func createUIVIew(){
        retCreate = true
//        NSThread.sleepForTimeInterval(1)
        
        userInput = LoginInputView(frame: CGRect(x: -KScreenWidth, y: (KScreenHeight-180)/2, width: KScreenWidth-30, height:44), placeStr: "用户名")
        self.view.addSubview(userInput!)
        
        passInput = LoginInputView(frame: CGRect(x: -KScreenWidth, y: (KScreenHeight-50)/2, width: KScreenWidth-30, height:44), placeStr: "密码")
        passInput!.textfiled!.secureTextEntry = true
        self.view.addSubview(passInput!)
        
        let btnWidth = (KScreenWidth-40)/2
        
//        let registerBtn = UIButton(frame: CGRect(x: 15, y: CGRectGetMaxY(passInput!.frame)+20, width: btnWidth, height: 30))
        registerBtn = createLoginBtn(CGRect(x: 15, y: CGRectGetMaxY(passInput!.frame)+20, width: btnWidth, height: 40), title: "注 册", taget: #selector(LoginViewController.registerClick), ret: true)
        registerBtn.alpha = 0.0
        self.view.addSubview(registerBtn)
        
        loginBtn = createLoginBtn(CGRect(x: CGRectGetMaxX(registerBtn.frame)+10, y: CGRectGetMaxY(passInput!.frame)+20, width: btnWidth, height: 40), title: "登 录", taget: #selector(LoginViewController.loginClick), ret: false)
        loginBtn.alpha = 0.0
        self.view.addSubview(loginBtn)
        
        let iconWidth = (KScreenWidth - KScreenWidth/2)/8
        wxIcon = RootImageView(frame: CGRectMake(KScreenWidth/4, KScreenHeight, KScreenWidth/8, KScreenWidth/8))
        wxIcon.image = UIImage(named: "login_wx_icon")
        self.view.addSubview(wxIcon)
        
        wbIcon = RootImageView(frame: CGRectMake(CGRectGetMaxX(wxIcon.frame)+iconWidth, KScreenHeight, KScreenWidth/8, KScreenWidth/8))
        wbIcon.image = UIImage(named: "login_wb_icon")
        self.view.addSubview(wbIcon)
        
        qqIcon = RootImageView(frame: CGRectMake(CGRectGetMaxX(wbIcon.frame)+iconWidth, KScreenHeight, KScreenWidth/8, KScreenWidth/8))
        qqIcon.image = UIImage(named: "login_qq_icon")
        self.view.addSubview(qqIcon)
        
        enterView()
    }
    
    func QuitCurveView(){
        self.registerBtn.alpha = 0.0
        self.loginBtn.alpha = 0.0
        self.passInput!.frame.origin.x = -KScreenWidth
        self.thirdPartyLogin(false)
        self.userInput!.frame.origin.x = -KScreenWidth
    }
    
    func enterView(){
        mvPlayer!.play()
        UIView.animateWithDuration(0.5, animations: {
            self.userInput!.frame.origin.x = 15
        }) { (ret) in
            
            self.thirdPartyLogin(true)
            
            UIView.animateWithDuration(0.5, animations: {
                self.passInput!.frame.origin.x = 15
            }){(ret) in
                UIView.animateWithDuration(0.5, animations: {
                    self.registerBtn.alpha = 1.0
                    self.loginBtn.alpha = 0.75
                })
            }
        }
    }
    
    func thirdPartyLogin(ret: Bool){

        if ret{
            UIView.animateWithDuration(0.45) {
                self.wxIcon.frame.origin.y = KScreenHeight-KScreenWidth/8-50
            }
            UIView.animateWithDuration(0.65) {
                self.wbIcon.frame.origin.y = KScreenHeight-KScreenWidth/8-50
            }
            UIView.animateWithDuration(0.85) {
                self.qqIcon.frame.origin.y = KScreenHeight-KScreenWidth/8-50
            }
        }else{
            UIView.animateWithDuration(0.45) {
                self.wxIcon.frame.origin.y = KScreenHeight
            }
            UIView.animateWithDuration(0.65) {
                self.wbIcon.frame.origin.y = KScreenHeight
            }
            UIView.animateWithDuration(0.85) {
                self.qqIcon.frame.origin.y = KScreenHeight
            }
        }
    }
    
    func registerClick(){
        let nav = UINavigationController(rootViewController: RegistedViewController())
        nav.modalTransitionStyle = .CrossDissolve
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    func loginClick(){
        
        let user = userInput!.textfiled!.text
        let pwd = passInput!.textfiled!.text
        if user == "" || user == nil{
            KShowLabel.setText("用户名为空", positions: 1)
            return
        }
        if pwd == "" || pwd == nil{
            KShowLabel.setText("密码为空", positions: 1)
            return
        }
        if (pwd as! NSString).length < 6 || (pwd as! NSString).length > 16{
            KShowLabel.setText("密码长度应为6~16位", positions: 1)
            return
        }
        
        if loginLodingView == nil{
            loginLodingView = UIActivityIndicatorView(frame: CGRect(x: (KScreenWidth-50)/2, y: (KScreenHeight-50)/2, width: 50, height: 50))
            loginLodingView!.activityIndicatorViewStyle = .White
            self.view.addSubview(loginLodingView!)
            loginLodingView!.startAnimating()
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            let error = EMClient.sharedClient().loginWithUsername(user, password: pwd)
            if error != nil{
                KShowLabel.setText("登录失败！用户名或密码错误", positions: 1)
                self.loginLodingView!.stopAnimating()
            }else{
                self.loginLodingView!.stopAnimating()
                EMClient.sharedClient().options.isAutoLogin = true
                KShowLabel.setText("登录成功！", positions: 1)
                kUserD().setValue(user, forKey: username)
                kUserD().synchronize()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }

    }
    
    override func outagesNotfication() {
        
    }
    
    func createLoginBtn(frame: CGRect, title: String, taget: Selector, ret: Bool) -> UIButton{
        let btn = UIButton(frame: frame)
        btn.adjustsImageWhenHighlighted = false
        btn.layer.cornerRadius = 20
        if ret{
            btn.backgroundColor = UIColor.clearColor()
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.whiteColor().CGColor
        }else{
            btn.backgroundColor = MyColorGreen
        }
        btn.setTitle(title, forState: .Normal)
        btn.addTarget(self, action: taget, forControlEvents: .TouchUpInside)
        return btn
    }

    override func backClick(){
        
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
