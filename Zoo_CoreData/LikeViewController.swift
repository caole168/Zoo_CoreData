//
//  LikeViewController.swift
//  Zoo_CoreData
//
//  Created by Ifeng on 15/11/6.
//  Copyright © 2015年 pincher. All rights reserved.
//

import UIKit

class LikeViewController: UITableViewController {
    
    
    var plistData:NSString = ""
    var data:NSMutableDictionary = NSMutableDictionary()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.registerClass(LikeTableViewCell.self, forCellReuseIdentifier: "likeCell")
        
        self.navigationItem.title = "我的收藏"
        
        //  -----------读取plist文件----------------
        plistData = NSBundle.mainBundle().pathForResource("SyPlist", ofType: "plist")!
        data = NSMutableDictionary(contentsOfFile: plistData as String)!
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        // Default is 1 if not implemented
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return data.count
        
    }
    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20;
//    }
//    
    
//    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
//        return 0;
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        tableView.rowHeight = 99
        
        let id : String = "likeCell"
        //let tableCell : LikeTableViewCell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath) as! LikeTableViewCell
        
        let tableCell : LikeTableViewCell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath) as! LikeTableViewCell
        
//        let c = UILabel()
//        c.frame = CGRectMake(10, 10, 100, 100)
//        c.text = "zenmechubulai"
//        
//        tableView.addSubview(c)
  
        
        let dataRow = indexPath.row + 1 //数组元素从1开始的，所以+1 ，indexPath默认为0
        let dataGroup = data["\(dataRow)"] as! NSDictionary
        print(dataGroup)

//        let ImageUrl = dataGroup["image"] as! NSString
        
        //赋值
//        tableCell.syContentImage.image = UIImage(named:"\(ImageUrl)")
//        tableCell.syContentTitle.text = dataGroup["title"] as? String
//        tableCell.syContentTime.text = dataGroup["time"] as? String
//        tableCell.syContentSource.text = dataGroup["source"] as? String


        
   
        
        
        return tableCell
        
    }
    
    
    // 支持单元格编辑功能
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
        
    }

    
    
  
    }