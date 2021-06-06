//
//  UIViewControllerProxyExtension.swift
//  CDAffectedAnatomyApp
//
//  Created by Divyesh Makwana on 1/21/21.
//  Copyright © 2021 Pacific Communications. All rights reserved.
//

import UIKit

extension UIViewController {    
    func firstParent<T: UIViewController>(of type: T.Type) -> T? {
        (self as? T) ?? (parent as? T) ?? parent?.firstParent(of: type)
    }
}
