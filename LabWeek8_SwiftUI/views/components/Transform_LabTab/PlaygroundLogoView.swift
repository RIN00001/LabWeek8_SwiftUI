//
//  PlaygroundLogoView.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct PlaygroundLogoView: View {
    var size: CGFloat = 92
    var showsPlate: Bool = true

    var body: some View {
        ZStack {
            if showsPlate {
                RoundedRectangle(cornerRadius: size * 0.24, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [AppTheme.transformLogoStart, AppTheme.transformLogoEnd],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .shadow(color: AppTheme.accentPurple.opacity(0.18), radius: 16, x: 0, y: 8)
            }

            Image(systemName: "sparkles")
                .font(.system(size: showsPlate ? size * 0.42 : size, weight: .semibold))
                .foregroundStyle(.white)
                .symbolRenderingMode(.monochrome)
                .shadow(color: .white.opacity(0.18), radius: 4)
        }
    }
}

#Preview("Transform Logo") {
    ZStack {
        AppTheme.previewBackground.ignoresSafeArea()
        PlaygroundLogoView()
    }
    .preferredColorScheme(.light)
}

#Preview("Splash Logo") {
    ZStack {
        Color.black.ignoresSafeArea()
        PlaygroundLogoView(size: 54, showsPlate: false)
    }
    .preferredColorScheme(.light)
}
