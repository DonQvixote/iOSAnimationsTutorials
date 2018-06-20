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
        
        self.widgetHeight.constant = self.showsMore ? 230 : 130
        self.tableView?.reloadData()
        
        widgetView.expanded = showsMore
        widgetView.reload()
    }
    
}
