//
//  DetailViewController.swift
//  Zoo
//
//  Created by caole on 15/9/4.
//  Copyright (c) 2015年 pincher. All rights reserved.
//

import UIKit
import CoreData



class DetailViewController: UIViewController,UIWebViewDelegate {

    
    var receiveUrl:NSString!
    var receiveTitle:NSString!
    var receiveImage:NSString!
    var receiveSource:NSString!
    
    var loadUrl:NSString!
    var pageTitle:NSString!
    let screen = UIScreen.mainScreen().bounds
    var loadImage = UIActivityIndicatorView()
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate //获取appdel
 //   let coredataHelper = CoreDataHelper()
    
    @IBOutlet weak var WebView: UIWebView!
    
    @IBAction func sharButton(sender: AnyObject) {
        
        let ShareController = UIAlertController(title: "分享到", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let ShareToWxAction = UIAlertAction(title: "微信好友", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            sendText(0 , ShareTitle:self.receiveTitle , ShareUrl:self.receiveUrl)
        }
        
        let ShareToConmentsAction = UIAlertAction(title: "微信朋友圈", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            sendText(1 , ShareTitle:self.receiveTitle , ShareUrl:self.receiveUrl)
        }
        
        let copyToPasteBoard = UIAlertAction(title: "复制连接", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            let pasteBoard = UIPasteboard.generalPasteboard()
            pasteBoard.string = self.receiveUrl as String!//复制到剪切板
        }
        
        
        ShareController.addAction(ShareToWxAction)
        ShareController.addAction(ShareToConmentsAction)
        ShareController.addAction(cancelAction)
        ShareController.addAction(copyToPasteBoard)
        
        presentViewController(ShareController, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func likeButton(sender: AnyObject) {
        
        let context = appDel.managedObjectContext
        let like = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: context) as! Entity
        
//        like.title = receiveTitle as String!
//        like.image = receiveImage as String!
//        like.url = receiveUrl as String!
//        like.source = receiveSource as String!
        
        like.title = "aaaaa"
        like.image = "bbbbb"
        like.url = "cccccc"
        like.source = "dddddd"
        appDel.saveContext()
        
        
    }
    
    
  

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
  //      self.navigationItem.title = "\(ReceiveTitle)"
   

        let ScreenWidth = screen.width
        let ScreenHeight = screen.height
        
        

        
        loadUrl = receiveUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        WebView.frame = CGRectMake(0, 20, ScreenWidth, ScreenHeight)
        WebView.reload()
        WebView.reloadInputViews()
        WebView.loadRequest(NSURLRequest(URL:NSURL(string: "http://\(loadUrl)")! ) )
        WebView.delegate = self
  
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    func webViewDidStartLoad(webView: UIWebView){
        print("_____________________")
        let Screen = UIScreen.mainScreen().bounds
        let ScreenWidth = Screen.width
        let ScreenHeight = Screen.height
    
        

        loadImage.frame = CGRectMake(ScreenWidth/2.3, ScreenHeight/2, 50, 50)
        loadImage.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(loadImage)
        loadImage.startAnimating()
        
        //webview开始加载
    
    }
    func webViewDidFinishLoad(webView: UIWebView){
        
        loadImage.stopAnimating()
        loadImage.hidesWhenStopped = true
        
        //webview结束加载
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
        
    }

    
//    
//    @IBAction func ShareWeChat(sender: AnyObject) {
//        let app = UIApplication.sharedApplication().delegate as! AppDelegate
//        app.sendText()
//
//        
//    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
