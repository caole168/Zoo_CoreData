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
        
        
        
//        //去掉返回按钮文字
//        let backButton = UIBarButtonItem()
//        backButton.image = UIImage(named: "back")
//        backButton.title = ""
//        backButton.tintColor = UIColor.blackColor()
//        self.navigationController?.navigationBar.tintColor = UIColor(red: 74/255, green: 64/255, blue: 66/255, alpha: 1.0)
//        self.navigationItem.backBarButtonItem = backButton
//        
        
        //  -----------读取plist文件----------------
        plistData = NSBundle.mainBundle().pathForResource("setting", ofType: "plist")!
        data = NSMutableDictionary(contentsOfFile: plistData as String)!

      

        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        TalkingData.trackPageBegin("SheZhi")
    }
    
    override func viewWillDisappear(animated: Bool) {
        TalkingData.trackPageEnd("SheZhi")
        
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
        
        
        
        tableView.rowHeight = 60
        
        
        let dataRow = indexPath.row + 1 //数组元素从1开始的，所以+1 ，indexPath默认为0
        let dataGroup = data["\(dataRow)"] as! NSDictionary
        let ImageUrl = dataGroup["image"] as! NSString
        
        
        tableCell.settingTitle.text = dataGroup["title"] as? String
        tableCell.settingImage.image = UIImage(named:"\(ImageUrl)")


        
        

        
        return tableCell
        
    }
    
    
    
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let likeVc = LikeViewController()
        
        switch(indexPath.row){
        case 0:
            self.navigationController?.pushViewController(likeVc, animated: true);
//        case 1:
//            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.baidu.com")!);
            
        
            
            
        default:
            break;
            
            
        }
       
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        

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
