//
//  WebViewController.swift
//  MomentMemory
//
//  Created by 研发部ios专用 on 16/6/27.
//  Copyright © 2016年 molubanche. All rights reserved.
//

import UIKit

class WebViewController: RootViewController, UIWebViewDelegate {

    var webview:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        webview = UIWebView.newAutoLayoutView()
        webview.delegate = self
        webview.backgroundColor = UIColor.whiteColor()
        webview.scrollView.bounces = false
        self.view.addSubview(webview)

        let filePath = NSBundle.mainBundle().pathForResource("test", ofType: "html")
        
        do {
            let html = try String.init(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding)
            webview.loadHTMLString(html, baseURL: NSURL(string: filePath!))
        }catch{
            print("网页加载错误")
        }
        
        webview.autoSetDimensionsToSize(CGSizeMake(10, 10))
        webview.autoPinEdgeToSuperviewEdge(.Top, withInset: 64)
        webview.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
        webview.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        webview.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let js = ObjectFile().addwebHtmlJS(KScreenWidth-20)
        webView.stringByEvaluatingJavaScriptFromString(js)
        webView.stringByEvaluatingJavaScriptFromString("ResizeImages();")
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
