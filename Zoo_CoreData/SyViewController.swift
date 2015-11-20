//
//  ViewController.swift
//  Zoo
//
//  Created by Ifeng on 15/9/3.
//  Copyright (c) 2015年 pincher. All rights reserved.
//


import UIKit

//class SyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

class SyViewController: UITableViewController{
    

    
    var plistData:NSString = ""
    var data:NSMutableDictionary = NSMutableDictionary()
    
    //传值
    var sendUrl:NSString!
    var sendTitle:NSString!
    var sendImage:NSString!
    var sendSource:NSString!
    
    
    //下拉刷新空间
    let pullRefreshControl = UIRefreshControl()
    //var plist
    

   

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(named: "")
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        
        
        let navTitle = UILabel()
        navTitle.frame = CGRectMake(100, 00, 100, 44)
        navTitle.textColor = UIColor(red: 224/250, green: 58/250, blue: 44/250, alpha: 1.0)
        navTitle.font = UIFont(name: "GurmukhiMN-Bold", size: 23)
        navTitle.text = "Zoo"
        navTitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = navTitle

        
        // Do any additional setup after loading the view, typically from a nib.
        
        //  -----------读取plist文件----------------
        plistData = NSBundle.mainBundle().pathForResource("SyPlist", ofType: "plist")!
        data = NSMutableDictionary(contentsOfFile: plistData as String)!
    
        
        // 初始下拉刷新控件
       
        self.refreshControl = UIRefreshControl()
        pullRefreshControl.attributedTitle = NSAttributedString(string: "释放加载新内容")
        pullRefreshControl.tintColor = UIColor.greenColor()
        pullRefreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        TalkingData.trackPageBegin("ShouYe")
    }

    override func viewWillDisappear(animated: Bool) {
        TalkingData.trackPageEnd("ShouYe")
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return data.count
        
    }
    
    
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let tableCell : SyTableViewCell = tableView.dequeueReusableCellWithIdentifier("SyCell", forIndexPath: indexPath) as! SyTableViewCell
   
        
        tableView.rowHeight = 99
        
    //    tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //加载数据
        let dataRow = indexPath.row + 1 //数组元素从1开始的，所以+1 ，indexPath默认为0
        let dataGroup = data["\(dataRow)"] as! NSDictionary
        let ImageUrl = dataGroup["image"] as! NSString
     
        
        //赋值
        tableCell.syContentImage.image = UIImage(named:"\(ImageUrl)")
        tableCell.syContentTitle.text = dataGroup["title"] as? String
        tableCell.syContentTime.text = dataGroup["time"] as? String
        tableCell.syContentSource.text = dataGroup["source"] as? String

        return tableCell
        
    }
    
    
 
    
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
    
        
        let dataRow = indexPath.row + 1
        let dataGroup = data["\(dataRow)"] as! NSDictionary
        
        sendUrl = dataGroup["url"] as! NSString
        sendTitle = dataGroup["title"] as! NSString
        sendImage = dataGroup["image"] as! NSString
        sendSource = dataGroup["source"] as! NSString
        
        tableView .deselectRowAtIndexPath(indexPath, animated: true)

        self.performSegueWithIdentifier("goDetailContentSegue", sender: indexPath)

        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
             //segue 传值
        
                if segue.identifier == "goDetailContentSegue"{
                    
                    let goDetailContent = segue.destinationViewController as! DetailViewController
                   
                    goDetailContent.receiveUrl = sendUrl
                    goDetailContent.receiveTitle = sendTitle
                    goDetailContent.receiveImage = sendImage
                    goDetailContent.receiveSource = sendSource

                }
    
    }
    

    //下拉刷新
    func refresh() {
        
            if self.pullRefreshControl.refreshing == true {
    
            self.pullRefreshControl.attributedTitle = NSAttributedString(string: "Loading...")
                     }
        
            dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            
         //   self._dataSource.insert("\(self._dataSource[0].toInt()! - 1)", atIndex: 0)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                                 sleep(1)
            
            self.pullRefreshControl.endRefreshing()
            
            self.pullRefreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
                
            self.tableView.reloadData()
                
                
                })
                     })
             }
    
    
    
    
}

