//
//  GrabberView.swift
//  CDAffectedAnatomyApp
//
//  Created by Divyesh Makwana on 4/15/21.
//  Copyright © 2021 Pacific Communications. All rights reserved.
//

import UIKit

class GrabberView: UIView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 36, height: 5)
    }

    var barColor = UIColor(displayP3Red: 0.76, green: 0.77, blue: 0.76, alpha: 1.0) { didSet { backgroundColor = barColor } }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = barColor
        
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        render()
    }

    func render() {
        self.layer.masksToBounds = true
        layer.cornerRadius = bounds.size.height / 2
    }
}

// MARK:- container view
class GrabberContainerView: UIView {
    
    let grabberView = GrabberView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubview(grabberView)
        
        grabberView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grabberView.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            grabberView.centerXAnchor.constraint(equalTo: centerXAnchor),
            grabberView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
                
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 16).priority(.medium)
        ])
    }
}
