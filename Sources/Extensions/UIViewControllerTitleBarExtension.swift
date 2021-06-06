//
//  UIViewControllerTitleBarExtension.swift
//  CDAffectedAnatomyApp
//
//  Created by Divyesh Makwana on 3/3/21.
//  Copyright © 2021 Pacific Communications. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    typealias TitleBarActionClosure = (UIViewController) -> ()
    
    // MARK:- Custom Properties
    private struct AssociatedKeys {
        static var preferredTitleBarActionStyle: UInt8 = 0
        static var preferredTitleBarGrabberHidden: UInt8 = 0
        static var titleBarActionClosure: UInt8 = 0
    }
    
    /// Title bar action style. . Defaults to hidden
    var preferredTitleBarActionStyle: TitleBar.ActionStyle? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.preferredTitleBarActionStyle) as? TitleBar.ActionStyle }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.preferredTitleBarActionStyle, newValue, .OBJC_ASSOCIATION_RETAIN)
            titleBarViewController?.titleBar.actionStyle = newValue ?? .hidden
        }
    }
    
    /// Weather the grabber should be hidden. Default is false
    var preferredTitleBarGrabberHidden: Bool? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.preferredTitleBarGrabberHidden) as? Bool }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.preferredTitleBarGrabberHidden, newValue, .OBJC_ASSOCIATION_RETAIN)
            titleBarViewController?.titleBar.isGrabberHidden = newValue ?? false
        }
    }
    
    /// Action closure when action button is clicked
    var titleBarActionClosure: TitleBarActionClosure? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.titleBarActionClosure) as? TitleBarActionClosure }
        set { objc_setAssociatedObject(self, &AssociatedKeys.titleBarActionClosure, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
}
