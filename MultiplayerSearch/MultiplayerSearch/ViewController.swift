//
//  ViewController.swift
//  MultiplayerSearch
//
//  Created by 夏语诚 on 2018/6/7.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {
    
    @IBOutlet var myAvatar: AvatarView!
    @IBOutlet var opponentAvatar: AvatarView!
    
    @IBOutlet var status: UILabel!
    @IBOutlet var vs: UILabel!
    @IBOutlet var searchAgain: UIButton!
    
    @IBAction func actionSearchAgain() {
        UIApplication.shared.keyWindow!.rootViewController = storyboard!.instantiateViewController(withIdentifier: "ViewController") as UIViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchForOpponent()
        delay(4.0, completion: foundOpponent)
        
        delay(4.0, completion: connectedToOpponent)
    }
    
    func searchForOpponent() {
        let avatarSize = myAvatar.frame.size
        let bounceXOffset: CGFloat = avatarSize.width / 1.9
        let morphSize = CGSize(width: avatarSize.width * 0.85, height: avatarSize.height * 1.1)
        let rightBouncePoint = CGPoint(x: view.frame.size.width / 2.0 + bounceXOffset, y: myAvatar.center.y)
        let leftBouncePoint = CGPoint(x: view.frame.size.width / 2.0 - bounceXOffset, y: myAvatar.center.y)
        
        myAvatar.bounceOff(point: rightBouncePoint, morphSize: morphSize)
        opponentAvatar.bounceOff(point: leftBouncePoint, morphSize: morphSize)
    }
    
    func foundOpponent() {
        status.text = "Connecting..."
        
        opponentAvatar.image = #imageLiteral(resourceName: "avatar-2")
        opponentAvatar.name = "Ray"
    }
    
    func connectedToOpponent() {
        myAvatar.shouldTransitionToFinishedState = true
        opponentAvatar.shouldTransitionToFinishedState = true
        
        delay(1.0, completion: completed)
    }

    func completed() {
        status.text = "Ready to play"
        UIView.animate(withDuration: 0.2) {
            self.vs.alpha = 1.0
            self.searchAgain.alpha = 1.0
        }
    }
}

