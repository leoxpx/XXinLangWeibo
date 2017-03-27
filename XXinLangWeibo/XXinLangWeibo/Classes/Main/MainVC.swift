//
//  MainVC.swift
//  XXinLangWeibo
//
//  Created by 薪王iOS1 on 2017/3/27.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 字符串创建
        /*
        addChildViewController(childVCStr: "HomeVC", title: "首页", imageName: "tabbar_home")
        addChildViewController(childVCStr: "MessageVC", title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childVCStr: "DiscoverVC", title: "发现", imageName: "tabbar_discover")
        addChildViewController(childVCStr: "ProfileVC", title: "我", imageName: "tabbar_profile")
         */
        
        // json动态创建
        // 1.获取json文件路径
        guard let jsonPaths = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            print("没有获取到路径")
            return
        }
        
        // 2. 读取json问价内容
        guard let jsonData = NSData(contentsOfFile: jsonPaths) else {
            print("没有获取到json二进制")
            return
        }
        
        // 3.将data转成数组
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {
            return
        }
        
        guard let dictArray = anyObject as? [[String : AnyObject]] else {
            return
        }
        
        // 4.遍历字典,获取对应信息
        for dict in dictArray {
            // 4.1. 获取控制器对子那个的字符串
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            // 4.2. 获取控制器显示的title
            guard  let vcTitle = dict["title"] as? String else {
                continue
            }
            // 4.3. 获取控制器显示的图标名称
            guard  let vcImage = dict["imageName"] as? String else {
                continue
            }
            
            addChildViewController(childVCStr: vcName, title: vcTitle, imageName: vcImage)
        }
    }
    
    // swiftz支持方法重载
    // 方法的重载:方法名相同,但是参数不同. --> 1.参数类型不同 2.参数个数不同
    // private在当前文件中可以访问,但是其他文件不能访问
    private func addChildViewController(childVCStr: String, title : String, imageName : String) {
        
        // 0.获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没获取到项目名")
            return
        }
        
        // 1.根据字符串转获得类名
        let name = nameSpace + "." + childVCStr
        guard let childVCClass = NSClassFromString(name) else {
            print("没获取到类名")
            return
        }
        
        // 2.将对应的AnyObject转成控制器类型
        guard let childVCType = childVCClass as? UIViewController.Type else {
            print("获取到对应的控制器类型")
            return
        }
        
        // 3.创建对应的控制器对象
        let childVC = childVCType.init()
        
        // 1.设置子控制器属性
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 2.包装导航控制器
        let childNav = UINavigationController(rootViewController: childVC)
        
        // 3. 添加控制器
        addChildViewController(childNav)
        
    }

}
