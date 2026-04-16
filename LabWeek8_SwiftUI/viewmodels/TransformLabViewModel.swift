//
//  TransformLabViewModel.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import Foundation
import Combine

final class TransformLabViewModel: ObservableObject {
    @Published var scale: Double = 1.0
    @Published var isBreathingScale: Bool = false

    @Published var rotation: Double = 0.0
    @Published var isSpinning: Bool = false

    @Published var opacity: Double = 1.0
    @Published var isBreathingOpacity: Bool = false

    @Published var hue: Double = 0.0
    @Published var isBreathingHue: Bool = false

    var scaleLabel: String {
        "Scale: \(formattedDecimal(scale))x"
    }

    var rotationLabel: String {
        "Angle: \(Int(rotation.rounded()))°"
    }

    var opacityLabel: String {
        "Opacity: \(formattedDecimal(opacity))"
    }

    var hueLabel: String {
        "Hue: \(Int(hue.rounded()))°"
    }

    func effectiveScale(at date: Date) -> Double {
        let pulse = isBreathingScale ? (1.0 + (oscillation(at: date, speed: 0.65) * 0.20)) : 1.0
        return scale * pulse
    }

    func effectiveRotation(at date: Date) -> Double {
        let spin = isSpinning
            ? (date.timeIntervalSinceReferenceDate * 120.0).truncatingRemainder(dividingBy: 360.0)
            : 0.0
        return rotation + spin
    }

    func effectiveOpacity(at date: Date) -> Double {
        let pulse = isBreathingOpacity ? (0.04 + 0.96 * oscillation(at: date, speed: 0.85)) : 1.0
        return max(0.0, min(1.0, opacity * pulse))
    }

    func effectiveHue(at date: Date) -> Double {
        let wave = isBreathingHue ? (360.0 * oscillation(at: date, speed: 0.35)) : 0.0
        let value = hue + wave
        let remainder = value.truncatingRemainder(dividingBy: 360.0)
        return remainder >= 0 ? remainder : remainder + 360.0
    }

    private func oscillation(at date: Date, speed: Double) -> Double {
        let time = date.timeIntervalSinceReferenceDate * speed
        return 0.5 + 0.5 * sin(time * 2.0 * .pi)
    }

    private func formattedDecimal(_ value: Double) -> String {
        String(format: "%.2f", value).replacingOccurrences(of: ".", with: ",")
    }
}
