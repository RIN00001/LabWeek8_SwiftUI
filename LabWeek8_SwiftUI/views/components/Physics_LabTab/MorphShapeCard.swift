//
//  MorphShapeCard.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct MorphShapeCard: View {
    @ObservedObject var viewModel: PhysicsLabViewModel

    var body: some View {
        PhysicsSectionContainer(title: "Morph Shape", icon: "seal.fill") {
            VStack(alignment: .leading, spacing: 14) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(AppTheme.previewBackground)
                    .frame(height: 150)
                    .overlay {
                        MorphingOctagonShape(progress: viewModel.morphProgress)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.512, green: 0.784, blue: 0.984),
                                        Color(red: 0.694, green: 0.349, blue: 0.890)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 106, height: 106)
                    }

                Text("Morph: \(Int((viewModel.morphProgress * 100).rounded()))%")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)

                Slider(value: $viewModel.morphProgress, in: 0...1)
                    .tint(AppTheme.hueTint)
            }
        }
    }
}

private struct MorphingOctagonShape: Shape {
    var progress: Double

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) * 0.40
        let innerRadius = outerRadius * (1.0 - 0.52 * progress)

        let points: [CGPoint] = (0..<8).map { index in
            let angle = (-90.0 + (Double(index) * 45.0)) * .pi / 180.0
            let radius = index.isMultiple(of: 2) ? innerRadius : outerRadius

            return CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
        }

        var path = Path()
        path.move(to: points[0])

        for point in points.dropFirst() {
            path.addLine(to: point)
        }

        path.closeSubpath()
        return path
    }
}

#Preview {
    ZStack {
        AppTheme.screenBackground.ignoresSafeArea()
        MorphShapeCard(viewModel: PhysicsLabViewModel())
            .padding()
    }
    .preferredColorScheme(.light)
}
