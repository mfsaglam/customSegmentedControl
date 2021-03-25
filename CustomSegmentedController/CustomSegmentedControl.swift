//
//  CustomSegmentedControl.swift
//  CustomSegmentedController
//
//  Created by Fatih Sağlam on 24.03.2021.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl {
    
    var selectedSegmentIndex = 0
    var buttons = [UIButton]()
    var selector: UIView!
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    var selectorStyle: SelectorStyle = .rounded {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeperatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var buttonColor: UIColor = .systemGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    func setSelector() {
        switch selectorStyle {
        case .rounded:
            let selectorWidth = frame.width / CGFloat(buttons.count)
            selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
            selector.layer.cornerRadius = selector.frame.height / 2
            selector.backgroundColor = selectorColor
            addSubview(selector)
        case .underBar:
            borderWidth = 0
            let selectorWidth = frame.width / CGFloat(buttons.count)
            let selectorHeight = frame.height * 0.1
            selector = UIView(frame: CGRect(x: 0, y: frame.height - selectorHeight, width: selectorWidth, height: selectorHeight))
            selector.backgroundColor = selectorColor
            addSubview(selector)
        case .highlightedOnly:
            borderWidth = 0
        }
    }
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(buttonColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        setSelector()
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = layer.frame.size.height / 2
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(buttonColor, for: .normal)
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
}

enum SelectorStyle {
    case rounded
    case underBar
    case highlightedOnly
}
