//
//  RightViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/22.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class RightViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let img = UIImageView.newAutoLayoutView()
        img.image = UIImage(named: "meunbackimage.jpg")
        img.contentMode = .ScaleAspectFill
        self.view.addSubview(img)
        img.autoSetDimensionsToSize(CGSizeMake(10, 20))
        img.autoPinEdgeToSuperviewEdge(.Top, withInset: 0)
        img.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        img.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        img.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
        
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
