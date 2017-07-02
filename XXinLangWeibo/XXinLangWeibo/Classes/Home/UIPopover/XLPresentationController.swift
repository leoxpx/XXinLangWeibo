//
//  XLPresentationController.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/6/29.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class XLPresentationController: UIPresentationController {

    // MARK:- 对外提供属性
    var presentedFrame : CGRect = CGRect.zero
    
    // MARK:- 懒加载属性
    lazy var coverView = UIView()
    
    // MARK:- 系统回调函数
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // 1.设置弹出view的尺寸
        presentedView?.frame = presentedFrame
        
        // 2. 添加蒙版
        setupCoverView()
    }
}

// MARK:- 设置UI界面相关
extension XLPresentationController {
    func setupCoverView() {
        // 1. 添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        
        // 2. 设置蒙版属性
        coverView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        coverView.frame = containerView!.bounds
        
        // 3. 监听点击事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tap)
        
    }
}

// MARK:- 事件监听
extension XLPresentationController {
    func coverViewClick() {
        
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}




