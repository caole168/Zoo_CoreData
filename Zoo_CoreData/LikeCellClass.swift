//
//  LikeCellClass.swift
//  Zoo_CoreData
//
//  Created by Ifeng on 15/11/6.
//  Copyright © 2015年 pincher. All rights reserved.
//

import UIKit


class LikeTableViewCell: UITableViewCell {


    //屏幕尺寸
    let Screen = UIScreen.mainScreen().bounds
    
    
    //创建元素
    let syContentTitle = UILabel()
    let syContentImage = UIImageView()
    let syContentTime = UILabel()
    let syContentSource = UILabel()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "likeCell")
        
        
        let ScreenWidth = Screen.width

        
        syContentTitle.numberOfLines = 2
        syContentTitle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        syContentTitle.textAlignment = NSTextAlignment.Justified
        
        
        
        //屏幕尺寸判断
        
        
        if Screen.width == 320.0{
            
            syContentImage.frame = CGRectMake(2, 18, 282, 153)
            syContentTitle.frame = CGRectMake(2, 182, 282, 50)   //  iphone 5  *1.17
            syContentTime.frame  = CGRectMake(2, 182, 282, 50)
            self.frame = CGRectMake(0, 0, ScreenWidth, 180)
            
        }
        
        
        
        if Screen.width == 375.0{
            
            
            syContentImage.frame = CGRectMake(246,9,120,81) //  iphone 6  375
            syContentTitle.frame = CGRectMake(10,10, 220,46)
            syContentTime.frame  = CGRectMake(100, 77, 100, 20)
            syContentSource.frame = CGRectMake(10, 77, 80, 20)
            
            
            syContentTitle.font     = UIFont(name:"Arial", size: 15)
            
            
            syContentSource.font    = UIFont(name:"Arial", size:11)
            syContentSource.textColor = UIColor.grayColor()
            
            
            syContentTime.font      = UIFont(name: "Arial", size: 11)
            syContentTime.textColor = UIColor.grayColor()
        }
        
        
        
        if Screen.width == 414.0{
            
            syContentImage.frame = CGRectMake(24, 24, 364, 198)   // iphone 6 plus   1.10
            syContentTitle.frame = CGRectMake(24, 235,364, 30)
            
        }
        
        
        self.addSubview(syContentTitle)
        self.addSubview(syContentImage)
        self.addSubview(syContentTime)
        self.addSubview(syContentSource)
        
        
    
    
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
        
        
        
    }
    
    
    



}