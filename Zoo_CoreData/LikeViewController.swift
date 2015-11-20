//
//  LikeViewController.swift
//  Zoo_CoreData
//
//  Created by Ifeng on 15/11/6.
//  Copyright © 2015年 pincher. All rights reserved.
//

import UIKit
import CoreData

class LikeViewController: UITableViewController,NSFetchedResultsControllerDelegate{
    
    
    
    //获取管理的数据上下文 对象
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate //获取appdel
    var dataArray:Array<AnyObject> = []
    var dataArrayReverse:Array<AnyObject> = []  //倒叙输出
    var context:NSManagedObjectContext!

    //屏幕尺寸
    let Screen = UIScreen.mainScreen().bounds

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        
        refreshData()

        tableView.registerClass(LikeTableViewCell.self, forCellReuseIdentifier: "likeCell")
        self.navigationItem.title = "我的收藏"

        if dataArray.count == 0{
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
        let noSign = UILabel()
            noSign.text = "您还没有收藏文章"
            noSign.frame = CGRectMake(Screen.width/3, Screen.height/3, 260, 100)
            print(noSign.frame)
            noSign.font = UIFont(name: "", size: 18)
            noSign.textColor = UIColor.grayColor()
            self.view.addSubview(noSign)
            
        }
        
    }
        
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        TalkingData.trackPageBegin("ShouCang")
    }
    

    override func viewWillDisappear(animated: Bool) {
        TalkingData.trackPageEnd("ShouCang")
        
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
    
        return dataArray.count

        
    }


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        tableView.rowHeight = 100
    
        let tableCell : LikeTableViewCell = tableView.dequeueReusableCellWithIdentifier("likeCell", forIndexPath: indexPath) as! LikeTableViewCell
        
        let ImageUrl = dataArrayReverse[indexPath.row].valueForKey("image") as! NSString

        tableCell.syContentImage.image = UIImage(named: "\(ImageUrl)")
        
        tableCell.syContentTitle.text = dataArrayReverse[indexPath.row].valueForKey("title") as? String
        tableCell.syContentSource.text = dataArrayReverse[indexPath.row].valueForKey("source") as? String
        
        tableCell.syContentTime.text = dataArrayReverse[indexPath.row].valueForKey("time") as? String

      
        
        return tableCell
        
    }
    
    
    // 支持单元格编辑功能
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // 删除数据
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if editingStyle == .Delete{
            context.deleteObject(dataArray[indexPath.row] as! NSManagedObject )
            appDel.saveContext()

            refreshData()
        }
        
    }

    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        
        
    }
    
    //刷新列表数据
    func refreshData() {
        
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Entity")
        
        do{
            dataArray = try context.executeFetchRequest(fetchRequest)
            dataArrayReverse = dataArray.reverse()  //翻转数组
            
        }catch{
            print("error")
        }
        
        tableView.reloadData()
        
    }
    
   
    
    
    

    
    
  
    }