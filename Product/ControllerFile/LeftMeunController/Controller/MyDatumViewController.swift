//
//  MyDatumViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/22.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit
import RBBAnimation

class MyDatumViewController: RootViewController {

    
    var imageview:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.title = "我的资料"
        
        
        imageview = UIImageView.newAutoLayoutView()
        imageview.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(imageview)
        
        imageview.autoSetDimensionsToSize(CGSizeMake(50, 50))
        imageview.autoPinEdgeToSuperviewEdge(.Top, withInset: 100)
        imageview.autoPinEdgeToSuperviewEdge(.Left, withInset: 100)
    }
    
    //移动
    func positionAnination(){
        let postion = CABasicAnimation(keyPath: "position")
        postion.fromValue = NSValue(CGPoint: CGPointMake(25, 96))
        postion.toValue = NSValue(CGPoint: CGPointMake(220, 440))
        postion.duration = 1
        //保持移动后的位置
        postion.fillMode = kCAFillModeForwards
        //不移除动画
        postion.removedOnCompletion = false
        //按原路径返回
        postion.autoreverses = true
        imageview.layer.addAnimation(postion, forKey: nil)//Key用来指向删除该动画,对应方法imageview.layer.removeAnimationForKey("")
    }
    
    //旋转
    func transformAnination(){
        let transtion = CABasicAnimation(keyPath: "transform.rotation.z")//x,y,z坐标
        //起始点,不设置就默认当前位置
        transtion.toValue = M_PI_4
        transtion.duration = 1
        transtion.fillMode = kCAFillModeForwards
        transtion.removedOnCompletion = false
        //重复次数
        transtion.repeatCount = MAXFLOAT
        //是否累积当前位置
        transtion.cumulative = true
        imageview.layer.addAnimation(transtion, forKey: nil)
        
    }
    
    //缩放
    func scaleAnination(){
        let scaletion = CABasicAnimation(keyPath: "transform.scale")
        scaletion.fromValue = 1//原始大小
        scaletion.toValue = 0.5//缩放之后大小
        scaletion.duration = 1
        scaletion.autoreverses = true
        //速度设置(模拟心跳)
        scaletion.repeatCount = MAXFLOAT
        //设置动画方式(先快后慢等)
        scaletion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        imageview.layer.addAnimation(scaletion, forKey: nil)
    }
    
    //路线集合
    func keyformPostion(){
        let postion = CAKeyframeAnimation(keyPath: "position")
        let value1 = NSValue(CGPoint: CGPointMake(25, 96))
        let value2 = NSValue(CGPoint: CGPointMake(100, 200))
        let value3 = NSValue(CGPoint: CGPointMake(60, 320))
        let value4 = NSValue(CGPoint: CGPointMake(200, 200))
        let value5 = NSValue(CGPoint: CGPointMake(25, 96))
        postion.values = [value1, value2, value3, value4, value5]
        postion.duration = 1
        postion.fillMode = kCAFillModeForwards
        postion.removedOnCompletion = false
        
        imageview.layer.addAnimation(postion, forKey: nil)
    }
    
    //旋转
    func keyTransFormAnination(){
        let postion = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        //向左旋转
        let leftAngle = M_PI/180*10
        //向右旋转
        let rightAngle = M_PI/180*(-10)
        
        postion.values = [leftAngle, rightAngle, leftAngle]
        postion.duration = 1
        postion.repeatCount = MAXFLOAT
        imageview.layer.addAnimation(postion, forKey: nil)
    }
    
    //渐变动画
    func transform(){
        imageview.image = UIImage(named: "user_icon3")
        
        let trans = CATransition()
        trans.type = kCATransitionMoveIn
        trans.subtype = kCATransitionFromBottom
        trans.duration = 1
        
        imageview.layer.addAnimation(trans, forKey: nil)
    }
    
    //组合动画
    func groupAnination(){
//        let group = 
        let transform = CABasicAnimation(keyPath: "transform.rotation.z")
        transform.toValue = M_PI
        transform.cumulative = true
        transform.repeatCount = MAXFLOAT
//        transform.removedOnCompletion = false
        
        let scaletion = CABasicAnimation(keyPath: "transform.scale")
        scaletion.toValue = 0.5
        scaletion.autoreverses = true
        scaletion.repeatCount = MAXFLOAT
//        scaletion.removedOnCompletion = false
//        scaletion.fillMode = kCAFillModeForwards
        
        let postion = CAKeyframeAnimation(keyPath: "position")
        let ref = CGPathCreateMutable()
        CGPathMoveToPoint(ref, nil, 0, 0)
        CGPathAddLineToPoint(ref, nil, 99, 99)
        CGPathAddLineToPoint(ref, nil, 111, 444)
        CGPathAddLineToPoint(ref, nil, 9, 99)
        CGPathAddLineToPoint(ref, nil, 233, 80)
        postion.path = ref
        
        let group = CAAnimationGroup()
        group.animations = [transform, scaletion, postion]
        group.duration = 1
        group.fillMode = kCAFillModeForwards
        group.removedOnCompletion = false
        imageview.layer.addAnimation(group, forKey: nil)
        
    }
    
    //RBB动画组
    func rbbAnimationTween(){
        let animation = RBBTweenAnimation()
        animation.keyPath = "position.y"
        animation.fromValue = 50
        animation.toValue = 150
        animation.duration = 1
        animation.easing = RBBEasingFunctionEaseOutBounce
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        imageview.layer.addAnimation(animation, forKey: nil)
    }
    
    
    override func backClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//        positionAnination()
        
//        transformAnination()
        
//        scaleAnination()
        
//        keyformPostion()
        
//        keyTransFormAnination()
        
//        transform()
        
//        groupAnination()
        
        rbbAnimationTween()
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
