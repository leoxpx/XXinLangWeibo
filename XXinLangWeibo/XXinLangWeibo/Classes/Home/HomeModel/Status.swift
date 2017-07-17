//
//  Status.swift
//  XXinLangWeibo
//
//  Created by 许墨 on 2017/7/17.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class Status: NSObject {

    // MARK:- 属性
    var created_at : String?    // 微博创建时间
    var source : String?        // 微博来源
    var text : String?          // 微博正文
    var mid : Int = 0           // 微博id
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
