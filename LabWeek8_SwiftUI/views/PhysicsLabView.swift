//
//  PhysicsLabView.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct PhysicsLabView: View {
    @ObservedObject var viewModel: PhysicsLabViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Physics Lab")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .foregroundStyle(.black.opacity(0.92))

                SpringEffectCard(viewModel: viewModel)
                ParticleBurstCard(viewModel: viewModel)
                StaggerRevealCard(viewModel: viewModel)
                MorphShapeCard(viewModel: viewModel)
                FlipCardSection(viewModel: viewModel)
            }
            .padding(.horizontal, 20)
            .padding(.top, 22)
            .padding(.bottom, 28)
        }
        .background(AppTheme.screenBackground.ignoresSafeArea())
    }
}

#Preview {
    PhysicsLabView(viewModel: PhysicsLabViewModel())
        .preferredColorScheme(.light)
}
