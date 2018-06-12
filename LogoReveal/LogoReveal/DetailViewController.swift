//
//  DetailViewController.swift
//  LogoReveal
//
//  Created by 夏语诚 on 2018/6/12.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit
import QuartzCore

class DetailViewController: UITableViewController, UINavigationControllerDelegate {
    
    let packItems = ["Ice cream money", "Great weather", "Beach ball", "Swimsuit for him", "Swimsuit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pack List"
        tableView.rowHeight = 54.0
        tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .none
        cell.textLabel?.text = packItems[indexPath.row]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\(indexPath.row).png")
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
