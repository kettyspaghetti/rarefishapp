import SwiftUI

struct DashboardView: View {
    @State private var showBidAlert = false
    @State private var showNotifications = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Good Evening")
                                    .font(.title2)
                                    .foregroundColor(.white.opacity(0.8))

                                Text("Fish Dad")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }

                            Spacer()

                            Button(action: { showNotifications = true }) {
                                Image(systemName: "bell")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }
                        .padding()

                        // Featured Fish Card
                        VStack(spacing: 16) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(
                                    colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(height: 200)
                                .overlay(
                                    VStack {
                                        Image(systemName: "fish.fill")
                                            .font(.system(size: 60))
                                            .foregroundColor(.white.opacity(0.8))

                                        Text("Platinum Arowana")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)

                                        Text("$45,000")
                                            .font(.title)
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color(hex: "00D4FF"))

                                        Button("Bid Now") {
                                            showBidAlert = true
                                        }
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 12)
                                        .background(Color(hex: "00D4FF"))
                                        .clipShape(Capsule())
                                    }
                                )
                                .padding(.horizontal)
                        }
                    }

                    // Quick Stats
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                        StatCard(title: "Tank Value", value: "$127,450", change: "+$3,200")
                        StatCard(title: "Fish Count", value: "23", change: "+2 this week")
                        StatCard(title: "Dad Level", value: "Expert", change: "Top 5%")
                        StatCard(title: "Active Care", value: "12", change: "2 breeding")
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 100)
                }
            }
            .background(Color(hex: "0A0E1A").ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .alert("Bid Placed!", isPresented: $showBidAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your bid of $46,000 has been placed successfully!")
        }
        .alert("Notifications", isPresented: $showNotifications) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("• Your Peppermint Angelfish bid was outbid\n• New Platinum Arowana listing available\n• Weekly portfolio update ready")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let change: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(change)
                .font(.caption)
                .foregroundColor(Color(hex: "00D4FF"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    DashboardView()
}