//
//  UserAccountTool.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/7/10.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class UserAccountTool {

    // MARK:- 定义属性
    var account : UserAccount?
    
    // MARK:- 计算属性
    var accountPath : String {
        // 获取沙河路径
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appending("account.plist")
    }
    
    // MARK:- 重写init()函数
    init() {
        // 1. 从沙河中读取归档信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
        
        
    }
    
    func isLogin() -> Bool {
        if account == nil {
            return false
        }
        guard let expireData = account?.expires_date else {
            return false
        }
    }
}
