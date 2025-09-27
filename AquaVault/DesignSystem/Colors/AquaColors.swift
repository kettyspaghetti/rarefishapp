import SwiftUI

extension Color {
    static let aqua = AquaColors()
}

struct AquaColors {
    // Primary Colors
    let deepOcean = Color(hex: "0A0E1A")
    let electricCyan = Color(hex: "00D4FF")
    let roseGold = Color(hex: "E8B4B8")

    // Gradients
    let iridescent = LinearGradient(
        colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    let oceanDepth = LinearGradient(
        colors: [Color(hex: "0A0E1A"), Color(hex: "1A1F2E")],
        startPoint: .top,
        endPoint: .bottom
    )

    // Glass Effect
    let glassOverlay = Color.white.opacity(0.1)
    let glassBorder = Color.white.opacity(0.2)

    // Status Colors
    let success = Color.green
    let warning = Color.orange
    let error = Color.red

    // Rarity Colors
    let common = Color.gray
    let rare = Color.yellow
    let ultraRare = Color.purple
    let mythic = Color.cyan
    let legendary = Color.black
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}