//
//  UserAccountTool.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/7/10.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class UserAccountViewModel {

    // MARK:- 将类设计成单利
    static let shareIntance : UserAccountViewModel = UserAccountViewModel()
    
    // MARK:- 定义属性
    var account : UserAccount?
    
    // MARK:- 计算属性
    var accountPath : String {
        // 获取沙河路径
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appending("account.plist")
    }
    
    var isLogin: Bool {
        if account == nil {
            return false
        }
        guard let expireData = account?.expires_date else {
            return false
        }
        return expireData.compare(NSDate() as Date) == ComparisonResult.orderedDescending
    }
    
    // MARK:- 重写init()函数
    init() {
        // 1. 从沙河中读取归档信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
}
