import SwiftUI

struct TradingView: View {
    @State private var selectedAmount = ""
    @State private var showSuccessAlert = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Trading")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)

                                Text("Premium Fish Exchange")
                                    .font(.body)
                                    .foregroundColor(.white.opacity(0.7))
                            }

                            Spacer()

                            Button(action: {}) {
                                Image(systemName: "chart.bar.doc.horizontal")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }

                        // Market Overview
                        VStack(spacing: 16) {
                            HStack {
                                Text("Market Overview")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                Spacer()

                                Text("Live")
                                    .font(.caption)
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.green.opacity(0.2))
                                    .clipShape(Capsule())
                            }

                            HStack(spacing: 20) {
                                MarketStat(title: "Total Volume", value: "$2.4M", change: "+12.5%")
                                MarketStat(title: "Active Traders", value: "1,247", change: "+8.2%")
                                MarketStat(title: "Avg. Price", value: "$18.5K", change: "-2.1%")
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding()

                    // Featured Trading Opportunities
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Trading Opportunities")
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
                                ForEach(Array(sampleFish.prefix(4)), id: \.name) { fish in
                                    TradingOpportunityCard(fish: fish)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Quick Trade Panel
                    VStack(spacing: 20) {
                        HStack {
                            Text("Quick Trade")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Spacer()
                        }

                        // Selected Fish
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LinearGradient(
                                    colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 50, height: 40)
                                .overlay(
                                    Image(systemName: "fish.fill")
                                        .foregroundColor(.white.opacity(0.8))
                                )

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Platinum Arowana")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)

                                Text("$45,000")
                                    .font(.caption)
                                    .foregroundColor(Color(hex: "00D4FF"))
                            }

                            Spacer()

                            Button("Change") {}
                                .foregroundColor(Color(hex: "00D4FF"))
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                        // Amount Input
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Amount (USD)")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))

                            TextField("Enter amount", text: $selectedAmount)
                                .font(.body)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        // Quick Amount Buttons
                        HStack(spacing: 12) {
                            ForEach(["$1K", "$5K", "$10K", "Max"], id: \.self) { amount in
                                Button(amount) {
                                    selectedAmount = amount == "Max" ? "45000" : String(amount.dropFirst().dropLast())
                                }
                                .font(.caption)
                                .foregroundColor(Color(hex: "00D4FF"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Capsule())
                            }
                        }

                        // Action Buttons
                        HStack(spacing: 12) {
                            Button("Schedule Auction") {}
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 16))

                            Button("Buy Now") {
                                showSuccessAlert = true
                            }
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(hex: "00D4FF"))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
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
        .alert("Trade Successful!", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your order has been executed successfully!")
        }
    }
}

struct MarketStat: View {
    let title: String
    let value: String
    let change: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))

            Text(value)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(change)
                .font(.caption)
                .foregroundColor(change.hasPrefix("+") ? .green : .red)
        }
    }
}

struct TradingOpportunityCard: View {
    let fish: SampleFish

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(fish.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Text(fish.origin)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()
            }

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("$\(fish.price)")
                        .font(.headline)
                        .foregroundColor(Color(hex: "00D4FF"))

                    Text("\(fish.change > 0 ? "+" : "")\(fish.change, specifier: "%.1f")%")
                        .font(.caption)
                        .foregroundColor(fish.change > 0 ? .green : .red)
                }

                Spacer()

                Text("Hot")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange.opacity(0.2))
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 200)
    }
}

#Preview {
    TradingView()
}