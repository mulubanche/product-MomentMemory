//
//  SendMessageView.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/7/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

typealias returnText = (str: String) -> Void

class SendMessageView: UIView, UITextViewDelegate {

    var textview:UITextView!
    var sendBtn:UIButton!
    
    var sendHeight = 0.0
    var myText:returnText?
    
    func initWithRetuenText(sender: returnText){
        myText = sender
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = RGBA(240, g: 232, b: 201, a: 1)
        
        textview = UITextView.newAutoLayoutView()
        textview.layer.borderColor = MyThemeColor.CGColor
        textview.layer.borderWidth = 0.8
        textview.delegate = self
        //UIReturnKeySend
        textview.keyboardType = .NamePhonePad
        textview.returnKeyType = .Send
        self.addSubview(textview)
        
        sendBtn = UIButton.newAutoLayoutView()
        sendBtn.backgroundColor = MyThemeColor
        sendBtn.titleLabel!.font = fontSize(13)
        sendBtn.setTitle("发 送", forState: .Normal)
        sendBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendBtn.adjustsImageWhenHighlighted = false
        sendBtn.addTarget(self, action: #selector(SendMessageView.sendClick), forControlEvents: .TouchUpInside)
        self.addSubview(sendBtn)
        
        textview.autoSetDimensionsToSize(CGSizeMake(10, 10))
        textview.autoPinEdgeToSuperviewEdge(.Top, withInset: 5)
        textview.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 5)
        textview.autoPinEdgeToSuperviewEdge(.Left, withInset: 15)
        textview.autoPinEdgeToSuperviewEdge(.Right, withInset: 55)

        sendBtn.autoSetDimensionsToSize(CGSizeMake(40, 30))
        sendBtn.autoPinEdgeToSuperviewEdge(.Right, withInset: 15)
        sendBtn.autoPinEdgeToSuperviewEdge(.Top, withInset: 5)
        sendBtn.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 5)
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            if myText != nil{
                myText!(str: textview.text)
            }
            textview.text = ""
            return false
        }
        return true
    }
    
    func sendClick(){
//        textview.resignFirstResponder()
        if myText != nil{
            myText!(str: textview.text)
        }
        textview.text = ""
    }
    
//    text
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
