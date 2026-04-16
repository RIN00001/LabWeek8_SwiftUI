//
//  ParticleModel.swift
//  LabWeek8_SwiftUI
//
//  Created by student on 16/04/26.
//

import SwiftUI

struct ParticleModel: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let color: Color
    let lifetime: Double
}
