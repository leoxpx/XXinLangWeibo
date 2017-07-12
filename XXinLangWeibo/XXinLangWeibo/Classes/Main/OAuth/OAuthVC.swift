//
//  OAuthVC.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/7/5.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthVC: UIViewController {
    // MARK:- 控件属性
    @IBOutlet weak var webView: UIWebView!
    
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 设置导航栏
        setupNavigationBar()
        
        // 2. 加载网页
        loadPage()
    }
}

// MARK:- 设置UI相关
extension OAuthVC {
    
    func setupNavigationBar() {
        // 1. 设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        
        // 2. 设置右侧item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillItemClick))
        
        // 3. 设置标题
        title = "登录";
    }
    
    func loadPage() {
        // 1. 获取登录页面URLString
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(app_back_url)"
        
        // 2. 创建对用的NSURL
        guard let urls = NSURL(string: urlString) else {
            return
        }
        
        // 3. request
        let request = NSURLRequest(url: urls as URL)
        
        // 4. 加载网页
        webView.loadRequest(request as URLRequest)
    }
}

// MARK:- 事件监听
extension OAuthVC {
    func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    func fillItemClick() {
        // 1. 书写js代码
        let jsCode = "document.getElementById('userId').value='18768871775';document.getElementById('passwd').value='1';"
        
        // 2. 执行js代码
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

//MARK:- webView代理
extension OAuthVC : UIWebViewDelegate {
    // 开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    // 加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    // 加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    // 准备加载页面
    // 返回值: true -> 继续加载该页面, false -> 不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 1. 获取页面URL
        guard let webUrl = request.url else {
            return true
        }
        
        // 2. 获取URL中字符串
        let webUrlStr = webUrl.absoluteString
        
        // 3. 判断字符串是否包含code
        guard webUrlStr.contains("code=") else {
            return true
        }
        
        // 4. 截取code
        let code = webUrlStr.components(separatedBy: "code=").last!
        
        // 5. 请求access_token
        loadAccessToken(code: code)
        
        return true
    }
}

// MARK:- 请求参数
extension OAuthVC {
    
    // 请求access_token
    func loadAccessToken(code : String) {
        
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        
        let parameters : Dictionary = ["client_id":app_key, "client_secret":app_secret, "grant_type":"authorization_code", "code":code, "redirect_uri":app_back_url]
        
        NetworkTools.shareInstance.request(methodType: .POST, urlString: urlStr, parameters: parameters) { (result, error) in
            // 1. 错误
            if error != nil {
                print(error!)
                return
            }
            
            // 2. 成功
            guard let accountDict = result as? [String : AnyObject] else {
                print("未获取授权数据")
                return
            }
            // 3. 将字典转模型
            let account = UserAccount(dict: accountDict)
            
            // 4. 请求用户信息
            self.loadUserInfo(account: account)
        }
    }
}

// MARK:- 获取用户信息
extension OAuthVC {
    
    // 获取用户信息
    func loadUserInfo(account : UserAccount) {
        
        // 1.accessToken
        guard let accessToken = account.access_token else { return }
        
        // 2. uid
        guard let uid = account.uid else { return }
        
        let urlStr = "https://api.weibo.com/2/users/show.json"
        
        let parameters : Dictionary = ["access_token":accessToken,
                                        "uid":uid]
        
        NetworkTools.shareInstance.request(methodType: .GET, urlString: urlStr, parameters: parameters) { (result, error) in
            // 1. 错误
            if error != nil {
                print(error!)
                return
            }
            
            // 2. 拿到用户信息
            guard let userInfoDict = result else {
                
                return
            }
            
            // 3. 去用户信息
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            // 4. 将account对象保存
            // 4.1 偶去沙河路径
            var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            accountPath = (accountPath as NSString).appending("account.plist")
            
            print(accountPath)
            // 4.2 保存对象
            NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
            
            // 5.将account对象设置到单利对象中
            
            
            // 5. 显示欢迎界面
            
            
            // 6.退出当前控制器
            self.dismiss(animated: false, completion: {
                UIApplication.shared.keyWindow?.rootViewController = WelcomeVC()
                
            })
        }
    }
}

