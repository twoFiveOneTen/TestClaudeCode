//
//  PopupConfiguration.swift
//  TestClaudeCode
//
//  Created by zhangkangkang on 2025/8/5.
//

import UIKit

struct PopupButtonConfiguration {
    let title: String
    let titleColor: UIColor
    let backgroundColor: UIColor
    let action: () -> Void
    
    init(title: String, titleColor: UIColor = .systemBlue, backgroundColor: UIColor = .clear, action: @escaping () -> Void) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
}

struct PopupConfiguration {
    let title: String?
    let message: String?
    let buttons: [PopupButtonConfiguration]
    
    let backgroundColor: UIColor
    let cornerRadius: CGFloat
    let shadowOpacity: Float
    let overlayColor: UIColor
    let dismissOnOverlayTap: Bool
    
    init(title: String? = nil,
         message: String? = nil,
         buttons: [PopupButtonConfiguration],
         backgroundColor: UIColor = .systemBackground,
         cornerRadius: CGFloat = 12.0,
         shadowOpacity: Float = 0.2,
         overlayColor: UIColor = UIColor.black.withAlphaComponent(0.5),
         dismissOnOverlayTap: Bool = true) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowOpacity = shadowOpacity
        self.overlayColor = overlayColor
        self.dismissOnOverlayTap = dismissOnOverlayTap
    }
}