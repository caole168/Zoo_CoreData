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
    
    do {
        data = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:NSJSONReadingOptions.MutableContainers) as!  Array<AnyObject>
    }catch{
        print("取出数据失败")
    }
    
    print("加载数据")
    return data
    
}


