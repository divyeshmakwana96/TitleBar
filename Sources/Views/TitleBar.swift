//
//  TitleBar.swift
//  CDAffectedAnatomyApp
//
//  Created by Divyesh Makwana on 3/3/21.
//  Copyright © 2021 Pacific Communications. All rights reserved.
//

import UIKit

public class TitleBar: UIView {
    
    // MARK:- Action Styles
    public enum ActionStyle {
        case close
        case custom(UIImage?)
        case hidden
    }
    
    private let divider = DividerView()
    private let stackview = UIStackView()
    private let titleLabel = UILabel()
    let actionButton = Button(type: .system)
    
    private let grabberContainerView = GrabberContainerView()
    
    public var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    public var attributedTitle: NSAttributedString? {
        get { titleLabel.attributedText }
        set { titleLabel.attributedText = newValue }
    }
    
    public var isActionButtonHidden: Bool {
        get { actionButton.isHidden }
        set { actionButton.isHidden = newValue }
    }
    
    public var actionButtonImage: UIImage? {
        get { actionButton.image(for: .normal) }
        set { actionButton.setImage(newValue, for: .normal) }
    }
    
    public var isGrabberHidden: Bool {
        get { grabberContainerView.isHidden }
        set { grabberContainerView.isHidden = newValue }
    }
    
    public var accessoryView: UIView? {
        didSet {
            if let oldAccessoryView = oldValue {
                oldAccessoryView.removeFromSuperview()
            }
            
            // add new
            if let accessoryView = accessoryView {
                stackview.addArrangedSubview(accessoryView)
            }
        }
    }
    
    public var actionStyle: TitleBar.ActionStyle = .close {
        didSet {
            switch actionStyle {
            case .close:
                isActionButtonHidden = false
                actionButtonImage = UIImage(systemName: "xmark.circle.fill")
                break
            case .custom(let image):
                isActionButtonHidden = false
                actionButtonImage = image
                break
            case .hidden:
                isActionButtonHidden = true
                actionButtonImage = nil
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        // title + close button
        tintColor = .secondaryLabel
        
        var fontDecriptor = UIFont.preferredFont(forTextStyle: .title2).fontDescriptor
        fontDecriptor = fontDecriptor.withSymbolicTraits(.traitBold)!
        titleLabel.font = UIFont(descriptor: fontDecriptor, size: 0)
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        let titleContainerView = UIView()
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(actionButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 21),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 15).priority(.almostRequired),
            titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -15).priority(.almostRequired)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 30).priority(.almostRequired),
            actionButton.widthAnchor.constraint(equalToConstant: 30).priority(.almostRequired),
            
            actionButton.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -20),
            actionButton.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor),
        ])
        
        
        // vertical stacking
        stackview.axis = .vertical
        stackview.setContentHuggingPriority(.required, for: .vertical)
        stackview.addArrangedSubview(grabberContainerView)
        stackview.addArrangedSubview(titleContainerView)
        addSubview(stackview)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // divider
        addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor).priority(.required)
        ])
    }
}

class Button: UIButton {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 30, height: 30)
    }
}
