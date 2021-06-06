//
//  DividerView.swift
//  CDAffectedAnatomyApp
//
//  Created by Divyesh Makwana on 3/3/21.
//  Copyright © 2021 Pacific Communications. All rights reserved.
//

import UIKit

class DividerView: UIView {
    
    enum Axis {
        case horizontal
        case vertical
    }
    
    // MARK: - Properties
    var axis: DividerView.Axis = .horizontal {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    var isVertical: Bool {
        get { axis == .vertical }
        set { axis = (newValue ? .vertical : .horizontal) }
    }
    
    var color: UIColor? {
        get { backgroundColor }
        set { backgroundColor = newValue }
    }
    
    private var thickness: CGFloat = 1 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    // MARK: - Methods
    convenience init(axis: DividerView.Axis) {
        self.init(frame: .zero)
        self.axis = axis
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .separator
        setupRequiredContentHuggingPriority()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .separator
        setupRequiredContentHuggingPriority()
    }
    
    private func setupRequiredContentHuggingPriority() {
        setContentHuggingPriority(.required, for: .vertical)
        setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func updateThicknessForWindow(_ window: UIWindow?) {
        let screen = window?.screen ?? UIScreen.main
        thickness = 1 / screen.scale
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        updateThicknessForWindow(newWindow)
    }
    
    override var intrinsicContentSize : CGSize {
        var size = CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
        
        switch axis {
        case .horizontal:
            size.height = thickness
        case .vertical:
            size.width = thickness
        }
        return size
    }
}
