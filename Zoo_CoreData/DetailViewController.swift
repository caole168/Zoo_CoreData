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

//首页传值
    var receiveUrl:NSString!
    var receiveTitle:NSString!
    var receiveImage:String!
    var receiveSource:NSString!
    var likeButtonTag:NSInteger?
    
    var loadUrl:NSString!
    var pageTitle:NSString!
    let screen = UIScreen.mainScreen().bounds
    var loadImage = UIActivityIndicatorView()
    
    //获取管理的数据上下文 对象
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate //获取appdel
    var dataArray:Array<AnyObject> = []
    var context:NSManagedObjectContext!

    
    @IBOutlet weak var WebView: UIWebView!
    @IBOutlet weak var likeButton: UIButton!
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   self.view.backgroundColor = UIColor.whiteColor()
        
        
//      浏览器加载页面
        loadUrl = receiveUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        var httpUrl:String?
        
        if loadUrl.length >= 4{
            httpUrl = loadUrl.substringToIndex(4)
            
        }else{
            httpUrl = loadUrl as String
        }
     
        WebView.reload()
        WebView.reloadInputViews()
        
        if httpUrl == "http"{
        WebView.loadRequest(NSURLRequest(URL:NSURL(string: "\(loadUrl)")! ) )
        
        }else{
            WebView.loadRequest(NSURLRequest(URL:NSURL(string: "http://"+"\(loadUrl)")! ) )
                    }
         WebView.delegate = self

        
//      查询收藏数据库中有没有收藏过该条内容，收藏过显示like_fill
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Entity")
        let predicate = NSPredicate(format: "title= '\(receiveTitle)' ", "")
        fetchRequest.predicate = predicate
        
        do{
            dataArray = try context.executeFetchRequest(fetchRequest)
            
        }catch{
            print("error")
        }
        
        if dataArray.count != 0{
            likeButton.setImage(UIImage(named: "like_fill"), forState: UIControlState.Normal)
        }else{
             likeButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
        }
       
        
        if likeButtonTag == 1{
             likeButton.hidden = true
            //如果是从收藏进来的，则无收藏按钮
        }
        
  
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        TalkingData.trackPageBegin("XiangQing")
    }
    
    override func viewWillDisappear(animated: Bool) {
        TalkingData.trackPageEnd("XiangQing")
        
    }
    

    func webViewDidStartLoad(webView: UIWebView){
        //    print("_____________________")
        let Screen = UIScreen.mainScreen().bounds
        let ScreenWidth = Screen.width
        let ScreenHeight = Screen.height
        
        
        
        loadImage.frame = CGRectMake(ScreenWidth/2.3, ScreenHeight/2.4, 50, 50)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    //分享按钮action
    @IBAction func shareButton(sender: AnyObject) {
        
        print("kolk")
        let shareImageData:NSData = NSData(contentsOfURL:NSURL(string: receiveImage)! )!
    
        
        let ShareController = UIAlertController(title: "分享到", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let ShareToWxAction = UIAlertAction(title: "微信好友", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            sendText(0 , shareTitle:self.receiveTitle , shareUrl:self.receiveUrl , shareImage: shareImageData)
        }
        
        let ShareToConmentsAction = UIAlertAction(title: "微信朋友圈", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            sendText(1 , shareTitle:self.receiveTitle , shareUrl:self.receiveUrl , shareImage: shareImageData)
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
    
    
    //收藏按钮action
    @IBAction func likeButton(sender: AnyObject) {
        
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Entity")
        let predicate = NSPredicate(format: "title= '\(receiveTitle)' ", "")
        fetchRequest.predicate = predicate
        
        
        do{
            dataArray = try context.executeFetchRequest(fetchRequest)
            
            
        }catch{
            print("error")
        }
        
        
        
        if dataArray.count == 0{
        
            let like = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: context) as! Entity
            like.title = receiveTitle as String
            like.image = receiveImage as String
            like.url = receiveUrl as String
            like.source = receiveSource as String
            appDel.saveContext()
            //插入数据
            
            likeButton.setImage(UIImage(named: "like_fill"), forState: UIControlState.Normal)
            
        } else{

            for info:Entity in dataArray as! [Entity]{
            context.deleteObject(info)
            }
            appDel.saveContext()
            likeButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            
        }
        
        
        
    }

    
    

}
