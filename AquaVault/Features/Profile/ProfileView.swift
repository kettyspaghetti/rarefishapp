import SwiftUI

struct ProfileView: View {
    @State private var showingSettings = false
    @State private var showingQRCode = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 20) {
                        // Top Actions
                        HStack {
                            Button(action: { showingQRCode = true }) {
                                Image(systemName: "qrcode")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(Circle())
                            }

                            Spacer()

                            Button(action: { showingSettings = true }) {
                                Image(systemName: "gearshape")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }

                        // Profile Avatar & Info
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(
                                        colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 120, height: 120)

                                Circle()
                                    .stroke(Color(hex: "E8B4B8"), lineWidth: 4)
                                    .frame(width: 120, height: 120)

                                Image(systemName: "crown.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(Color(hex: "E8B4B8"))
                            }

                            VStack(spacing: 8) {
                                HStack(spacing: 8) {
                                    Text("Elite Collector")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)

                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(Color(hex: "00D4FF"))
                                }

                                Text("@aqua_master_2024")
                                    .font(.body)
                                    .foregroundColor(.white.opacity(0.7))

                                // Status Badge
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 8, height: 8)

                                    Text("Legendary Curator")
                                        .font(.caption)
                                        .foregroundColor(Color(hex: "E8B4B8"))
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Capsule())
                            }

                            // Quick Stats
                            HStack(spacing: 30) {
                                ProfileQuickStat(title: "Fish", value: "23")
                                ProfileQuickStat(title: "Value", value: "$127K")
                                ProfileQuickStat(title: "Rank", value: "#42")
                            }
                        }
                    }
                    .padding()

                    // Stats Overview
                    VStack(spacing: 20) {
                        HStack {
                            Text("Collector Statistics")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Spacer()

                            Button("Share") {}
                                .foregroundColor(Color(hex: "00D4FF"))
                        }

                        VStack(spacing: 16) {
                            StatRow(title: "Total Trades", value: "247", trend: "+12 this month")
                            StatRow(title: "Success Rate", value: "94.2%", trend: "+2.1% vs last month")
                            StatRow(title: "Avg. Hold Time", value: "45 days", trend: "Optimal range")
                            StatRow(title: "Portfolio ROI", value: "+287%", trend: "All time")
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                    // Achievements
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Achievements")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Spacer()

                            Button("View All") {}
                                .foregroundColor(Color(hex: "00D4FF"))
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                AchievementBadge(title: "First Purchase", icon: "star.fill", color: .yellow, isUnlocked: true)
                                AchievementBadge(title: "Rare Collector", icon: "diamond.fill", color: .purple, isUnlocked: true)
                                AchievementBadge(title: "Trading Master", icon: "chart.line.uptrend.xyaxis", color: .green, isUnlocked: true)
                                AchievementBadge(title: "Whale Hunter", icon: "crown.fill", color: Color(hex: "E8B4B8"), isUnlocked: false)
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Settings Section
                    VStack(spacing: 12) {
                        SettingsRow(icon: "bell", title: "Notifications")
                        SettingsRow(icon: "lock", title: "Privacy & Security")
                        SettingsRow(icon: "creditcard", title: "Payment Methods")
                        SettingsRow(icon: "questionmark.circle", title: "Help & Support")

                        // Sign Out
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundColor(.red)

                                Text("Sign Out")
                                    .font(.body)
                                    .foregroundColor(.red)

                                Spacer()
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 100)
                }
            }
            .background(Color(hex: "0A0E1A").ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showingQRCode) {
            QRCodeView()
        }
    }
}

struct ProfileQuickStat: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
    }
}

struct StatRow: View {
    let title: String
    let value: String
    let trend: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))

                Text(trend)
                    .font(.caption)
                    .foregroundColor(.green)
            }

            Spacer()

            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct AchievementBadge: View {
    let title: String
    let icon: String
    let color: Color
    let isUnlocked: Bool

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(isUnlocked ? color.opacity(0.2) : Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)

                Circle()
                    .stroke(isUnlocked ? color : Color.gray, lineWidth: 3)
                    .frame(width: 80, height: 80)

                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(isUnlocked ? color : .gray)

                if !isUnlocked {
                    Image(systemName: "lock.fill")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .offset(x: 25, y: -25)
                        .background(
                            Circle()
                                .fill(Color(hex: "0A0E1A"))
                                .frame(width: 20, height: 20)
                        )
                }
            }

            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100)
        .opacity(isUnlocked ? 1.0 : 0.6)
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String

    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(width: 24)

                Text(title)
                    .font(.body)
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text("Settings Coming Soon")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "0A0E1A").ignoresSafeArea())
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(Color(hex: "00D4FF"))
            )
        }
    }
}

struct QRCodeView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Share Your Profile")
                    .font(.title)
                    .foregroundColor(.white)

                VStack(spacing: 20) {
                    Image(systemName: "qrcode")
                        .font(.system(size: 200))
                        .foregroundColor(.white)

                    Text("Elite Collector")
                        .font(.title2)
                        .foregroundColor(.white)

                    Text("@aqua_master_2024")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(40)
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Text("Others can scan this QR code to view your collection and trading profile")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color(hex: "0A0E1A").ignoresSafeArea())
            .navigationTitle("QR Code")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(Color(hex: "00D4FF"))
            )
        }
    }
}

#Preview {
    ProfileView()
}