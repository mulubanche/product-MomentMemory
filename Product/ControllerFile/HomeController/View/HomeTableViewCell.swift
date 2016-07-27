//
//  HomeTableViewCell.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

typealias showBigImage = (dict: NSDictionary) -> Void
typealias thumbUpType = (ret: Bool) -> Void
typealias commentType = () -> Void

class HomeTableViewCell: UITableViewCell {

    var messageView:UserMessageView!
    var backview:UIView!
    var cellHeight:CGFloat!
    
    //info
    var detailelabel:UILabel?
    var forumImageView:RootImageView?
    
    var dataDict:NSDictionary?
    var myShowImg:showBigImage?
    
    var thumbUp:UIButton!               //点赞
    var comment:UIButton!               //评论
    
    var myThumbUp:thumbUpType?
    var myComment:commentType?
    
    //查看图片
    func initWithShowImageView(sender: showBigImage){
        myShowImg = sender
    }
    //点赞
    func initWithThumbUpType(sender: thumbUpType){
        myThumbUp = sender
    }
    //评论
    func initWithCommentType(sender: commentType){
        myComment = sender
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backview = UIView.newAutoLayoutView()
        backview.backgroundColor = UIColor.whiteColor()
        self.addSubview(backview)
        
        messageView = NSBundle.mainBundle().loadNibNamed("UserMessageView", owner: nil, options: nil).first as! UserMessageView
        messageView.userName.font = fontSize(14)
        backview.addSubview(messageView)
        
        
        backview.autoSetDimensionsToSize(CGSizeMake(10, 10))
        backview.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        backview.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        backview.autoPinEdgeToSuperviewEdge(.Top, withInset: 0)
        backview.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 4)
        
        messageView.autoSetDimensionsToSize(CGSizeMake(10, 50))
        messageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        messageView.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        messageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 0)
        
        detailelabel = UILabel.newAutoLayoutView()
        detailelabel!.font = fontSize(14)
        detailelabel!.textColor = MyColorGray
        detailelabel!.textAlignment = .Left
        detailelabel!.numberOfLines = 0
        self.addSubview(detailelabel!)
        
        forumImageView = RootImageView.newAutoLayoutView()
//        forumImageView!.contentMode = .ScaleAspectFill
        forumImageView?.addTarget(self, action: #selector(HomeTableViewCell.showBigImageView))
        self.addSubview(forumImageView!)
        
        
        thumbUp = UIButton.newAutoLayoutView()
        thumbUp.adjustsImageWhenHighlighted = false
        thumbUp.setImage(UIImage(named: "thumbUp_none"), forState: .Normal)
        thumbUp.setImage(UIImage(named: "thumbUp_set"), forState: .Selected)
        thumbUp.selected = false
        thumbUp.addTarget(self, action: #selector(HomeTableViewCell.thumbUpClick), forControlEvents: .TouchUpInside)
        self.addSubview(thumbUp)
        
        comment = UIButton.newAutoLayoutView()
        comment.adjustsImageWhenHighlighted = false
        comment.setImage(UIImage(named: "comment"), forState: .Normal)
        comment.addTarget(self, action: #selector(HomeTableViewCell.commentClick), forControlEvents: .TouchUpInside)
        self.addSubview(comment)
        
    }
    
    func thumbUpClick(){
        if thumbUp.selected{
            thumbUp.selected = false
        }else{
            thumbUp.selected = true
        }
        if myThumbUp != nil{
            myThumbUp!(ret: thumbUp.selected)
        }
    }
    
    func commentClick(){
        if myComment != nil{
            myComment!()
        }
    }
    
    func showBigImageView(){
        if myShowImg != nil{
            myShowImg!(dict: dataDict!)
        }
    }
    
    func transmitData(dict: NSDictionary, tag: Int){
        
        comment.autoSetDimensionsToSize(CGSizeMake(30, 20))
        thumbUp.autoSetDimensionsToSize(CGSizeMake(20, 20))
        
        dataDict = dict
        
        messageView.OnlyLogo = tag
        messageView.userName.text = dict.objectForKey("username") as? String
        messageView.userImage.image = UIImage(named: dict.objectForKey("usericon") as! String)
        
        cellHeight = 70
        
        let text = isNullStr(dict.objectForKey("info")!)
        if text != ""{
            let height = text.boundingRectWithSize(CGSizeMake(KScreenWidth, 2000), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:detailelabel!.font], context: nil).size.height
            
            detailelabel!.text = text
            
            adjustWithLabelSpacing(detailelabel!.text!, label: detailelabel!)
            let size = detailelabel!.sizeThatFits(CGSizeMake(KScreenWidth-40, 4000))
            let num = size.height/detailelabel!.font.lineHeight
            cellHeight = cellHeight+height+5*num
            
//            backview.frame.size.height = cellHeight-8
            
            detailelabel!.autoSetDimensionsToSize(CGSizeMake(10, height+10+5*num))
            detailelabel!.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            detailelabel!.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
            detailelabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: messageView, withOffset: 0)
        }
        
        let imgUrl = isNullStr(dict.objectForKey("imgUrl")!)
        if imgUrl != ""{
            
            let img = UIImage(named: imgUrl)
            
            let size = img!.size
            var imgWidth:CGFloat = 0.0
            var imgHeight:CGFloat = 0.0
            
//            if size.width > KScreenWidth{
//                imgWidth = KScreenWidth-20
//                imgHeight = imgWidth/size.width*size.height
//            }else{
//                imgWidth = size.width
//                imgHeight = size.height
//            }
            
            if size.height > 240/320*KScreenWidth{
                imgHeight = 240/320*KScreenWidth
                imgWidth = 240/320*KScreenWidth/size.height*size.width
                
                if imgWidth > KScreenWidth{
                    imgHeight = (KScreenWidth-20)/imgWidth*imgHeight
                    imgWidth = KScreenWidth-20
                }
            }
            
            forumImageView!.image = UIImage(named: imgUrl)
            
            
            forumImageView!.autoSetDimensionsToSize(CGSizeMake(imgWidth, imgHeight))
            if text != ""{
                forumImageView!.autoPinEdge(.Top, toEdge: .Bottom, ofView: detailelabel!, withOffset: 5)
            }else{
                forumImageView!.autoPinEdge(.Top, toEdge: .Bottom, ofView: messageView, withOffset: 0)
            }
            forumImageView!.autoPinEdgeToSuperviewEdge(.Left, withInset: (KScreenWidth-imgWidth)/2)
            
            cellHeight = cellHeight+imgHeight+8
            
            comment.autoPinEdgeToSuperviewEdge(.Right, withInset: 20)
            comment.autoPinEdge(.Top, toEdge: .Bottom, ofView: forumImageView!, withOffset: 11)
            
            thumbUp.autoPinEdge(.Top, toEdge: .Bottom, ofView: forumImageView!, withOffset: 10)
            thumbUp.autoPinEdgeToSuperviewEdge(.Right, withInset: 70)
//            thumbUp.autoPinEdge(.Right, toEdge: .Left, ofView: comment, withOffset: 20)
        }else{
            comment.autoPinEdgeToSuperviewEdge(.Right, withInset: 20)
            comment.autoPinEdge(.Top, toEdge: .Bottom, ofView: detailelabel!, withOffset: 11)
            
            thumbUp.autoPinEdge(.Top, toEdge: .Bottom, ofView: detailelabel!, withOffset: 10)
            thumbUp.autoPinEdgeToSuperviewEdge(.Right, withInset: 70)
//            thumbUp.autoPinEdge(.Right, toEdge: .Left, ofView: comment, withOffset: 20)
        }
        
        thumbUp.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2)
        comment.imageEdgeInsets = UIEdgeInsetsMake(3, 6, 3, 6)
        
        cellHeight = cellHeight+comment!.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height+8
        backview.frame.size.height = comment!.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height-8
    }
    
    func returnCellHeight() -> CGFloat{
        return cellHeight
    }

    
    func adjustWithLabelSpacing(text: String, label: UILabel){
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, text.characters.count))
        label.attributedText = attributedString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
