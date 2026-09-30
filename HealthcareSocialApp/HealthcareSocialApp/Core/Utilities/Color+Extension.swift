//
//  Color+Extension.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//


import SwiftUI

extension Color {

 
    init?(hex: String?) {
        guard let hex = hex, !hex.isEmpty else { return nil }

        var cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleaned.hasPrefix("#") { cleaned = String(cleaned.dropFirst()) }

        guard cleaned.count == 6 else { return nil }

        var rgb: UInt64 = 0
        guard Scanner(string: cleaned).scanHexInt64(&rgb) else { return nil }

        self.init(
            red:   Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8)  / 255.0,
            blue:  Double( rgb & 0x0000FF)         / 255.0
        )
    }
}
