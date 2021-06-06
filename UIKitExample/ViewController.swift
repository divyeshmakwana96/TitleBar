//
//  ViewController.swift
//  UIKitExample
//
//  Created by Divyesh Makwana on 6/3/21.
//

import UIKit
import MapKit
import FloatingPanel
import TitleBar

class ViewController: UIViewController {
    
    let fpc = FloatingPanelController()
    let tabbar = UITabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mapview = MKMapView()
        view.addSubview(mapview)
        
        mapview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapview.topAnchor.constraint(equalTo: view.topAnchor),
            mapview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // floating panel
        fpc.delegate = self
        fpc.contentMode = .fitToBounds
        fpc.surfaceView.appearance = .default
        fpc.surfaceView.containerMargins = .zero
        
        // title bar view controller
        let tableViewController = TableViewController(style: .insetGrouped)
        fpc.set(contentViewController: TitleBarViewController(rootViewController: tableViewController))
        fpc.addPanel(toParent: self)
                
        // tabbar
        tabbar.items = [
            UITabBarItem(tabBarSystemItem: .favorites, tag: 0),
            UITabBarItem(tabBarSystemItem: .more, tag: 1),
        ]
        view.addSubview(tabbar)
        
        tabbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fpc.additionalSafeAreaInsets.bottom = tabbar.frame.height
    }
}

// MARK:- Floating panel controller delegate
extension ViewController: FloatingPanelControllerDelegate {
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        
        vc.surfaceView.containerMargins = UIEdgeInsets(top: .leastNonzeroMagnitude, // For top left/right rounding corners
                                                       left: 0,
                                                       bottom: 0,
                                                       right: 0.0)
        return PanelLayout()
    }
}

// MARK:- Panel layout
class PanelLayout: FloatingPanelLayout {
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 53, edge: .bottom, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 452, edge: .bottom, referenceGuide: .superview),
            .full: FloatingPanelLayoutAnchor(absoluteInset: 30, edge: .top, referenceGuide: .safeArea)
        ]
    }
    
    func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            surfaceView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ]
    }
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}


// MARK:- Surface Appearance
extension SurfaceAppearance {
    
    static let `default` = SurfaceAppearance.defaultAppearance()
    
    private class func defaultAppearance() -> SurfaceAppearance {
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 16.0
        
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 8)
        shadow.radius = 16
        shadow.spread = 4
        appearance.shadows = [shadow]
        appearance.backgroundColor = .clear
        return appearance
    }
}
