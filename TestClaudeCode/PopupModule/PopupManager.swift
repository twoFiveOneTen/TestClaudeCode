//
//  PopupManager.swift
//  TestClaudeCode
//
//  Created by zhangkangkang on 2025/8/5.
//

import UIKit

class PopupManager {
    
    static let shared = PopupManager()
    
    private var currentPopup: PopupView?
    
    private init() {}
    
    func show(configuration: PopupConfiguration, in viewController: UIViewController? = nil) {
        dismiss()
        
        let targetViewController = viewController ?? getCurrentViewController()
        guard let viewController = targetViewController else {
            Logger.log { "PopupManager: No view controller available to present popup" }
            return
        }
        
        let popupView = PopupView()
        popupView.configure(with: configuration)
        
        if configuration.dismissOnOverlayTap {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(overlayTapped(_:)))
            popupView.addGestureRecognizer(tapGesture)
        }
        
        viewController.view.addSubview(popupView)
        popupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        currentPopup = popupView
        
        popupView.alpha = 0
        popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
            popupView.alpha = 1
            popupView.transform = .identity
        }
    }
    
    private func getCurrentViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return nil
        }
        return window.rootViewController
    }
    
    func dismiss(completion: (() -> Void)? = nil) {
        guard let popup = currentPopup else {
            completion?()
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            popup.alpha = 0
            popup.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            popup.removeFromSuperview()
            completion?()
        })
        
        currentPopup = nil
    }
    
    @objc private func overlayTapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        guard let popupView = gesture.view as? PopupView else { return }
        
        let containerFrame = popupView.subviews.first?.frame ?? .zero
        if !containerFrame.contains(location) {
            dismiss()
        }
    }
}
