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

    func burstParticles() {
        let newParticles = (0..<28).map { _ in
            ParticleModel(
                x: CGFloat.random(in: -165...165),
                y: CGFloat.random(in: -155...70),
                size: CGFloat.random(in: 8...22),
                color: particlePalette.randomElement() ?? .orange,
                lifetime: Double.random(in: 0.90...1.35)
            )
        }

        let newParticleIDs = Set(newParticles.map(\.id))
        particles.append(contentsOf: newParticles)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) {
            self.particles.removeAll { newParticleIDs.contains($0.id) }
        }
    }

    func revealTiles() {
        visibleTileIDs.removeAll()

        for (index, tile) in revealOrder.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(index) * 0.12)) {
                withAnimation(.easeOut(duration: 0.26)) {
                    _ = self.visibleTileIDs.insert(tile.id)
                }
            }
        }
    }

    func hideTiles() {
        for (index, tile) in revealOrder.reversed().enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(index) * 0.10)) {
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

    private var revealOrder: [StaggerTileModel] {
        tiles.sorted { lhs, rhs in
            if lhs.row != rhs.row {
                return lhs.row < rhs.row
            }
            return lhs.column < rhs.column
        }
    }
}
