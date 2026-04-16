//
//  ContentView.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var transformViewModel = TransformLabViewModel()
    @StateObject private var physicsViewModel = PhysicsLabViewModel()

    var body: some View {
        TabView {
            TransformLabTabView(viewModel: transformViewModel)
                .tabItem {
                    Label("Transform Lab", systemImage: "wand.and.stars")
                }

            PhysicsLabView(viewModel: physicsViewModel)
                .tabItem {
                    Label("Physics Lab", systemImage: "bolt.fill")
                }
        }
        .tint(AppTheme.accentPurple)
        .background(AppTheme.screenBackground.ignoresSafeArea())
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
}
