//
//  LeftMeunTableViewCell.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/22.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class LeftMeunTableViewCell: UITableViewCell {

    var cellImageView:UIImageView!
    var cellTitle:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellImageView = UIImageView.newAutoLayoutView()
        self.addSubview(cellImageView)
        
        cellTitle = UILabel.newAutoLayoutView()
        cellTitle.font = fontBoldSize(14)
        cellTitle.textColor = UIColor.whiteColor()
        cellTitle.textAlignment = .Left
        self.addSubview(cellTitle)

        cellImageView.autoSetDimensionsToSize(CGSizeMake(20, 20))
        cellImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        cellImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
        cellImageView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
        
        cellTitle.autoSetDimensionsToSize(CGSizeMake(100, 20))
        cellTitle.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
        cellTitle.autoPinEdge(.Left, toEdge: .Right, ofView: cellImageView, withOffset: 10)
        
        let line = UIView.newAutoLayoutView()
        line.backgroundColor = UIColor.whiteColor()
        self.addSubview(line)
        
        line.autoSetDimensionsToSize(CGSizeMake(10, 1))
        line.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        line.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        line.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 1)
    }
    
    func transmitData(dict: NSDictionary){
        cellImageView.image = UIImage(named: dict.objectForKey("icon") as! String)
        cellTitle.text = dict.objectForKey("title") as! String
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
