//
//  PhysicsSectionContainer.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct PhysicsSectionContainer<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.85))

                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.92))
            }

            content
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(AppTheme.cardBackground)
                .shadow(color: AppTheme.shadowColor, radius: 12, x: 0, y: 6)
        )
    }
}

#Preview {
    ZStack {
        AppTheme.screenBackground.ignoresSafeArea()

        PhysicsSectionContainer(title: "Sample Card", icon: "star.fill") {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.previewBackground)
                .frame(height: 120)
        }
        .padding()
    }
    .preferredColorScheme(.light)
}
