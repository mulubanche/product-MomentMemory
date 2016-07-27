//
//  ShowImageView.swift
//  MomentMemory
//
//  Created by 班车陌路 on 16/6/24.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit
import MJPhotoBrowser

class ShowImageView: UIView, UIGestureRecognizerDelegate {
    
    var backView:MyView!
    var showImg:UIImageView!
    var imgSize:CGSize?
    
    var scrollview:UIScrollView!
    var DoubleClick: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    func transmitShowImg(dict: NSDictionary){
        let img = UIImage(named: dict.objectForKey("imgUrl") as! String)
        let brower = MJPhotoBrowser()
        let photo = MJPhoto()
        photo.image = img
        brower.photos = [photo]
        brower.currentPhotoIndex = 0
        brower.show()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.removeFromSuperview()
    }
    
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
