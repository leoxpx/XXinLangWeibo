//
//  UIButton-Extension.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/3/30.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

extension UIButton {
    // swift中类方法是以class开头的方法,类石油OC中+开头的方法
    /*
    class func createButton(imageName : String, bgImageName : String) -> UIButton {
        // 1.创建
        let btn = UIButton()
        // 2. 设置属性
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        btn.setImage(UIImage(named:bgImageName), for: .normal)
        btn.setImage(UIImage(named:bgImageName + "highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        return btn
    }
    */
    
    // 构造函数 (系统会自动返回值)
    // convenience : 遍历,使用convenience修饰的构造函数叫遍历构造函数
    // 遍历构造函数通常用在对系统的类进行构造函数的扩充使用
    /*
     遍历构造函数特点
        1.遍历构造函数通常都是写在convenience里面
        2.遍历构造函数init前面要加convenience
        3.在遍历构造函数中需要明确的调用self.init()
     */
    convenience init (imageName : String, bgImageName : String) {
        self.init()
        
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named:bgImageName), for: .normal)
        setBackgroundImage(UIImage(named:bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
    
}
