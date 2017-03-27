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
        // 如果在调用系统的某一个方法是，该方法最后面有一个throws，说明该方法会抛出异常，如果一个方法会抛出异常，那么需要对该异常进行处理
        /*
         在swift中提供三种处理异常的方式
         方式一：try方式 程序员手动捕捉异常
         do {
         try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
         } catch {
         print(error)
         }
         
         方式二：try？方式（常用方式） 系统帮助我们处理异常，如果系统出现了异常，这该方法返回nil，如果没有异常，折返回对应的对象
         guard let any = tyr? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {
         return
         }
         
         方式三：try！方式（不建议非常危险） 直接告诉系统，该方法没有异常，注意：如果该方法出现了异常，那么程序会报错（崩溃）
         let any = tyr！ JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
         */
        
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
