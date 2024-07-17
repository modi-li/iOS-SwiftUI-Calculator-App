//
//  Colors.swift
//  iOS-SwiftUI-Calculator-App
//
//  Created by Modi (Victor) Li
//

import SwiftUI

struct Colors {
    
    static let tint1 = colorFromRGB(red: 60, green: 72, blue: 80)
    static let tint2 = colorFromRGB(red: 244, green: 122, blue: 95)
    static let tint3 = colorFromRGB(red: 100, green: 118, blue: 168)
    static let tint4 = colorFromRGB(red: 58, green: 118, blue: 122)
        
}

func colorFromRGB(red: Int, green: Int, blue: Int, opacity: Double = 1.0) -> Color {
    return Color(red: Double(red)/255, green: Double(green)/255, blue: Double(blue)/255, opacity: opacity)
}
