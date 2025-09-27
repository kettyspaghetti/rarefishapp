import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 20) {
                        // Top Actions
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "qrcode")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(Circle())
                            }

                            Spacer()

                            Button(action: {}) {
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
                                    Text("Fish Dad Expert")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)

                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(Color(hex: "00D4FF"))
                                }

                                Text("@fish_dad_2024")
                                    .font(.body)
                                    .foregroundColor(.white.opacity(0.7))

                                // Status Badge
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 8, height: 8)

                                    Text("Master Fish Dad")
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
                            Text("Fish Dad Statistics")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Spacer()

                            Button("Share") {}
                                .foregroundColor(Color(hex: "00D4FF"))
                        }

                        VStack(spacing: 16) {
                            StatRow(title: "Fish Raised", value: "247", trend: "+12 this month")
                            StatRow(title: "Breeding Success", value: "94.2%", trend: "+2.1% vs last month")
                            StatRow(title: "Tank Health Score", value: "98/100", trend: "Excellent")
                            StatRow(title: "Dad Experience", value: "4.5 years", trend: "Expert level")
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                    Spacer(minLength: 100)
                }
            }
            .background(Color(hex: "0A0E1A").ignoresSafeArea())
            .navigationBarHidden(true)
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

#Preview {
    ProfileView()
}