//
//  TransformLabTabView.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//
import SwiftUI

struct TransformLabTabView: View {
    @ObservedObject var viewModel: TransformLabViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Transform Lab")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .foregroundStyle(.black.opacity(0.92))

                TransformPreviewCard(viewModel: viewModel)

                TransformEffectControlCard(
                    icon: "arrow.up.left.and.arrow.down.right",
                    title: "Scale",
                    valueText: viewModel.scaleLabel,
                    tint: AppTheme.scaleTint,
                    toggleOn: $viewModel.isBreathingScale,
                    sliderValue: $viewModel.scale,
                    range: 0.6...2.0
                )

                TransformEffectControlCard(
                    icon: "arrow.clockwise",
                    title: "Rotation",
                    valueText: viewModel.rotationLabel,
                    tint: AppTheme.rotationTint,
                    toggleOn: $viewModel.isSpinning,
                    sliderValue: $viewModel.rotation,
                    range: -180...180
                )

                TransformEffectControlCard(
                    icon: "circle.lefthalf.filled.inverse",
                    title: "Opacity",
                    valueText: viewModel.opacityLabel,
                    tint: AppTheme.opacityTint,
                    toggleOn: $viewModel.isBreathingOpacity,
                    sliderValue: $viewModel.opacity,
                    range: 0.1...1.0
                )

                TransformEffectControlCard(
                    icon: "paintpalette.fill",
                    title: "Color / Hue",
                    valueText: viewModel.hueLabel,
                    tint: AppTheme.hueTint,
                    toggleOn: $viewModel.isBreathingHue,
                    sliderValue: $viewModel.hue,
                    range: 0...360
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 22)
            .padding(.bottom, 28)
        }
        .background(AppTheme.screenBackground.ignoresSafeArea())
    }
}

#Preview {
    TransformLabTabView(viewModel: TransformLabViewModel())
        .preferredColorScheme(.light)
}
