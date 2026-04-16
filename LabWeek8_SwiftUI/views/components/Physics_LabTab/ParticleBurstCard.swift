//
//  ParticleBurstCard.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct ParticleBurstCard: View {
    @ObservedObject var viewModel: PhysicsLabViewModel

    var body: some View {
        PhysicsSectionContainer(title: "Particle Burst", icon: "sparkle") {
            ZStack {
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(AppTheme.previewBackground)
                        .frame(height: 148)

                    Button {
                        viewModel.burstParticles()
                    } label: {
                        Label("Burst!", systemImage: "party.popper.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 10)
                            .background(
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 0.968, green: 0.358, blue: 0.421),
                                                Color(red: 0.941, green: 0.242, blue: 0.391)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }

                ZStack {
                    ForEach(viewModel.particles) { particle in
                        BurstParticleDot(particle: particle)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .allowsHitTesting(false)
            }
            .frame(height: 230)
        }
    }
}

private struct BurstParticleDot: View {
    let particle: ParticleModel
    @State private var animateOut = false

    var body: some View {
        Circle()
            .fill(particle.color)
            .frame(width: particle.size, height: particle.size)
            .offset(
                x: animateOut ? particle.x : 0,
                y: animateOut ? particle.y : 0
            )
            .opacity(animateOut ? 0 : 1)
            .onAppear {
                withAnimation(.easeOut(duration: particle.lifetime)) {
                    animateOut = true
                }
            }
    }
}

#Preview {
    let vm = PhysicsLabViewModel()

    return ZStack {
        AppTheme.screenBackground.ignoresSafeArea()
        ParticleBurstCard(viewModel: vm)
            .padding()
    }
    .task {
        vm.burstParticles()
    }
    .preferredColorScheme(.light)
}
