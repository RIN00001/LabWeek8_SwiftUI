//
//  SplashView.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct SplashView: View {
    let onEnter: () -> Void

    @State private var logoVisible = false
    @State private var titleVisible = false
    @State private var buttonVisible = false
    @State private var pulseButton = false
    @State private var isPressed = false

    var body: some View {
        ZStack {
            SplashGradientBackgroundView()
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 26) {
                    PlaygroundLogoView(size: 72, showsPlate: false)
                        .scaleEffect(logoVisible ? 1.0 : 0.12)
                        .rotationEffect(.degrees(logoVisible ? 0 : -260))
                        .opacity(logoVisible ? 1 : 0)

                    VStack(spacing: 6) {
                        Text("Animation")
                            .font(.system(size: 34, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Playground")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white.opacity(0.82))
                    }
                    .opacity(titleVisible ? 1 : 0)
                    .scaleEffect(titleVisible ? 1.0 : 0.82)
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
                .scaleEffect(
                    isPressed ? 0.96 :
                    (buttonVisible ? (pulseButton ? 1.05 : 1.0) : 0.2)
                )
                .opacity(buttonVisible ? 1 : 0)
                .padding(.bottom, 72)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.62)) {
                logoVisible = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.62) {
                withAnimation(.easeOut(duration: 0.34)) {
                    titleVisible = true
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.82) {
                withAnimation(.easeOut(duration: 0.24)) {
                    buttonVisible = true
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.08) {
                withAnimation(.easeInOut(duration: 1.35).repeatForever(autoreverses: true)) {
                    pulseButton = true
                }
            }
        }
    }
}

#Preview {
    SplashView(onEnter: {})
        .preferredColorScheme(.light)
}
