//
//  LockScreenViewController.swift
//  Widgets
//
//  Created by 夏语诚 on 2018/6/19.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

class LockScreenViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateTopConstraint: NSLayoutConstraint!
    
    @IBAction func presentSettings(_ send: Any? = nil) {
        // present the view controller
        settingsViewController = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        present(settingsViewController, animated: true, completion: nil)
    }
    
    
    let blurView = UIVisualEffectView(effect: nil)
    
    var settingsViewController: SettingsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.bringSubview(toFront: searchBar)
//        blurView.effect = UIBlurEffect(style: .dark)
//        blurView.alpha = 0
        blurView.isUserInteractionEnabled = false
        view.insertSubview(blurView, belowSubview: searchBar)
        
        tableView.estimatedRowHeight = 130.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.transform = CGAffineTransform(scaleX: 0.67, y: 0.67)
        tableView.alpha = 0
        
        dateTopConstraint.constant -= 100
        view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AnimatorFactory.scaleUp(view: tableView).startAnimation()
        AnimatorFactory.animateConstraint(view: view, constraint: dateTopConstraint, by: 100).startAnimation()
    }
    
    override func viewWillLayoutSubviews() {
        blurView.frame = view.bounds
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func toggleBlur(_ blurred: Bool) {
//        AnimatorFactory.fade(view: blurView, visible: blurred)
//        UIViewPropertyAnimator(duration: 0.55, curve: .easeOut, animations: blurAnimations(blurred)).startAnimation()
        UIViewPropertyAnimator(duration: 0.55,
                               controlPoint1: CGPoint(x: 0.57, y: -0.4),
                               controlPoint2: CGPoint(x: 0.96, y: 0.87),
                               animations: blurAnimations(blurred))
            .startAnimation()
    }
    
    func blurAnimations(_ blurred: Bool) -> () -> Void {
        return {
            self.blurView.effect = blurred ? UIBlurEffect(style: .dark) : nil
            self.tableView.transform = blurred ? CGAffineTransform(scaleX: 0.75, y: 0.75) : .identity
            self.tableView.alpha = blurred ? 0.33 : 1.0
        }
    }
}

extension LockScreenViewController: WidgetsOwnerProtocol { }

extension LockScreenViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Footer") as! FooterCell
            cell.didPressEdit = {[unowned self] in
                self.presentSettings()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! WidgetCell
            cell.tableView = tableView
            cell.owner = self
            return cell
        }
    }
}

extension LockScreenViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        toggleBlur(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        toggleBlur(false)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchBar.resignFirstResponder()
        }
    }
}
