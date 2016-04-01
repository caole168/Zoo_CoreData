//
//  RefreshViewController.swift
//  Zoo_CoreData
//
//  Created by Ifeng on 15/12/15.
//  Copyright © 2015年 pincher. All rights reserved.
//

import UIKit




//请求网络数据
func getHttp() -> Array<AnyObject> {
    

    let url = NSURL(string: "http://121.42.213.89/app/index.php/Home/Admin/api?page=1")
    let jsonData = NSData(contentsOfURL: url!)
    

    var data:Array<AnyObject> = Array()

   
    //检测网络状态
    let netWorkStatue = Reachability.reachabilityForInternetConnection().currentReachabilityStatus()
    
    if netWorkStatue.rawValue == 0{
        print("网络连接失败，请检查网络")
    }else{
        
        //接口出错
        if jsonData != nil {
            
    do {
        data = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:NSJSONReadingOptions.MutableContainers) as! Array<AnyObject>
            print("加载数据")
    
    
    }catch{
        print("取出数据失败")
    }
            
        }else{
            print("接口报错")
        }
    }
    
    

    return data
    
}


