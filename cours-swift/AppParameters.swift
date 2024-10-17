//
//  AppParameters.swift
//  cours-swift
//
//  Created by Thomas Doret-Gaïsset on 15/10/2024.
//

import SwiftUI
import UIKit

class AppParameters {
    static let backgroundColor: Color = Color(hex: 0x181818)
    static let foregroundColor: Color = .white
    static var isValid: Bool = false
}

// Extension to create a Color from a hex value
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
