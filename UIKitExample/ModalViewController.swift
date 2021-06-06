//
//  ModalViewController.swift
//  UIKitExample
//
//  Created by Divyesh Makwana on 6/5/21.
//

import UIKit

class ModalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Modal"
        preferredTitleBarActionStyle = .close
        titleBarActionClosure = { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
