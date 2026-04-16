//
//  FlipCardSection.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct FlipCardSection: View {
    @ObservedObject var viewModel: PhysicsLabViewModel

    var body: some View {
        PhysicsSectionContainer(title: "3D Flip Card", icon: "scale.3d") {
            VStack(spacing: 18) {
                ZStack {
                    FlipCardFace(
                        title: "Front",
                        icon: "creditcard.fill",
                        gradientColors: [
                            Color(red: 0.282, green: 0.533, blue: 0.949),
                            Color(red: 0.741, green: 0.294, blue: 0.910)
                        ]
                    )
                    .opacity(viewModel.isCardFlipped ? 0 : 1)
                    .rotation3DEffect(
                        .degrees(viewModel.isCardFlipped ? 180 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )

                    FlipCardFace(
                        title: "Back",
                        icon: "checkmark.seal.fill",
                        gradientColors: [
                            Color(red: 0.933, green: 0.573, blue: 0.239),
                            Color(red: 0.953, green: 0.272, blue: 0.358)
                        ]
                    )
                    .opacity(viewModel.isCardFlipped ? 1 : 0)
                    .rotation3DEffect(
                        .degrees(viewModel.isCardFlipped ? 0 : -180),
                        axis: (x: 0, y: 1, z: 0)
                    )
                }
                .frame(height: 170)

                Button {
                    viewModel.toggleFlip()
                } label: {
                    Text(viewModel.isCardFlipped ? "Flip Back" : "Flip Card")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 11)
                        .background(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.933, green: 0.573, blue: 0.239),
                                            Color(red: 0.898, green: 0.478, blue: 0.153)
                                        ],
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

private struct FlipCardFace: View {
    let title: String
    let icon: String
    let gradientColors: [Color]

    var body: some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(
                LinearGradient(
                    colors: gradientColors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .overlay {
                VStack(spacing: 10) {
                    Image(systemName: icon)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)

                    Text(title)
                        .font(.system(size: 19, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
    }
}

#Preview {
    ZStack {
        AppTheme.screenBackground.ignoresSafeArea()
        FlipCardSection(viewModel: PhysicsLabViewModel())
            .padding()
    }
    .preferredColorScheme(.light)
}
