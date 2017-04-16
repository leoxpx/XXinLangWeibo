//
//  VisiterView.swift
//  XXinLangWeibo
//
//  Created by 许墨 on 2017/4/16.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class VisiterView: UIView {
// MARK:- 提供快速通过XIB创建的类方法
    
    class func visitorView()-> VisiterView {
        return Bundle.main.loadNibNamed("VisiterView", owner: nil, options: nil)?.first as! VisiterView
    }
    
    // Mark:- 控件的属性
    @IBOutlet weak var RotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK:- 自定义函数
    func setupVisitorViewInfo(iconName : String, title : String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        RotationView.isHidden = true
    }
    
    func addRotationAnim() {
        // 1.创建动画
        let rotationAnim = CABasicAnimation.init(keyPath: "transform.rotation.z");
        
        // 2.设置属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 10
        rotationAnim.isRemovedOnCompletion = false
        
        // 3.将动画添加到layer中
        RotationView.layer.add(rotationAnim, forKey: nil)
        
    }
    
}
