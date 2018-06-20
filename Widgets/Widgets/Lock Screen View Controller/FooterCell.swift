//
//  FooterCell.swift
//  Widgets
//
//  Created by 夏语诚 on 2018/6/19.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {

    var didPressEdit: (() -> Void)?
    
    @IBAction func edit() {
        didPressEdit?()
    }
}
