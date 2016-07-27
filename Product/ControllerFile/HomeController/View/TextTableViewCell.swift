//
//  TextTableViewCell.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/20.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class TextTableViewCell: HomeTableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        detailelabel = UILabel.newAutoLayoutView()
        detailelabel!.font = fontSize(14)
        detailelabel!.textColor = MyColorGray
        detailelabel!.textAlignment = .Left
        detailelabel!.numberOfLines = 0
        self.addSubview(detailelabel!)
        
    }
    
    func textDetail(text: String){
        let height = text.boundingRectWithSize(CGSizeMake(KScreenWidth, 2000), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:detailelabel!.font], context: nil).size.height
        
        detailelabel!.text = text
        
        adjustWithLabelSpacing(detailelabel!.text!, label: detailelabel!)
        let size = detailelabel!.sizeThatFits(CGSizeMake(KScreenWidth-40, 4000))
        let num = size.height/detailelabel!.font.lineHeight
        cellHeight = 70+height+5*num
        
        backview.frame.size.height = cellHeight-8
        
        detailelabel!.autoSetDimensionsToSize(CGSizeMake(10, height+10+5*num))
        detailelabel!.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        detailelabel!.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        detailelabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: messageView, withOffset: 0)
    }
    
    override func returnCellHeight() -> CGFloat{
        return cellHeight
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
