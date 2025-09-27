import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var appState: AppState
    @State private var showCard = false

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [Color(hex: "0A0E1A"), Color(hex: "1A1F2E")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                // Members Only Badge
                HStack {
                    Spacer()
                    Text("MEMBERS ONLY")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "E8B4B8"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.1))
                                .overlay(
                                    Capsule()
                                        .stroke(Color(hex: "E8B4B8").opacity(0.5), lineWidth: 1)
                                )
                        )
                    Spacer()
                }
                .padding(.top, 60)

                Spacer()

                // Authentication Card
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Welcome to AquaVault")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Exclusive Access Required")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.7))
                    }

                    // Face ID Button
                    Button("Face ID / Touch ID") {
                        authenticateUser()
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color(hex: "00D4FF"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Divider
                    HStack {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                        Text("or")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.6))
                            .padding(.horizontal, 12)
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                    }

                    // Sign In Button
                    Button("Sign In with Email") {
                        authenticateUser()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.white.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Request Access
                    Button("Request Exclusive Access") {
                        // Handle request access
                    }
                    .font(.body)
                    .foregroundColor(Color(hex: "00D4FF"))

                    // Social Proof
                    Text("Join 10,000+ Elite Collectors")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
                .padding(32)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 32)
                .scaleEffect(showCard ? 1.0 : 0.9)
                .opacity(showCard ? 1.0 : 0.0)

                Spacer()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.2)) {
                showCard = true
            }
        }
    }

    private func authenticateUser() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            appState.authenticate()
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AppState())
}