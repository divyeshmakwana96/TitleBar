//
//  TableViewController.swift
//  TitleBarViewController
//
//  Created by Divyesh Makwana on 6/4/21.
//

import UIKit
import TitleBar

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Devices"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        preferredTitleBarGrabberHidden = true
        
        // accessory view
        let segmentControl = UISegmentedControl(items: ["First", "Second"])
        let stackview = UIStackView(arrangedSubviews: [segmentControl])
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.insetsLayoutMarginsFromSafeArea = false
        stackview.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 5, right: 20)
        titleBarViewController?.titleBar.accessoryView = stackview        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Item \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let modalViewController = ModalViewController()
        let titleBarViewController = TitleBarViewController(rootViewController: modalViewController)
        show(titleBarViewController, sender: self)
    }
}
