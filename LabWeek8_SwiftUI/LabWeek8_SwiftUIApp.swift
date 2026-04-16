//
//  LabWeek8_SwiftUIApp.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

@main
struct LabWeek8_SwiftUIApp: App {
    @State private var hasEnteredApp = false

    var body: some Scene {
        WindowGroup {
            Group {
                if hasEnteredApp {
                    ContentView()
                        .transition(.opacity)
                } else {
                    SplashView {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            hasEnteredApp = true
                        }
                    }
                }
            }
        }
    }
}
