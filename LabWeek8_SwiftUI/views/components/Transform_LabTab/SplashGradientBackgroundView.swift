//
//  SplashGradientBackgroundView.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct SplashGradientBackgroundView: View {
    @State private var rotation: Double = 0

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                LinearGradient(
                    colors: [
                        AppTheme.splashTeal,
                        AppTheme.splashBlue
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                AngularGradient(
                    colors: [
                        .clear,
                        AppTheme.splashTeal.opacity(0.80),
                        AppTheme.splashPurple.opacity(0.95),
                        AppTheme.splashBlue.opacity(0.85),
                        .clear
                    ],
                    center: UnitPoint(x: 0.50, y: 0.56)
                )
                .frame(
                    width: proxy.size.width * 1.6,
                    height: proxy.size.width * 1.6
                )
                .rotationEffect(.degrees(rotation))
                .blur(radius: 24)
                .blendMode(.plusLighter)

                RadialGradient(
                    colors: [
                        .white.opacity(0.24),
                        .white.opacity(0.10),
                        .clear
                    ],
                    center: UnitPoint(x: 0.50, y: 0.56),
                    startRadius: 0,
                    endRadius: 180
                )

                Circle()
                    .fill(AppTheme.splashPurple.opacity(0.28))
                    .frame(width: 260, height: 260)
                    .blur(radius: 80)
                    .offset(x: proxy.size.width * 0.26, y: -proxy.size.height * 0.16)

                Circle()
                    .fill(AppTheme.splashTeal.opacity(0.26))
                    .frame(width: 290, height: 290)
                    .blur(radius: 90)
                    .offset(x: -proxy.size.width * 0.30, y: proxy.size.height * 0.08)
            }
            .ignoresSafeArea()
            .drawingGroup()
            .onAppear {
                withAnimation(.linear(duration: 18).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
        }
    }
}

#Preview {
    SplashGradientBackgroundView()
}
