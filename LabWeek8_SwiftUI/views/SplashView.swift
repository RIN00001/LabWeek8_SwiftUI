//
//  SplashView.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct SplashView: View {
    let onEnter: () -> Void

    @State private var showLogo = false
    @State private var showTitle = false
    @State private var showButton = false
    @State private var pulseButton = false
    @State private var isPressed = false

    var body: some View {
        ZStack {
            SplashGradientBackgroundView()

            VStack {
                Spacer()

                VStack(spacing: 18) {
                    PlaygroundLogoView(size: 54, showsPlate: false)
                        .scaleEffect(showLogo ? 1 : 0.15)
                        .rotationEffect(.degrees(showLogo ? 0 : -300))
                        .opacity(showLogo ? 1 : 0)

                    VStack(spacing: 4) {
                        Text("Animation")
                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Playground")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white.opacity(0.82))
                    }
                    .opacity(showTitle ? 1 : 0)
                    .scaleEffect(showTitle ? 1 : 0.84)
                }

                Spacer()

                Button {
                    guard !isPressed else { return }

                    isPressed = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                        onEnter()
                    }
                } label: {
                    HStack(spacing: 10) {
                        Text("Enter Playground")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.black.opacity(0.86))

                        ZStack {
                            Circle()
                                .fill(Color.black)

                            Image(systemName: "arrow.right")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .frame(width: 20, height: 20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 15)
                    .background(
                        Capsule()
                            .fill(.white)
                    )
                    .shadow(
                        color: .white.opacity(pulseButton ? 0.28 : 0.08),
                        radius: pulseButton ? 22 : 8,
                        x: 0,
                        y: 0
                    )
                }
                .buttonStyle(.plain)
                .scaleEffect(isPressed ? 0.96 : (pulseButton ? 1.05 : 1.0))
                .opacity(showButton ? 1 : 0)
                .offset(y: showButton ? 0 : 18)
                .padding(.bottom, 70)
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            withAnimation(.spring(response: 0.92, dampingFraction: 0.70)) {
                showLogo = true
            }

            withAnimation(.spring(response: 0.72, dampingFraction: 0.84).delay(0.48)) {
                showTitle = true
            }

            withAnimation(.spring(response: 0.70, dampingFraction: 0.84).delay(0.84)) {
                showButton = true
            }

            withAnimation(.easeInOut(duration: 1.35).repeatForever(autoreverses: true).delay(1.05)) {
                pulseButton = true
            }
        }
    }
}

#Preview {
    SplashView(onEnter: {})
        .preferredColorScheme(.light)
}
