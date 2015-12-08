//
//  SyCellClass.swift
//  Zoo
//
//  Created by caole on 15/9/4.
//  Copyright (c) 2015年 pincher. All rights reserved.
//

import UIKit

class SyTableViewCell: UITableViewCell {
    
    
    
    //屏幕尺寸
    let Screen = UIScreen.mainScreen().bounds
    
    @IBOutlet weak var syContentTitle: UILabel!
    @IBOutlet weak var syContentImage: UIImageView!
    @IBOutlet weak var syContentSource: UILabel!
    @IBOutlet weak var syContentTime: UILabel!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
 //       let ScreenWidth = Screen.width
        
        syContentTitle.numberOfLines = 3
        syContentTitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        syContentTitle.textAlignment = NSTextAlignment.Justified
        
        
        
        //屏幕尺寸判断
    
        
        if Screen.width == 320.0{
            
              syContentTitle.font = UIFont(name:"Arial", size: 14)
    
            
        }
        
        if Screen.width == 375.0{
            
             syContentImage.frame.size = CGSizeMake(120 , 81)

        }

//        if Screen.width == 414.0{
//            
//            syContentImage.frame = CGRectMake(24, 24, 364, 198)   // iphone 6 plus   1.10
//            syContentTitle.frame = CGRectMake(24, 235,364, 30)
//            
//        }
//        
//        
//        self.addSubview(syContentTitle)
//        self.addSubview(syContentImage)
//        self.addSubview(syContentTime)
//        self.addSubview(syContentSource)
//        
        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
        
        
    }
    
    
    
}

