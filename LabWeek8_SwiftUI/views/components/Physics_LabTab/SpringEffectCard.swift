//
//  SpringEffectCard.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct SpringEffectCard: View {
    @ObservedObject var viewModel: PhysicsLabViewModel

    var body: some View {
        PhysicsSectionContainer(title: "Spring Effect", icon: "tornado") {
            VStack(spacing: 18) {
                GeometryReader { proxy in
                    let travelWidth = max(proxy.size.width - 28, 0)

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
                            .offset(x: travelWidth * viewModel.springProgress)
                            .animation(.none, value: viewModel.springProgress)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .frame(height: 28)

                Button {
                    viewModel.launchSpring()
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
