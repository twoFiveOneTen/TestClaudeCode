//
//  PopupButton.swift
//  TestClaudeCode
//
//  Created by zhangkangkang on 2025/8/5.
//

import UIKit

class PopupButton: UIButton {
    
    private var buttonConfiguration: PopupButtonConfiguration?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = 8.0
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func configure(with configuration: PopupButtonConfiguration) {
        self.buttonConfiguration = configuration
        setTitle(configuration.title, for: .normal)
        setTitleColor(configuration.titleColor, for: .normal)
        backgroundColor = configuration.backgroundColor
        
        if configuration.backgroundColor == .clear {
            layer.borderWidth = 1.0
            layer.borderColor = configuration.titleColor.cgColor
        } else {
            layer.borderWidth = 0
        }
    }
    
    @objc private func buttonTapped() {
        buttonConfiguration?.action()
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1.0
        }
    }
}
