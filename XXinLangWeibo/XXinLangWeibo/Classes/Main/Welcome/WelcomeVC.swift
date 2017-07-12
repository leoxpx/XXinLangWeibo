//
//  WelcomeVC.swift
//  XXinLangWeibo
//
//  Created by 许墨 on 2017/7/12.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeVC: UIViewController {
    // MARK:- 拖线的属性
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 0. 设置头像
        let profileURLStr = UserAccountViewModel.shareIntance.account?.avatar_large
        // ?? : 如果??前面的可选类型有值,那么将前面的可选类型进行解包并且赋值. 如果??前面的可选类型为nil,那么直接使用??后面的值
        let url = URL(string: profileURLStr ?? "")
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        
        // 1. 改变约束的值
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 250
        
        // 2. 执行动画
        // Damping: 阻尼系数,主力系数越大,弹动的效果越不明显 0-1
        // initialSpringVelocity: 初始化速度
        UIView.animate(withDuration: 5.0, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5.0, options: [], animations: { 
            
            self.view.layoutIfNeeded()
        }) { (_) in
            
            
        }
        
    }
}
