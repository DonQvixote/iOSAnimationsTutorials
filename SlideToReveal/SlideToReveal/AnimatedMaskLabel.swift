//
//  AnimatedMaskLabel.swift
//  SlideToReveal
//
//  Created by 夏语诚 on 2018/6/7.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class AnimatedMaskLabel: UIView {

    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        // Configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
//        let colors = [
//            UIColor.black.cgColor,
//            UIColor.white.cgColor,
//            UIColor.black.cgColor
//        ]
        let colors = [
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.orange.cgColor,
            UIColor.cyan.cgColor,
            UIColor.red.cgColor,
            UIColor.yellow.cgColor
        ]
        gradientLayer.colors = colors
        
//        let locations: [NSNumber] = [
//            0.25,
//            0.5,
//            0.75
//        ]
        let locations: [NSNumber] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        gradientLayer.locations = locations
        
        return gradientLayer
    }()
    
    @IBInspectable
    var text: String! {
        didSet {
            setNeedsDisplay()
            let image = UIGraphicsImageRenderer(size: bounds.size).image { _ in
                text.draw(in: bounds, withAttributes: textAttributes)
            }
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
            maskLayer.contents = image.cgImage
            
            gradientLayer.mask = maskLayer
        }
    }
    
    let textAttributes: [NSAttributedStringKey: Any] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [
            .font: UIFont(name: "HelveticaNeue-Thin", size: 28.0)!,
            .paragraphStyle: style
        ]
    }()
    
    override func layoutSubviews() {
        layer.borderColor = UIColor.green.cgColor
        
//        gradientLayer.frame = bounds
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 3 * bounds.size.width, height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
//        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
//        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.65, 0.8, 0.85, 0.9, 0.95, 1.0]
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = Float.infinity
        
        gradientLayer.add(gradientAnimation, forKey: nil)
    }
}
