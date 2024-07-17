//
//  UIWindow+Extension.swift
//  iOS-SwiftUI-Calculator-App
//
//  Created by Modi (Victor) Li
//

import SwiftUI

extension UIWindow {
    
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow {
                    return window
                }
            }
        }
        return nil
    }
    
}
