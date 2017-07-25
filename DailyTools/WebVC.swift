//
//  WebVC.swift
//  DailyTools
//
//  Created by 林喜 on 7/21/17.
//  Copyright © 2017 ShowLin. All rights reserved.
//

import UIKit
import WebKit
class WebVC: UIViewController,WKUIDelegate, WKNavigationDelegate{
    
   public var  vcTitle:String? = ""

    // webview
    lazy var webView : WKWebView = {
        var rect:CGRect = self.view.frame
        var webView:WKWebView = WKWebView.init(frame:rect)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com/")!))

        webView.addObserver(self , forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        
         return webView
    }()
    
    lazy var progressView:UIProgressView = {
        var progressView:UIProgressView = UIProgressView.init(frame: CGRect(x:0, y:65 ,width:UIScreen.main.bounds.width, height: 2))
        progressView.tintColor = UIColor.green
        progressView.trackTintColor = UIColor.white
        return progressView
        
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = vcTitle
        self.view.addSubview(webView)
        self.view.addSubview(progressView)

    
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //MARK:添加控制观察webview的加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animateKeyframes(withDuration: 0.3, delay: 0.1, options: .beginFromCurrentState, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
