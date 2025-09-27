import SwiftUI

extension Font {
    static let aqua = AquaFonts()
}

struct AquaFonts {
    // Hero Sizes (48-64pt)
    let heroLarge = Font.system(size: 64, weight: .heavy, design: .default)
    let heroMedium = Font.system(size: 56, weight: .heavy, design: .default)
    let heroSmall = Font.system(size: 48, weight: .heavy, design: .default)

    // Headers (32-36pt)
    let headerLarge = Font.system(size: 36, weight: .bold, design: .default)
    let headerMedium = Font.system(size: 32, weight: .bold, design: .default)

    // Subheaders (24-28pt)
    let subheaderLarge = Font.system(size: 28, weight: .semibold, design: .default)
    let subheaderMedium = Font.system(size: 24, weight: .semibold, design: .default)

    // Body Text (16-18pt)
    let bodyLarge = Font.system(size: 18, weight: .regular, design: .default)
    let bodyMedium = Font.system(size: 16, weight: .regular, design: .default)

    // Captions (12-14pt)
    let captionLarge = Font.system(size: 14, weight: .medium, design: .default)
    let captionSmall = Font.system(size: 12, weight: .medium, design: .default)

    // Monospaced for prices/numbers
    let priceLarge = Font.system(size: 24, weight: .bold, design: .monospaced)
    let priceMedium = Font.system(size: 18, weight: .semibold, design: .monospaced)
    let priceSmall = Font.system(size: 14, weight: .medium, design: .monospaced)
}

struct AquaTextStyle: ViewModifier {
    let color: Color
    let shadow: Bool

    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .shadow(color: shadow ? Color.black.opacity(0.3) : Color.clear, radius: 2, x: 0, y: 1)
    }
}

extension View {
    func aquaTextStyle(color: Color = .white, shadow: Bool = false) -> some View {
        modifier(AquaTextStyle(color: color, shadow: shadow))
    }
}