//
//  ViewController.swift
//  SlideToReveal
//
//  Created by 夏语诚 on 2018/6/7.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slideView: AnimatedMaskLabel!
    @IBOutlet var time: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSlide))
        swipe.direction = .right
        slideView.addGestureRecognizer(swipe)
    }
    
    @objc func didSlide() {
        
        // reveal the meme upon successful slide
        let image = UIImageView(image: #imageLiteral(resourceName: "meme"))
        image.center = view.center
        image.center.x += view.bounds.size.width
        view.addSubview(image)
        
        UIView.animate(withDuration: 0.33, delay: 0.0, animations: {
            self.time.center.y -= 200.0
            self.slideView.center.y += 200.0
            image.center.x -= self.view.bounds.size.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.33, delay: 1.0, animations: {
            self.time.center.y += 200.0
            self.slideView.center.y -= 200.0
            image.center.x += self.view.bounds.size.width
        }) { _ in
            image.removeFromSuperview()
        }
    }
}

