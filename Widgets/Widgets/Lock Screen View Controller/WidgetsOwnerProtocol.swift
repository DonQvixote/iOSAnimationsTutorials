//
//  WidgetsOwnerProtocol.swift
//  Widgets
//
//  Created by 夏语诚 on 2018/6/19.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

protocol WidgetsOwnerProtocol {
    var blurView: UIVisualEffectView { get }
    
    func startPreview(for: UIView)
    func updatePreview(percent: CGFloat)
    func finishPreview()
    func cancelPreview()
}

extension WidgetsOwnerProtocol {
    func startPreview(for forView: UIView) { }
    func updatePreview(percent: CGFloat) { }
    func finishPreview() { }
    func cancelPreview() { }
}
