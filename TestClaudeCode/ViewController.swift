//
//  ViewController.swift
//  TestClaudeCode
//
//  Created by zhangkangkang on 2025/8/5.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let showClockButton = UIButton(type: .system)
    private let showPopupButton = UIButton(type: .system)
    private let showCustomPopupButton = UIButton(type: .system)
    private let showMultiButtonPopupButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        setupButtons()
        setupConstraints()
    }
    
    private func setupButtons() {
        showClockButton.setTitle("显示时钟", for: .normal)
        showClockButton.backgroundColor = .systemPurple
        showClockButton.setTitleColor(.white, for: .normal)
        showClockButton.layer.cornerRadius = 8
        showClockButton.addTarget(self, action: #selector(showClock), for: .touchUpInside)
        
        showPopupButton.setTitle("显示基础弹窗", for: .normal)
        showPopupButton.backgroundColor = .systemBlue
        showPopupButton.setTitleColor(.white, for: .normal)
        showPopupButton.layer.cornerRadius = 8
        showPopupButton.addTarget(self, action: #selector(showBasicPopup), for: .touchUpInside)
        
        showCustomPopupButton.setTitle("显示自定义弹窗", for: .normal)
        showCustomPopupButton.backgroundColor = .systemGreen
        showCustomPopupButton.setTitleColor(.white, for: .normal)
        showCustomPopupButton.layer.cornerRadius = 8
        showCustomPopupButton.addTarget(self, action: #selector(showCustomPopup), for: .touchUpInside)
        
        showMultiButtonPopupButton.setTitle("显示多按钮弹窗", for: .normal)
        showMultiButtonPopupButton.backgroundColor = .systemOrange
        showMultiButtonPopupButton.setTitleColor(.white, for: .normal)
        showMultiButtonPopupButton.layer.cornerRadius = 8
        showMultiButtonPopupButton.addTarget(self, action: #selector(showMultiButtonPopup), for: .touchUpInside)
        
        view.addSubview(showClockButton)
        view.addSubview(showPopupButton)
        view.addSubview(showCustomPopupButton)
        view.addSubview(showMultiButtonPopupButton)
    }
    
    private func setupConstraints() {
        showClockButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-140)
            make.width.equalTo(240)
            make.height.equalTo(54)
        }
        
        showPopupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(showClockButton.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        showCustomPopupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(showPopupButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        showMultiButtonPopupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(showCustomPopupButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
    
    @objc private func showBasicPopup() {
        let confirmButton = PopupButtonConfiguration(
            title: "确认",
            titleColor: .white,
            backgroundColor: .systemBlue
        ) {
            PopupManager.shared.dismiss()
        }
        
        let cancelButton = PopupButtonConfiguration(
            title: "取消"
        ) {
            PopupManager.shared.dismiss()
        }
        
        let configuration = PopupConfiguration(
            title: "提示",
            message: "这是一个基础的弹窗示例",
            buttons: [cancelButton, confirmButton]
        )
        
        PopupManager.shared.show(configuration: configuration, in: self)
    }
    
    @objc private func showCustomPopup() {
        let okButton = PopupButtonConfiguration(
            title: "好的",
            titleColor: .white,
            backgroundColor: .systemGreen
        ) {
            PopupManager.shared.dismiss()
        }
        
        let configuration = PopupConfiguration(
            title: "自定义样式",
            message: "这个弹窗使用了自定义的背景颜色和圆角",
            buttons: [okButton],
            backgroundColor: .systemGray6,
            cornerRadius: 20.0,
            shadowOpacity: 0.3,
            overlayColor: UIColor.systemBlue.withAlphaComponent(0.3)
        )
        
        PopupManager.shared.show(configuration: configuration, in: self)
    }
    
    @objc private func showMultiButtonPopup() {
        let button1 = PopupButtonConfiguration(
            title: "选项一",
            titleColor: .white,
            backgroundColor: .systemRed
        ) {
            PopupManager.shared.dismiss()
        }
        
        let button2 = PopupButtonConfiguration(
            title: "选项二",
            titleColor: .white,
            backgroundColor: .systemBlue
        ) {
            PopupManager.shared.dismiss()
        }
        
        let button3 = PopupButtonConfiguration(
            title: "选项三",
            titleColor: .white,
            backgroundColor: .systemGreen
        ) {
            PopupManager.shared.dismiss()
        }
        
        let configuration = PopupConfiguration(
            title: "多选项弹窗",
            message: "请选择一个选项",
            buttons: [button1, button2, button3],
            dismissOnOverlayTap: false
        )
        
        PopupManager.shared.show(configuration: configuration, in: self)
    }
    
    @objc private func showClock() {
        let clockViewController = ClockViewController()
        navigationController?.pushViewController(clockViewController, animated: true)
    }
}
