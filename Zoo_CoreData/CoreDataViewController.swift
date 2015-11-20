//
//  CoreDataViewController.swift
//  Zoo_CoreData
//
//  Created by Ifeng on 15/11/12.
//  Copyright © 2015年 pincher. All rights reserved.
//

import Foundation
import CoreData




func clearCoreData(){
    
}


//查询数据

func fetchCoreData(){
    
    //获取管理的数据上下文 对象
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate //获取appdel

    
    let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Entity")
    //        fetchRequest.fetchLimit = 10 //限定查询结果的数量
    //        fetchRequest.fetchOffset = 0 //查询的偏移量
    
    let sortDescrpitor:NSSortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: Selector("localizedStandardCompare:"))
    
    
    let context = appDel.managedObjectContext
    let entity:NSEntityDescription? = NSEntityDescription.entityForName("Entity", inManagedObjectContext: context)
    
    
    fetchRequest.sortDescriptors = [sortDescrpitor]
    fetchRequest.entity = entity
    
    
    do{
        let fetchResult = try context.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        
        print("____________________________________________")
        print(fetchResult.count)
        
        
        print(fetchResult)
        
        //            for info:Entity in fetchResult as! [Entity]{
        //                print("id=\(info.title)")
        //
        //                   fetchData[] = info.title
        //                fetchTitle = info.title as String!
        //                fetchSource = info.time as String!
        //                fetchImage = info.image as String!
        //                fetchTime = info.time as String!
        //                fetchCount = fetchResult.count
        //
        //
        //            }
        
        
    }catch{
        print("error" )
    }
    
    
    
}

