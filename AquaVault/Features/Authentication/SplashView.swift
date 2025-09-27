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


#Preview {
    SplashView()
        .environmentObject(AppState())
}