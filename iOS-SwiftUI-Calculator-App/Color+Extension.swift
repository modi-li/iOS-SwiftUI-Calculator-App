//
//  Color+Extension.swift
//  iOS-SwiftUI-Calculator-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI

extension Color {
    
    static func fromRGB(red: Double, green: Double, blue: Double) -> Color {
        return Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }
    
    static let tint1 = fromRGB(red: 60, green: 72, blue: 80)
    
    static let tint2 = fromRGB(red: 244, green: 122, blue: 95)
    
    static let tint3 = fromRGB(red: 100, green: 118, blue: 168)
    
    static let tint4 = fromRGB(red: 58, green: 118, blue: 122)
}
