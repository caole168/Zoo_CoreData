//
//  SettingViewController.swift
//  Zoo_CoreData
//
//  Created by Ifeng on 15/11/5.
//  Copyright © 2015年 pincher. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{


    var plistData:NSString = ""
    var data:NSMutableDictionary = NSMutableDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //  -----------读取plist文件----------------
        plistData = NSBundle.mainBundle().pathForResource("setting", ofType: "plist")!
        data = NSMutableDictionary(contentsOfFile: plistData as String)!

      

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    // Default is 1 if not implemented
         return 1
    
    }
    
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return data.count
       
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20;
    }
    
     func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let tableCell : SettingCell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath) as! SettingCell
        
        
        
        tableView.rowHeight = 80
        
        
        let dataRow = indexPath.row + 1 //数组元素从1开始的，所以+1 ，indexPath默认为0
        let dataGroup = data["\(dataRow)"] as! NSDictionary
        let ImageUrl = dataGroup["image"] as! NSString
        
        
        tableCell.settingTitle.text = dataGroup["title"] as? String
        tableCell.settingImage.image = UIImage(named:"\(ImageUrl)")

        
        //加载数据
      
        
 //       let ImageUrl = dataGroup["image"] as? NSString

        
  //      tableCell.settingTitle.text = data["title"] as? String
  //      tableCell.settingImage.image = UIImage(named:"\(ImageUrl)")

        
        

        
        return tableCell
        
    }
    
    
    
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
       
  //      let dataGroup = data["\(dataRow)"] as! NSDictionary
        
//        tableView .deselectRowAtIndexPath(indexPath, animated: true)
//        
//        // let goDetailContent = DetailViewController()
//        
//        // goDetailContent.ReceiveUrl = SendUrl
//        // goDetailContent.PageTitle = SendTitle
//        //  print(goDetailContent.ReceiveUrl)
//        //  print(goDetailContent.PageTitle)
//        self.performSegueWithIdentifier("goDetailContentSegue", sender: indexPath)
        

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