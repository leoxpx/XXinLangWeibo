//
//  PopoverAnimator.swift
//  XXinLangWeibo
//
//  Created by 许墨 on 2017/7/2.
//  Copyright © 2017年 Team. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    // MARK:- 对外暴露的属性
    var isShowView : Bool = false
    var popoverFrame : CGRect = CGRect.zero
    
    var callBack : ((_ presented : Bool) -> ())?
    
    // MARK:- 自定义够着函数
    // 注意: 如果自定义了一个构造函数,但是没有对默认构造函数init()进行重写, 那么自定义的构造函数会覆盖默认的init()构造函数
    init(callBacked : @escaping (_ presented : Bool) -> ()) {
        self.callBack = callBacked
    }
}

// MARK:- 自定义转场代理方法
extension PopoverAnimator : UIViewControllerTransitioningDelegate {
    
    // 目的: 改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentation = XLPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = popoverFrame
        
        return presentation
    }
    
    // 目的: 自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       
        isShowView = true
        
        callBack!(isShowView)
        
        return self;
    }
    // 目的: 自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isShowView = false
        
        callBack!(isShowView)
        
        return self
    }
}

// MARK: -弹出和消失动画代理方法
extension PopoverAnimator : UIViewControllerAnimatedTransitioning {
    // 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    // 获取'转场上下文':可以通过转场上下文获取弹出的View和消失的View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isShowView ? animationForPresentedView(transitionContext: transitionContext) : animationForDismissView(transitionContext: transitionContext)
    }
    
    // 自定义弹出View
    func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
        
        // 1. 获取弹出View
        // UITransitionContextFromViewKey : 获取消失View
        // UITransitionContextToViewKey : 获取弹出View
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // 2. 将弹出的View添加到containerView中
        transitionContext.containerView.addSubview(presentView)
        
        // 3.执行动画
        presentView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        presentView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            presentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (_) in
            // 必须告诉转场上下文你已经完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    // 自定义消失动画
    func animationForDismissView(transitionContext: UIViewControllerContextTransitioning) {
        
        // 1. 获取消失View
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        // 2.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            presentView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        }) { (_) in
            presentView.removeFromSuperview()
            // 必须告诉转场上下文你已经完成动画
            transitionContext.completeTransition(true)
        }
    }
}
