//
//  UserAccount.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/7/5.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class UserAccount: NSObject ,NSCoding {
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
    
    // MARK:- 归档解档
    // 解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    
    // 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    
}
