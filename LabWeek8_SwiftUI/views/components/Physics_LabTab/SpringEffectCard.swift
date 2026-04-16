//
//  SpringEffectCard.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct SpringEffectCard: View {
    @ObservedObject var viewModel: PhysicsLabViewModel
    @State private var circleOffset: CGFloat = -12

    var body: some View {
        PhysicsSectionContainer(title: "Spring Effect", icon: "tornado") {
            GeometryReader { proxy in
                let trackTravel = max(proxy.size.width - 70, 0)

                VStack(spacing: 18) {
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.18))
                            .frame(height: 8)

                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [AppTheme.accentPurple, Color(red: 0.662, green: 0.227, blue: 0.874)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 26, height: 26)
                            .offset(x: circleOffset)
                    }
                    .frame(height: 28)

                    Button {
                        launchSpring(travelDistance: trackTravel)
                    } label: {
                        Text("Launch Spring")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [AppTheme.accentPurple, Color(red: 0.662, green: 0.227, blue: 0.874)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .frame(height: 104)
        }
    }

    private func launchSpring(travelDistance: CGFloat) {
        var noAnimation = Transaction()
        noAnimation.animation = nil

        withTransaction(noAnimation) {
            circleOffset = travelDistance
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            withAnimation(.interpolatingSpring(stiffness: 65, damping: 6)) {
                circleOffset = -12
            }
        }
    }
}

#Preview {
    ZStack {
        AppTheme.screenBackground.ignoresSafeArea()
        SpringEffectCard(viewModel: PhysicsLabViewModel())
            .padding()
    }
    .preferredColorScheme(.light)
}
