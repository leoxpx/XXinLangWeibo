//
//  HomeVC.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/3/27.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    // MARK:- 属性
    
    
    // MARK: - 懒加载属性
    lazy var titleBtn : UIButton = TitleButton()
    // 注意:在闭包中如果使用当前的对象的属性或者调用方法, 也需要加self
    // 两个地方需要使用self : 1> 如果在一个函数中出现奇异 2> 在闭包中使用当前对象属性或方法
    lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[weak self] (presented) in
        
        self?.titleBtn.isSelected = presented
    }
    
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.未登录
        visiterView.addRotationAnim()
        if !isLogin {
            return
        }
        // 2.设置导航栏内容
        setupNavBar()
    }
}


// MARK:- 设置UI
extension HomeVC {
    func setupNavBar() {
        
        // 1.左
        /*
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "navigationbar_friendattention"), for: .normal)
        leftBtn.setImage(UIImage(named: "navigationbar_friendattention_highlighted"), for: .highlighted)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        */
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        // 2.右
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 3.titleView
        titleBtn.setTitle("codrewhy", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

// MARK: - 事件监听函数
extension HomeVC {
    
    func titleBtClick(titleBtn : TitleButton) {
        // 1. 创建弹出控制器
        let popoverVc = PopoverVC()
        
        // 2. 设置控制器model样式
        popoverVc.modalPresentationStyle = .custom
        
        // 3. 设置转场代理
        popoverVc.transitioningDelegate = popoverAnimator
        popoverAnimator.popoverFrame = CGRect(x: (self.view.frame.size.width-180)/2, y: 55, width: 180, height: 250)
        // 4. 弹出控制器
        present(popoverVc, animated: true, completion: nil)
        
    }
}

