//
//  WidgetCell.swift
//  Widgets
//
//  Created by 夏语诚 on 2018/6/19.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

class WidgetCell: UITableViewCell {

    private var showsMore = false
    @IBOutlet weak var widgetHeight: NSLayoutConstraint!
    
    weak var tableView: UITableView?
    var toggleHeightAnimator: UIViewPropertyAnimator?
    
    @IBOutlet weak var widgetView: WidgetView!
    
    var owner: WidgetsOwnerProtocol? {
        didSet {
            if let owner = owner {
                widgetView.owner = owner
            }
        }
    }
    
    @IBAction func toggleShowMore(_ sender: UIButton) {
        self.showsMore = !self.showsMore
        
//        self.widgetHeight.constant = self.showsMore ? 230 : 130
//        self.tableView?.reloadData()
//
//        widgetView.expanded = showsMore
//        widgetView.reload()
        let animations = {
            self.widgetHeight.constant = self.showsMore ? 230 : 130
            if let tableView = self.tableView {
                tableView.beginUpdates()
                tableView.endUpdates()
                tableView.layoutIfNeeded()
            }
        }
        
        let textTransition = {
            UIView.transition(with: sender, duration: 0.25,
                              options: .transitionFlipFromTop,
                              animations: {
                                sender.setTitle(self.showsMore ? "Show Less" : "Show More", for: .normal)
            }, completion: nil)
        }
        
        if let toggleHeightAnimator = toggleHeightAnimator, toggleHeightAnimator.isRunning {
            toggleHeightAnimator.pauseAnimation()
            toggleHeightAnimator.addAnimations(animations)
            toggleHeightAnimator.addAnimations(textTransition, delayFactor: 0.5)
            toggleHeightAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 1.0)
        } else {
            let spring = UISpringTimingParameters(mass: 30, stiffness: 1000, damping: 300, initialVelocity: CGVector(dx: 5, dy: 0))
            toggleHeightAnimator = UIViewPropertyAnimator(duration: 0.0, timingParameters: spring)
            toggleHeightAnimator?.addAnimations(animations)
            toggleHeightAnimator?.addAnimations(textTransition, delayFactor: 0.5)
            toggleHeightAnimator?.startAnimation()
        }
        widgetView.expanded = showsMore
        widgetView.reload()
    }
    
}
