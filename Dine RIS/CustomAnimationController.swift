//
//  CustomAnimationController.swift
//  Dine RIS
//
//  Created by Naman Kedia on 3/19/17.
//  Copyright © 2017 Ruamrudee International School. All rights reserved.
//

import UIKit

class CustomAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let containerView = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        toVC.view.transform = CGAffineTransform(translationX: 0, y: toVC.view.bounds.size.height)
        containerView.addSubview(toVC.view)
        
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.alpha = 0
            toVC.view.transform = CGAffineTransform.identity
        }, completion: { (completed) in
            fromVC.view.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

        })
    }

}
