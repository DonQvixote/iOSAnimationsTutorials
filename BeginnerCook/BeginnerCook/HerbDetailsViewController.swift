//
//  HerbDetailsViewController.swift
//  BeginnerCook
//
//  Created by 夏语诚 on 2018/6/12.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

class HerbDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var descriptionView: UITextView!
    @IBOutlet var licenseButton: UIButton!
    @IBOutlet var authorButton: UIButton!
    
    // MARK: button actions
    @IBAction func actionLicense(_ sender: AnyObject) {
        UIApplication.shared.open(URL(string: herb!.license)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func actionAuthor(_ sender: AnyObject) {
        UIApplication.shared.open(URL(string: herb!.credit)!, options: [:], completionHandler: nil)
    }
    
    var herb: HerbModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bgImage.image = UIImage(named: herb.image)
        titleView.text = herb.name
        descriptionView.text = herb.description
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(_:))))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func actionClose(_ tap: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
