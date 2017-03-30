//
//  MainVC.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/3/27.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {

    // MARK:- 懒加载属性
    
//     lazy var composeBtn : UIButton = UIButton.createButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        setupItemImages()
    }

}

// MARK: -设置UI界面
extension MainVC {
    
     func setupComposeBtn() {
        // 1.添加发布按钮
        tabBar.addSubview(composeBtn)
        
        // 2.设置属性
        
        
        // 3.位置
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height*0.5)
    }
    
    /*
     func setupItemImages() {
        
        // 1.遍历所有item
        for i in 0..<tabBar.items!.count {
            // 2.获取item
            let item = tabBar.items![i]
            
            // 3.如果下标值为2, 不可交互
            if i == 2 {
                item.isEnabled = false
                continue
            }
            
            // 4.设置其他item的选中时候的图片
            item.selectedImage = UIImage(named: imageNames[i])
        }
    }
 */
    
}

