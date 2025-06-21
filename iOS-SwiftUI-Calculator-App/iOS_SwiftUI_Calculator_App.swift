//
//  iOS_SwiftUI_Calculator_App.swift
//  iOS-SwiftUI-Calculator-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI

@main
struct iOS_SwiftUI_Calculator_App: App {
    
    @State private var globalEnvironment = GlobalEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(globalEnvironment)
        }
    }
}
