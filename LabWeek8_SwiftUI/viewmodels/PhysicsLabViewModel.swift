//
//  PhysicsLabViewModel.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI
import Combine

@MainActor
final class PhysicsLabViewModel: ObservableObject {
    @Published var springProgress: CGFloat = 0.0
    @Published var particles: [ParticleModel] = []
    @Published var visibleTileIDs: Set<UUID> = []
    @Published var morphProgress: Double = 0.0
    @Published var isCardFlipped: Bool = false

    let tiles: [StaggerTileModel] = [
        .init(row: 0, column: 0, color: Color(red: 0.939, green: 0.301, blue: 0.266)),
        .init(row: 0, column: 1, color: Color(red: 0.929, green: 0.576, blue: 0.239)),
        .init(row: 0, column: 2, color: Color(red: 0.937, green: 0.788, blue: 0.270)),

        .init(row: 1, column: 0, color: Color(red: 0.398, green: 0.760, blue: 0.369)),
        .init(row: 1, column: 1, color: Color(red: 0.359, green: 0.727, blue: 0.792)),
        .init(row: 1, column: 2, color: Color(red: 0.259, green: 0.502, blue: 0.910)),

        .init(row: 2, column: 0, color: Color(red: 0.388, green: 0.333, blue: 0.902)),
        .init(row: 2, column: 1, color: Color(red: 0.702, green: 0.247, blue: 0.847)),
        .init(row: 2, column: 2, color: Color(red: 0.933, green: 0.274, blue: 0.380))
    ]

    private let particlePalette: [Color] = [
        .red, .orange, .yellow, .green, .blue, .purple, .pink,
        Color(red: 0.298, green: 0.722, blue: 0.980),
        Color(red: 0.976, green: 0.643, blue: 0.211)
    ]

    func launchSpring() {
        springProgress = 1.0

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            withAnimation(.interpolatingSpring(stiffness: 140, damping: 10)) {
                self.springProgress = 0.0
            }
        }
    }

    func burstParticles() {
        let newParticles = (0..<20).map { _ in
            ParticleModel(
                x: CGFloat.random(in: -130...130),
                y: CGFloat.random(in: -85...55),
                size: CGFloat.random(in: 8...18),
                color: particlePalette.randomElement() ?? .orange,
                lifetime: Double.random(in: 0.85...1.35)
            )
        }

        let ids = newParticles.map(\.id)
        particles.append(contentsOf: newParticles)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            self.particles.removeAll { ids.contains($0.id) }
        }
    }

    func revealTiles() {
        visibleTileIDs.removeAll()

        for (index, tile) in diagonalRevealOrder.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(index) * 0.07)) {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                    _ = self.visibleTileIDs.insert(tile.id)
                }
            }
        }
    }

    func hideTiles() {
        for (index, tile) in diagonalRevealOrder.reversed().enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(index) * 0.06)) {
                withAnimation(.easeInOut(duration: 0.22)) {
                    _ = self.visibleTileIDs.remove(tile.id)
                }
            }
        }
    }

    func toggleFlip() {
        withAnimation(.easeInOut(duration: 0.65)) {
            isCardFlipped.toggle()
        }
    }

    private var diagonalRevealOrder: [StaggerTileModel] {
        tiles.sorted { lhs, rhs in
            let leftDiagonal = lhs.row + lhs.column
            let rightDiagonal = rhs.row + rhs.column

            if leftDiagonal != rightDiagonal {
                return leftDiagonal < rightDiagonal
            }

            if lhs.row != rhs.row {
                return lhs.row < rhs.row
            }

            return lhs.column < rhs.column
        }
    }
}
