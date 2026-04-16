//
//  StaggerRevealCard.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct StaggerRevealCard: View {
    @ObservedObject var viewModel: PhysicsLabViewModel

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)

    var body: some View {
        PhysicsSectionContainer(title: "Stagger Reveal", icon: "square.grid.3x3.fill") {
            VStack(spacing: 16) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.tiles) { tile in
                        let isVisible = viewModel.visibleTileIDs.contains(tile.id)

                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(tile.color)
                            .frame(height: 54)
                            .opacity(isVisible ? 1 : 0.001)
                            .scaleEffect(isVisible ? 1 : 0.82)
                            .offset(
                                x: isVisible ? 0 : -10,
                                y: isVisible ? 0 : -10
                            )
                    }
                }

                HStack(spacing: 12) {
                    Button {
                        viewModel.revealTiles()
                    } label: {
                        Text("Reveal")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 10)
                            .background(
                                Capsule()
                                    .fill(AppTheme.accentGreen)
                            )
                    }
                    .buttonStyle(.plain)

                    Button {
                        viewModel.hideTiles()
                    } label: {
                        Text("Hide")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 10)
                            .background(
                                Capsule()
                                    .fill(AppTheme.mutedGray)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    let vm = PhysicsLabViewModel()

    return ZStack {
        AppTheme.screenBackground.ignoresSafeArea()
        StaggerRevealCard(viewModel: vm)
            .padding()
    }
    .task {
        vm.revealTiles()
    }
    .preferredColorScheme(.light)
}
