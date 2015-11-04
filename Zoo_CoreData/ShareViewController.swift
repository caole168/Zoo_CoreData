//
//  share.swift
//  Zoo
//
//  Created by Ifeng on 15/10/1.
//  Copyright © 2015年 pincher. All rights reserved.
//

import UIKit


func sendText(type:Int32 , ShareTitle:NSString , ShareUrl:NSString) {
    
   
    //分享到好友
    let req = SendMessageToWXReq()
    let shareUrl = WXWebpageObject()
    

    
    //分享地址
    shareUrl.webpageUrl = "\(ShareUrl)"
    
    let message = WXMediaMessage()
    //分享标题
    message.title = "\(ShareTitle)"
    //分享描述
    message.description = "欢迎关注微信公众号：it_zoo!"
    
    message.mediaObject = shareUrl
    req.message = message
    req.bText = false
    
    
    req.scene = Int32(type)
    WXApi.sendReq(req)
    
}


