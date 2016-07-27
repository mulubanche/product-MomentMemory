//
//  ReleaseViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class ReleaseViewController: RootViewController, UITextViewDelegate, D3RecordDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var textview:PlaceholderTextView!
    var forumImgView:RootImageView!
    var soundBtn:D3RecordButton!
    var play:AVAudioPlayer!
    var addSoundLabel:UILabel?
    var soundImg:RootImageView?
    var soundData:NSData?
    var removeImgBtn:UIButton?
    var removeSoundBtn:UIButton?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let back = UIBarButtonItem(title: "取消", style: .Bordered, target: self, action: #selector(ReleaseViewController.backClick))
        back.tintColor = MyThemeColor
        self.navigationItem.leftBarButtonItem = back
        
        let release = UIBarButtonItem(title: "发布", style: .Bordered, target: self, action: #selector(ReleaseViewController.releaseClick))
        release.tintColor = MyThemeColor
        self.navigationItem.rightBarButtonItem = release
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "此刻"
        
        // Do any additional setup after loading the view.
        
        createUIView()
        
    }
    
    func createUIView(){
        textview = PlaceholderTextView.newAutoLayoutView()
        textview.backgroundColor = UIColor.whiteColor()
        textview.delegate = self
        textview.font = fontSize(14)
        textview.textColor = MyColorBlack
        textview.textAlignment = .Left
        textview.editable = true
        textview.layer.cornerRadius = 4.0
        textview.layer.borderColor = MyColorGray.CGColor
        textview.layer.borderWidth = 0.5
        textview.placeholderColor = RGBA(167, g: 167, b: 167, a: 1)
        textview.placeholder = "我的存在，只为记录此刻的意义"
        self.view.addSubview(textview)
        
        let addImgLabel = UILabel.newAutoLayoutView()
        addImgLabel.font = fontSize(14)
        addImgLabel.textAlignment = .Left
        addImgLabel.textColor = MyColorBlack
        addImgLabel.text = "添加照片"
        self.view.addSubview(addImgLabel)
        
        removeImgBtn = UIButton.newAutoLayoutView()
        removeImgBtn!.adjustsImageWhenHighlighted = false
        removeImgBtn!.setImage(UIImage(named: "release_remove"), forState: .Normal)
        removeImgBtn!.hidden = true
        removeImgBtn!.addTarget(self, action: #selector(ReleaseViewController.removeImgClick), forControlEvents: .TouchUpInside)
        removeImgBtn!.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        self.view.addSubview(removeImgBtn!)
        
        forumImgView = RootImageView.newAutoLayoutView()
        forumImgView.image = UIImage(named: "release_add_image")
        forumImgView.addTarget(self, action: #selector(ReleaseViewController.addForumImage))
        self.view.addSubview(forumImgView)
        
        addSoundLabel = UILabel.newAutoLayoutView()
        addSoundLabel!.font = fontSize(14)
        addSoundLabel!.textAlignment = .Left
        addSoundLabel!.textColor = MyColorBlack
        addSoundLabel!.text = "添加的录音"
        addSoundLabel!.hidden = true
        self.view.addSubview(addSoundLabel!)
        
        removeSoundBtn = UIButton.newAutoLayoutView()
        removeSoundBtn!.adjustsImageWhenHighlighted = false
        removeSoundBtn!.setImage(UIImage(named: "release_remove"), forState: .Normal)
        removeSoundBtn!.hidden = true
        removeSoundBtn!.addTarget(self, action: #selector(ReleaseViewController.removeSoundClick), forControlEvents: .TouchUpInside)
        removeSoundBtn!.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        self.view.addSubview(removeSoundBtn!)
        
        soundImg = RootImageView.newAutoLayoutView()
        soundImg!.image = UIImage(named: "release_play")
        soundImg!.hidden = false
        soundImg!.addTarget(self, action: #selector(ReleaseViewController.playSound))
        self.view.addSubview(soundImg!)
        
        soundBtn = D3RecordButton.newAutoLayoutView()
        soundBtn.backgroundColor = MyThemeColor
        soundBtn.adjustsImageWhenHighlighted = false
        soundBtn.setTitle("开始录音", forState: .Normal)
        soundBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(soundBtn)
        soundBtn.initRecord(self, maxtime: 240, title: "上滑取消录音")
        
        textview.autoSetDimensionsToSize(CGSizeMake(10, 120))
        textview.autoPinEdgeToSuperviewEdge(.Top, withInset: 10+64)
        textview.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        textview.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        
        var width = addImgLabel.text!.boundingRectWithSize(CGSizeMake(1000, 20), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:addImgLabel.font], context: nil).size.width
        addImgLabel.autoSetDimensionsToSize(CGSizeMake(width, 20))
        addImgLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        addImgLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: textview, withOffset: 10)
        
        removeImgBtn!.autoSetDimensionsToSize(CGSizeMake(30, 30))
        removeImgBtn!.autoPinEdge(.Left, toEdge: .Right, ofView: addImgLabel, withOffset: 10)
        removeImgBtn!.autoPinEdge(.Top, toEdge: .Bottom, ofView: textview, withOffset: 6)
        
        forumImgView.autoSetDimensionsToSize(CGSizeMake(64, 64))
        forumImgView.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        forumImgView.autoPinEdgeToSuperviewEdge(.Right, withInset: KScreenWidth-64-10)
        forumImgView.autoPinEdge(.Top, toEdge: .Bottom, ofView: addImgLabel, withOffset: 10)
        
        width = addSoundLabel!.text!.boundingRectWithSize(CGSizeMake(1000, 20), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:addSoundLabel!.font], context: nil).size.width
        addSoundLabel!.autoSetDimensionsToSize(CGSizeMake(width, 20))
        addSoundLabel!.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
//        addSoundLabel!.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        addSoundLabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: forumImgView, withOffset: 10)
        
        removeSoundBtn!.autoSetDimensionsToSize(CGSizeMake(30, 30))
        removeSoundBtn!.autoPinEdge(.Left, toEdge: .Right, ofView: addSoundLabel!, withOffset: 10)
        removeSoundBtn!.autoPinEdge(.Top, toEdge: .Bottom, ofView: forumImgView, withOffset: 6)
        
        soundBtn.autoSetDimensionsToSize(CGSizeMake(10, 40))
        soundBtn.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        soundBtn.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        soundBtn.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
    }
    
    func removeImgClick(){
        removeImgBtn!.hidden = true
        forumImgView.image = UIImage(named: "release_add_image")
    }
    
    func removeSoundClick(){
        addSoundLabel!.hidden = true
        soundImg!.hidden = true
        removeSoundBtn!.hidden = true
    }
    
    func addForumImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let gotImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let midImage:UIImage = self.imageWithImageSimple(gotImage, scaledToSize: CGSizeMake(1000.0, 1000.0))
        removeImgBtn!.hidden = false
        forumImgView.image = midImage
        
    }
    
    func imageWithImageSimple(image:UIImage ,scaledToSize newSize:CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func endRecord(voiceData: NSData!) {
        soundData = voiceData
        
        addSoundLabel!.hidden = false
        soundImg!.hidden = false
        removeSoundBtn!.hidden = false

        soundImg!.frame = CGRectMake(10, CGRectGetMaxY(addSoundLabel!.frame)+10, 1, 30)
        let length = voiceData.length/1024
        UIView.animateWithDuration(0.5) {
            if length < 10{
                self.soundImg!.frame.size.width = 50
            }else if length >= 10 && length < 110{
                self.soundImg!.frame.size.width = 50 + CGFloat(length)
            }else{
                self.soundImg!.frame.size.width = KScreenWidth-50
            }
        }
        
    }
    
    func playSound(){
        if soundData == nil{
            return
        }
        do{
            try play = AVAudioPlayer(data: soundData!)
            play.volume = 1.0
            play.play()
            soundBtn.setTitle("按住录音", forState: .Normal)
        }catch{
            print("录音错误")
        }
    }
    
    func dragExit() {
        soundBtn.setTitle("按住录音", forState: .Normal)
    }
    
    func dragEnter() {
        soundBtn.setTitle("松开发送", forState: .Normal)
    }
    
    override func backClick(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func releaseClick(){
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
