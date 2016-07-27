//
//  MessageViewTableViewCell.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/7/25.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class MessageViewTableViewCell: UITableViewCell {

    var icon:RootImageView?
    var back_image:UIImageView?
    var info:UILabel?
    var cellheight:CGFloat?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        icon = RootImageView.newAutoLayoutView()
        self.addSubview(icon!)
        
        back_image = UIImageView.newAutoLayoutView()
        self.addSubview(back_image!)
        
        info = UILabel.newAutoLayoutView()
        info!.font = fontSize(12)
        info!.textAlignment = .Left
        info!.numberOfLines = 0
        back_image!.addSubview(info!)
        
        icon!.autoSetDimensionsToSize(CGSizeMake(40, 40))
    }
    
    func transmit(model: ReviewModel){
        
        info!.text = model.review_info
        
        let info_size = info!.text!.boundingRectWithSize(CGSizeMake(KScreenWidth-120, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:info!.font], context: nil).size
        
        let size = info!.sizeThatFits(CGSizeMake(KScreenWidth-120, CGFloat(FLT_MAX)))
        var label_num = size.height/fontSize(12).lineHeight
        
        if label_num > CGFloat(Int(label_num)){
            label_num += 1
        }
        
        icon!.autoPinEdgeToSuperviewEdge(.Top, withInset: 0)
        
        var back_height = KScreenWidth-100
        if size.height < 30{
            back_height = size.width+10
        }
        
        back_image!.autoSetDimensionsToSize(CGSizeMake(back_height, info_size.height+5*label_num))
        back_image!.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
        back_image!.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 5)
        
        info!.autoSetDimensionsToSize(CGSizeMake(KScreenWidth-120, info_size.height+5*label_num))
        info!.autoPinEdgeToSuperviewEdge(.Top, withInset: 2.5)
        info!.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 2.5)
        
        let num = Int(model.review_number)
        if num == 0{
            icon!.image = UIImage(named: model.user_icon)
            back_image!.image = UIImage(named: "message_my_send")
            
            icon!.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
            back_image!.autoPinEdgeToSuperviewEdge(.Right, withInset: 55)
            
            info!.textColor = MyThemeColor
            info!.textAlignment = .Right
            
            info!.autoPinEdgeToSuperviewEdge(.Left, withInset: 2.5)
            info!.autoPinEdgeToSuperviewEdge(.Right, withInset: 7.5)
            
        }else{
            icon!.image = UIImage(named: model.to_icon)
            back_image!.image = UIImage(named: "message_to_send")
            
            icon!.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            back_image!.autoPinEdgeToSuperviewEdge(.Left, withInset: 55)
            
            info!.textColor = UIColor.whiteColor()
            info!.textAlignment = .Right
            
            info!.autoPinEdgeToSuperviewEdge(.Left, withInset: 7.5)
            info!.autoPinEdgeToSuperviewEdge(.Right, withInset: 2.5)
        }

        cellheight = info_size.height+5*label_num+10
        
        adjustWithLabelSpacing(info!.text!, label: info!)
    }
    
    func returncellheight() -> CGFloat{
        if cellheight < 50{
            cellheight = 50
        }
        return cellheight!
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
