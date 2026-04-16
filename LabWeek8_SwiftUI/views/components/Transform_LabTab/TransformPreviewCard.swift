//
//  TransformPreviewCard.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI
import Combine
struct TransformPreviewCard: View {
    @ObservedObject var viewModel: TransformLabViewModel

    var body: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(AppTheme.previewBackground)
            .frame(height: 190)
            .overlay {
                TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { context in
                    PlaygroundLogoView(size: 92, showsPlate: true)
                        .hueRotation(.degrees(viewModel.effectiveHue(at: context.date)))
                        .scaleEffect(viewModel.effectiveScale(at: context.date))
                        .rotationEffect(.degrees(viewModel.effectiveRotation(at: context.date)))
                        .opacity(viewModel.effectiveOpacity(at: context.date))
                        .animation(.none, value: context.date)
                }
            }
    }
}

#Preview {
    ZStack {
        AppTheme.screenBackground.ignoresSafeArea()
        TransformPreviewCard(viewModel: TransformLabViewModel())
            .padding()
    }
    .preferredColorScheme(.light)
}
