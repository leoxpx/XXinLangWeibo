//
//  HomeVC.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/3/27.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    
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
        
        
        
        
        
    }
}
