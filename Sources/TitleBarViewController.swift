//
//  TitleBarViewController.swift
//  CDAffectedAnatomyApp
//
//  Created by Divyesh Makwana on 3/3/21.
//  Copyright © 2021 Pacific Communications. All rights reserved.
//

import UIKit

open class TitleBarViewController: UIViewController {
    
    /// Titlebar
    public let titleBar = TitleBar()
    
    /// Root child view controller
    public let rootViewController: UIViewController
    
    /// Background view. . Defaults style is prominent blur
    open var backgroundView: UIView? = UIVisualEffectView(effect: UIBlurEffect(style: .prominent)) {
        didSet {
            updateBackgroundViewIfNeeded(oldView: oldValue)
        }
    }
    
    /// Title for the title bar
    public override var title: String? {
        didSet { titleBar.title = title }
    }
    
    private var titleToken: NSKeyValueObservation?
    
    
    /// Initialize with root view controller
    /// - Parameter rootViewController: default child view controller
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
        
        // add as a child view
        rootViewController.willMove(toParent: self)
        addChild(rootViewController)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootViewController.view.backgroundColor = .clear
        titleBar.backgroundColor = .clear
    }
    
    deinit {
        titleToken?.invalidate()
    }
    
    private func setup() {
        
        // 1) add child in view hierarchy
        view.addSubview(rootViewController.view)
        rootViewController.didMove(toParent: self)
                
        // 2) add title
        titleBar.setContentHuggingPriority(.required, for: .vertical)
        view.addSubview(titleBar)
        
        // 3) constraints
        rootViewController.view.translatesAutoresizingMaskIntoConstraints = false
        titleBar.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            rootViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootViewController.view.topAnchor.constraint(equalTo: titleBar.bottomAnchor),
            rootViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleBar.topAnchor.constraint(equalTo: view.topAnchor),
            titleBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        // observe title update
        titleBar.title = rootViewController.title
        titleToken = rootViewController.observe(\.title, changeHandler: { [weak self] (_, change) in
            guard let title = change.newValue else { return }
            self?.titleBar.title = title
        })
        
        // handle action button event
        titleBar.actionButton.addTarget(self, action: #selector(handleTitleBarButtonAction), for: .touchUpInside)
        
        // set default frame
        view.frame = UIScreen.main.bounds
        
        // set default background
        updateBackgroundViewIfNeeded()
        
        // observe close action
        titleBar.actionStyle = preferredTitleBarActionStyle ?? rootViewController.preferredTitleBarActionStyle ?? .hidden
        titleBar.isGrabberHidden = preferredTitleBarGrabberHidden ?? rootViewController.preferredTitleBarGrabberHidden ?? false
    }
    
    private func updateBackgroundViewIfNeeded(oldView: UIView? = nil) {
        oldView?.removeFromSuperview()
        
        if let backgroundView = backgroundView,
           let view = viewIfLoaded {
            
            backgroundView.removeFromSuperview()
            view.insertSubview(backgroundView, at: 0)
            
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    @objc private func handleTitleBarButtonAction(_ sender: UIButton) {
        titleBarActionClosure?(self) ?? rootViewController.titleBarActionClosure?(rootViewController)
    }
}

// MARK:- TitleBarViewController tabbar
extension TitleBarViewController {
    public override var tabBarItem: UITabBarItem! {
        get { return rootViewController.tabBarItem }
        set { rootViewController.tabBarItem = newValue }
    }
}


// MARK:- UIViewController Accessibility
public extension UIViewController {
    var titleBarViewController: TitleBarViewController? { firstParent(of: TitleBarViewController.self) }
}
