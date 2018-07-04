//
//  CenterViewController.swift
//  OfficeBuddy
//
//  Created by 夏语诚 on 2018/7/4.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {
    
    var menuItem: MenuItem! {
        didSet {
            title = menuItem.title
            view.backgroundColor = menuItem.color
            symbol.text = menuItem.symbol
        }
    }
    
    @IBOutlet var symbol: UILabel!
    
    // MARK: - ViewController
    
    var menuButton: MenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        menuButton = MenuButton()
        menuButton.tapHandler = {
            if let containerVC = self.navigationController?.parent as? ContainerViewController {
                containerVC.toggleSlideMenu()
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        menuItem = MenuItem.sharedItems.first!
    }
}
