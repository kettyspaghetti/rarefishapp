import SwiftUI

struct GlassmorphicCard<Content: View>: View {
    let content: Content
    let padding: CGFloat
    let cornerRadius: CGFloat

    init(
        padding: CGFloat = 20,
        cornerRadius: CGFloat = 16,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.padding = padding
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.aqua.glassOverlay)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.aqua.glassBorder, lineWidth: 1)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color.aqua.deepOcean.opacity(0.3))
                            .blur(radius: 20)
                    )
            )
    }
}

struct PremiumButton: View {
    let title: String
    let action: () -> Void
    let style: ButtonStyle

    enum ButtonStyle {
        case primary
        case secondary
        case destructive
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.aqua.bodyLarge)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(backgroundView)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(borderColor, lineWidth: 1)
                )
        }
        .buttonStyle(PremiumButtonStyle())
    }

    private var textColor: Color {
        switch style {
        case .primary: return .black
        case .secondary: return .white
        case .destructive: return .white
        }
    }

    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(backgroundColor)
    }

    private var backgroundColor: LinearGradient {
        switch style {
        case .primary:
            return LinearGradient(
                colors: [Color.aqua.electricCyan, Color.aqua.electricCyan.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
        case .secondary:
            return LinearGradient(
                colors: [Color.aqua.glassOverlay, Color.aqua.glassOverlay.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
        case .destructive:
            return LinearGradient(
                colors: [Color.red, Color.red.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private var borderColor: Color {
        switch style {
        case .primary: return Color.aqua.electricCyan.opacity(0.5)
        case .secondary: return Color.aqua.glassBorder
        case .destructive: return Color.red.opacity(0.5)
        }
    }
}

struct PremiumButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}