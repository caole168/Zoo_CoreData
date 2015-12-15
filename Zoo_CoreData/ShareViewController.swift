//
//  share.swift
//  Zoo
//
//  Created by Ifeng on 15/10/1.
//  Copyright © 2015年 pincher. All rights reserved.
//

import UIKit


func sendText(type:Int32 , shareTitle:NSString , shareUrl:NSString , shareImage:NSData) {
    

    //分享到好友
    let req = SendMessageToWXReq()//发送的文本信息
    let url = WXWebpageObject()
    let message = WXMediaMessage()

    
    //分享地址
    url.webpageUrl = "\(shareUrl)"
    
      
    //分享标题
    message.title = "\(shareTitle)"
    
    
    //分享描述
    message.description = "欢迎关注微信公众号：it_zoo!"
    message.mediaObject = url
    message.thumbData = shareImage
 


    
    req.message = message
    req.scene = Int32(type)
    req.bText = false
    
    print(WXApi.sendReq(req))
    
    
    WXApi.sendReq(req)
}


