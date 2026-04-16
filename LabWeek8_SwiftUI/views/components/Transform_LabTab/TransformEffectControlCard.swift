//
//  TransformEffectControlCard.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct TransformEffectControlCard: View {
    let icon: String
    let title: String
    let valueText: String
    let tint: Color
    @Binding var toggleOn: Bool
    @Binding var sliderValue: Double
    let range: ClosedRange<Double>

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.85))

                Text(title)
                    .font(.system(size: 15, weight: .semibold))

                Spacer()

                Toggle("", isOn: $toggleOn)
                    .labelsHidden()
                    .tint(AppTheme.accentPurple)
                    .scaleEffect(0.95)
            }

            Text(valueText)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.secondary)

            Slider(value: $sliderValue, in: range)
                .tint(tint)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(AppTheme.cardBackground)
                .shadow(color: AppTheme.shadowColor, radius: 12, x: 0, y: 6)
        )
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var toggle = true
        @State private var value = 1.0

        var body: some View {
            ZStack {
                AppTheme.screenBackground.ignoresSafeArea()

                TransformEffectControlCard(
                    icon: "arrow.up.left.and.arrow.down.right",
                    title: "Scale",
                    valueText: "Scale: 1,00x",
                    tint: AppTheme.scaleTint,
                    toggleOn: $toggle,
                    sliderValue: $value,
                    range: 0.6...2.0
                )
                .padding()
            }
        }
    }

    return PreviewWrapper()
        .preferredColorScheme(.light)
}
