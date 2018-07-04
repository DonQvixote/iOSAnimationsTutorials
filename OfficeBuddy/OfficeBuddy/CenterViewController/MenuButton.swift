//
//  MenuButton.swift
//  OfficeBuddy
//
//  Created by 夏语诚 on 2018/7/4.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

class MenuButton: UIView {

    var imageView: UIImageView!
    var tapHandler: (() -> ())?
    
    override func didMoveToSuperview() {
        frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        
        imageView = UIImageView(image: #imageLiteral(resourceName: "menu"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MenuButton.didTap)))
        addSubview(imageView)
    }

    @objc func didTap() {
        tapHandler?()
    }
    
}
