//
//  PopupView.swift
//  TestClaudeCode
//
//  Created by zhangkangkang on 2025/8/5.
//

import UIKit
import SnapKit

class PopupView: UIView {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let buttonStackView = UIStackView()
    
    private var configuration: PopupConfiguration?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        setupContainerView()
        setupTitleLabel()
        setupMessageLabel()
        setupButtonStackView()
        setupConstraints()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.layer.cornerRadius = 12.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.2
    }
    
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label
    }
    
    private func setupMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .secondaryLabel
    }
    
    private func setupButtonStackView() {
        containerView.addSubview(buttonStackView)
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 12
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().offset(40)
            make.right.lessThanOrEqualToSuperview().offset(-40)
            make.width.greaterThanOrEqualTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
    }
    
    func configure(with configuration: PopupConfiguration) {
        self.configuration = configuration
        
        backgroundColor = configuration.overlayColor
        containerView.backgroundColor = configuration.backgroundColor
        containerView.layer.cornerRadius = configuration.cornerRadius
        containerView.layer.shadowOpacity = configuration.shadowOpacity
        
        if let title = configuration.title, !title.isEmpty {
            titleLabel.text = title
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
        
        if let message = configuration.message, !message.isEmpty {
            messageLabel.text = message
            messageLabel.isHidden = false
        } else {
            messageLabel.isHidden = true
        }
        
        setupButtons(configuration.buttons)
        updateConstraintsForVisibleElements()
    }
    
    private func setupButtons(_ buttonConfigs: [PopupButtonConfiguration]) {
        buttonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for buttonConfig in buttonConfigs {
            let button = PopupButton()
            button.configure(with: buttonConfig)
            buttonStackView.addArrangedSubview(button)
        }
        
        if buttonConfigs.count > 2 {
            buttonStackView.axis = .vertical
            buttonStackView.spacing = 8
            buttonStackView.snp.updateConstraints { make in
                make.height.equalTo(buttonConfigs.count * 44 + (buttonConfigs.count - 1) * 8)
            }
        } else {
            buttonStackView.axis = .horizontal
            buttonStackView.spacing = 12
            buttonStackView.snp.updateConstraints { make in
                make.height.equalTo(44)
            }
        }
    }
    
    private func updateConstraintsForVisibleElements() {
        let titleVisible = !titleLabel.isHidden
        let messageVisible = !messageLabel.isHidden
        
        if titleVisible && messageVisible {
            return
        } else if titleVisible && !messageVisible {
            buttonStackView.snp.remakeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(24)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.bottom.equalToSuperview().offset(-20)
                make.height.greaterThanOrEqualTo(44)
            }
        } else if !titleVisible && messageVisible {
            messageLabel.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(24)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
            }
        } else {
            buttonStackView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(24)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.bottom.equalToSuperview().offset(-20)
                make.height.greaterThanOrEqualTo(44)
            }
        }
    }
}
