//
//  UserAccount.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/7/5.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    //MARK:- 属性
    var access_token : String?          // 授权access_token
    var expires_in : TimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }// 过期时间 秒
    var uid : String?                   // 用户ID
    
    // 过期日期
    var expires_date : NSDate?
    
    // 昵称
    var screen_name : String?
    
    // 用户头像地址
    var avatar_large : String?
    
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    // MARK:- 重写description属性
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token","expires_date","uid","screen_name","avatar_large"]).description
    }
}
