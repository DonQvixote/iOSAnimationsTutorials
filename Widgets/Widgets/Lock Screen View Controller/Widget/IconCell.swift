//
//  IconCell.swift
//  Widgets
//
//  Created by 夏语诚 on 2018/6/19.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

class IconCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    var animator: UIViewPropertyAnimator?
    
    func iconJiggle() {
        if let animator = animator, animator.isRunning {
            return
        }
        animator = AnimatorFactory.jiggle(view: icon)
    }
}
