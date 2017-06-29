//
//  HomeVC.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/3/27.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    // MARK: - 懒加载属性
    
    lazy var titleBtn : UIButton = TitleButton()
    
    
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
        // 1. 改变按钮状态
        titleBtn.isSelected = !titleBtn.isSelected
        
        // 2. 创建弹出控制器
        let popoverVc = PopoverVC()
        
        // 3. 设置控制器model样式
        popoverVc.modalPresentationStyle = .custom
        
        // 4. 设置转场代理
        popoverVc.transitioningDelegate = self
        
        // 弹出控制器
        present(popoverVc, animated: true, completion: nil)
        
        
    }
    
    
    
}

extension HomeVC : UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return XLPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    
}
