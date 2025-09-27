import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appState: AppState
    @State private var animateTitle = false
    @State private var animateLogo = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(hex: "0A0E1A"), Color(hex: "1A1F2E")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // Logo/Fish Animation
                ZStack {
                    // Holographic fish placeholder
                    Image(systemName: "fish.fill")
                        .font(.system(size: 120))
                        .foregroundStyle(LinearGradient(
                            colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .scaleEffect(animateLogo ? 1.0 : 0.8)
                        .opacity(animateLogo ? 1.0 : 0.6)

                    // Glow effect
                    Circle()
                        .fill(Color(hex: "00D4FF").opacity(0.3))
                        .frame(width: 200, height: 200)
                        .blur(radius: 20)
                        .scaleEffect(animateLogo ? 1.2 : 0.8)
                }

                // App Title
                VStack(spacing: 8) {
                    Text("AquaVault")
                        .font(.system(size: 64, weight: .heavy, design: .default))
                        .fontWeight(.heavy)
                        .foregroundStyle(LinearGradient(
                            colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .scaleEffect(animateTitle ? 1.0 : 0.9)
                        .opacity(animateTitle ? 1.0 : 0.0)

                    Text("Where Rarity Meets Luxury")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(animateTitle ? 1.0 : 0.0)
                }

                Spacer()

                // Loading indicator
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(hex: "00D4FF")))
                        .scaleEffect(1.5)

                    Text("Loading Premium Experience...")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            startAnimations()
        }
    }

    private func startAnimations() {
        // Animate logo
        withAnimation(.easeOut(duration: 1.0)) {
            animateLogo = true
        }

        // Animate title after delay
        withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
            animateTitle = true
        }

        // Complete splash after animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            appState.completeSplash()
        }
    }
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

#Preview {
    SplashView()
        .environmentObject(AppState())
}