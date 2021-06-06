//
//  NSLayoutConstraintPriority.swift
//  TitleBarViewController
//
//  Created by Divyesh Makwana on 6/3/21.
//

import UIKit

extension NSLayoutConstraint {
    
    /// Returns the constraint sender with the passed priority.
    ///
    /// - Parameter priority: The priority to be set.
    /// - Returns: The sended constraint adjusted with the new priority.
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}

extension UILayoutPriority {
    
    /// Creates a priority which is almost required, but not 100%.
    static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    /// Creates a priority which is not required at all.
    static var notRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 0)
    }
    
    /// Creates a priority which is half required
    static var medium: UILayoutPriority {
        return UILayoutPriority(rawValue: 500)
    }
}
