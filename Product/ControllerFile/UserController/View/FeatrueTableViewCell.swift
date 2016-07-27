//
//  FeatrueTableViewCell.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/29.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class FeatrueTableViewCell: UITableViewCell {

    var featrueImageView:UIImageView?
    var featrueTitle:UILabel?
    var featrueDetail:UILabel?
    var featrueRead:UILabel?
    var backview:UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        
        backview = UIView.newAutoLayoutView()
        backview.backgroundColor = UIColor.whiteColor()
        self.addSubview(backview)
        
//        featrueImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 80))
        featrueImageView = UIImageView.newAutoLayoutView()
        featrueImageView!.backgroundColor = UIColor.purpleColor()
        featrueImageView!.contentMode = .ScaleAspectFill
        featrueImageView!.layer.masksToBounds = true
        backview.addSubview(featrueImageView!)
        
        featrueTitle = UILabel.newAutoLayoutView()
        backview.addSubview(featrueTitle!)
        featrueTitle!.font = fontSize(14)
        featrueTitle!.textColor = MyColorBlack
        featrueTitle!.textAlignment = .Left
        
        featrueDetail = UILabel.newAutoLayoutView()
        backview.addSubview(featrueDetail!)
        featrueDetail!.font = fontSize(12)
        featrueDetail!.textColor = MyColorGray
        featrueDetail!.textAlignment = .Left
//        featrueDetail!.contentMode = .TopRight
        featrueDetail!.sizeToFit()
        featrueDetail!.numberOfLines = 0
        
        featrueRead = UILabel.newAutoLayoutView()
        backview.addSubview(featrueRead!)
        featrueRead!.font = fontSize(10)
        featrueRead!.textColor = MyColorGray
        featrueRead!.textAlignment = .Right
        
        backview.autoSetDimensionsToSize(CGSizeMake(10, 10))
        backview.autoPinEdgeToSuperviewEdge(.Top, withInset: 0)
        backview.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        backview.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        backview.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 4)
        
        featrueImageView!.autoSetDimensionsToSize(CGSizeMake(100, 80))
        featrueImageView!.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
        featrueImageView!.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        featrueImageView!.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
        
        featrueTitle!.autoSetDimensionsToSize(CGSizeMake(10, 20))
        featrueTitle!.autoPinEdgeToSuperviewEdge(.Top, withInset: 8)
        featrueTitle!.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        featrueTitle!.autoPinEdgeToSuperviewEdge(.Left, withInset: 120)
//        featrueTitle!.autoPinEdge(.Left, toEdge: .Right, ofView: featrueImageView!, withOffset: 10)
        
        
        featrueDetail!.autoSetDimensionsToSize(CGSizeMake(10, 20))
        featrueDetail!.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30)
        featrueDetail!.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
//        featrueDetail!.autoPinEdge(.Left, toEdge: .Right, ofView: featrueImageView!, withOffset: 10)
        featrueDetail!.autoPinEdgeToSuperviewEdge(.Left, withInset: 120)
        featrueDetail!.autoPinEdge(.Top, toEdge: .Bottom, ofView: featrueTitle!, withOffset: 4)
        
        featrueRead!.autoSetDimensionsToSize(CGSizeMake(100, 20))
        featrueRead!.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 4)
        featrueRead!.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
    }
    
    func transmit(dict: NSDictionary){
        
        featrueImageView?.image = UIImage(named: isNullStr(dict["imgUrl"]!))
        featrueTitle?.text = isNullStr(dict["title"]!)
        featrueDetail?.text = isNullStr(dict["detail"]!)
        featrueRead?.text = "\(isNullNumber(dict["count"]!))已阅读"
        
        adjustWithLabelSpacing((featrueDetail?.text)!, label: featrueDetail!)
    }
    
    func adjustWithLabelSpacing(text: String, label: UILabel){
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
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
