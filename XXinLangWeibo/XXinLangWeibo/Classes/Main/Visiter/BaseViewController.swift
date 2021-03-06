//
//  BaseViewController.swift
//  XXinLangWeibo
//
//  Created by 许墨 on 2017/4/16.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    // MARK:- 懒加载属性
    lazy var visiterView : VisiterView = VisiterView.visitorView()
    
    // Mark:- 定义变量
    var isLogin : Bool = UserAccountViewModel.shareIntance.isLogin
    
    // MARK:- 系统回调函数
    override func loadView() {
        
        // 1. 从沙河中读取归档信息
        // 1.1 获取沙河路径
        var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath = (accountPath as NSString).appending("account.plist")
        // 1.2 读取信息
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
        if let account = account {
            // 1.3 取出过期日期
           if let expireData = account.expires_date {
               isLogin = expireData.compare(NSDate() as Date) == ComparisonResult.orderedDescending
            }
        }
        
        // 判断加载哪一个View
        isLogin ? super.loadView() : setupViesitor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItems()
    }
}

// MARK:- 设置UI界面
extension BaseViewController {
    // 设置方可试图
    func setupViesitor() {
        self.view = visiterView
        
        // 监听访客试图注册登录点击
        visiterView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        visiterView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
    }
    
    // 设置导航栏左右item
    func setupNavItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginBtnClick))
    }
}

extension BaseViewController {
    
    func registerBtnClick() {
        print("registerBtnClick")
    }
    func loginBtnClick() {
        // 创建授权控制器
        let oauth = OAuthVC()
        
        // 2. 包装导航控制器
        let oauthNav = UINavigationController(rootViewController: oauth)
        
        // 3. 弹出控制器
        present(oauthNav, animated: true, completion: nil)
    }
}
