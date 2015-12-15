//
//  ViewController.swift
//  Zoo
//
//  Created by Ifeng on 15/9/3.
//  Copyright (c) 2015年 pincher. All rights reserved.
//


import UIKit

class SyViewController: UITableViewController{
    
    //传值
    var sendUrl:NSString?
    var sendTitle:NSString?
    var sendImage:String?
    var sendSource:NSString?
    //屏幕尺寸
    let Screen = UIScreen.mainScreen().bounds
    

    
    
    //下拉刷新控件
    let pullRefreshControl = UIRefreshControl()
    var juhua = UIActivityIndicatorView()
    
    let loadMoreBtn = UIButton()//上拉加载更多按钮
    var loadMoreState = true

    
    //var plist
    var data : Array< AnyObject > = Array()
    var dataNextPage : Array<AnyObject > = Array()
    
    //加载后续数据
    var pageNumber = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(named: "")
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        
        
        let navTitle = UILabel()
        navTitle.frame = CGRectMake(100, 00, 100, 44)
        navTitle.textColor = UIColor(red: 224/250, green: 58/250, blue: 44/250, alpha: 1.0)
        navTitle.font = UIFont(name: "GurmukhiMN-Bold", size: 19)
        navTitle.text = "banana"
        navTitle.textAlignment = NSTextAlignment.Center
        self.navigationItem.titleView = navTitle

        
        // Do any additional setup after loading the view, typically from a nib.
        
    
      
        
        // 初始下拉刷新控件
        pullRefreshControl.attributedTitle = NSAttributedString(string: "下拉加载新内容")
        pullRefreshControl.tintColor = UIColor.grayColor()
        pullRefreshControl.addTarget(self, action: "pullRefresh", forControlEvents: .ValueChanged)
        self.tableView.addSubview(pullRefreshControl)
        
        
        //初始上拉加载更多
        let tableFooterView:UIView = UIView()
        tableFooterView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 36)
//        tableFooterView.backgroundColor = UIColor.greenColor()
        self.tableView.tableFooterView = tableFooterView
        
        
        
    
        // 加载更多的按扭
        loadMoreBtn.frame = CGRectMake(0, 0, self.view.bounds.width, 36)
        loadMoreBtn.setTitle("上拉加载更多", forState: .Normal)
        loadMoreBtn.titleLabel?.font = UIFont(name: "GurmukhiMN", size: 12)
//       loadMoreBtn.backgroundColor = UIColor.lightGrayColor()
        loadMoreBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        loadMoreBtn.addTarget(self, action: "loadMore", forControlEvents: .TouchUpInside)
        tableFooterView.addSubview(loadMoreBtn)
        
        // 加载更多 状态 风火轮
        juhua = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        juhua.center = loadMoreBtn.center
        tableFooterView.addSubview(juhua)

        
        
        getHttp()
        

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
        
        return  data.count
        
    }
    
    
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let tableCell : SyTableViewCell = tableView.dequeueReusableCellWithIdentifier("SyCell", forIndexPath: indexPath) as! SyTableViewCell
        
  //      tableCell.backgroundColor = UIColor.yellowColor()
   
        
        tableView.rowHeight = 102
              
    //    tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //加载数据
//        let dataGroup = data["\(dataRow)"] as! NSDictionary
        
        let dataGroup = data[indexPath.row] as! NSDictionary
        
        
        let imageUrl = dataGroup["imageUrl"] as! String
        
        let time = dataGroup["time"] as? NSString
        let timeNew = time?.substringFromIndex(11)
        
        tableCell.syContentTitle.text = dataGroup["title"] as? String
        tableCell.syContentTime.text  = timeNew
        tableCell.syContentSource.text = dataGroup["source"] as? String
        
        tableCell.syContentImage.sd_setImageWithURL(NSURL(string: "\(imageUrl)" ))
        
//
//        print("_______________________________________")
//        print(self.tableView.contentOffset)
//
//        print(self.tableView.contentSize)
        
        let frameDistance = self.tableView.contentSize.height - self.tableView.contentOffset.y

        let pullUpDistance = self.tableView.frame.height - frameDistance
        
//        print(pullUpDistance)
        
        //当页面华东到底部时且下个页面有数据自动加载
        if pullUpDistance > 45 && loadMoreState == true {
            loadMore()
            
        }
            
        return tableCell
        
    }
    
    
 
    
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
    
        
        let dataRow = indexPath.row
        let dataGroup = data[dataRow] as! NSDictionary
        
        sendUrl = dataGroup["url"] as? NSString
        sendTitle = dataGroup["title"] as? NSString
        
        sendImage = dataGroup["imageUrl"] as? String
            
        sendSource = dataGroup["source"] as? NSString
    
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

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
    func pullRefresh() {
       
            if self.pullRefreshControl.refreshing == true {
    
            self.pullRefreshControl.attributedTitle = NSAttributedString(string: "正在加载...")
                     }
        
            dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
                 self.getHttp()
            
          
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                                 sleep(0)
            
            self.pullRefreshControl.endRefreshing()
            self.tableView.reloadData()
                
                self.loadMoreState = true
                
                
                })
                     })
        
        
        
             }
    
    //上拉加载更多
    func loadMore() {
        
            loadMoreBtn.hidden = true
            juhua.startAnimating()
        
        
        let url = NSURL(string: "http://121.42.213.89/app/index.php/Home/Admin/api?page=\(pageNumber)")
        
    
        
        let jsonData = NSData(contentsOfURL: url!)
    
        do {
            dataNextPage = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:NSJSONReadingOptions.MutableContainers) as!  Array<AnyObject>
        }catch{
            print("error")
        }
        

        if dataNextPage.count == 0{        //如果下页没有数据时
            

            loadMoreBtn.setTitle("已无更多数据", forState: .Normal)
            loadMoreBtn.hidden = false
            self.juhua.stopAnimating()
            loadMoreState = false
            print("第\(pageNumber)没有数据")
            
        }else{                              //如果下页有数据时
            dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
         
                //for循环往列表数组追加数据
                for index in 1...self.dataNextPage.count{
                    self.data.append(self.dataNextPage[index-1])
                }
                
           
                
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
    
                                sleep(1)
    
                                self.juhua.stopAnimating()
                
                                self.loadMoreBtn.hidden = false
                
                                self.tableView.reloadData()
                                self.dataNextPage.removeAll()
                
                            })
                    })
            
            pageNumber++    //翻页+1
            
        }
        
        
        
                    }

    
    
    //请求网络数据
    func getHttp() {
        
        let url = NSURL(string: "http://121.42.213.89/app/index.php/Home/Admin/api?page=1")
        let jsonData = NSData(contentsOfURL: url!)
        
        
        do {
            data = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:NSJSONReadingOptions.MutableContainers) as!  Array<AnyObject>
        }catch{
            print("取出数据失败")
        }

        
    }
    
    
    
    
}