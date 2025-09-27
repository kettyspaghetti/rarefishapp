import SwiftUI

struct FishDetailView: View {
    let fish: SampleFish
    @Environment(\.presentationMode) var presentationMode
    @State private var showBuyAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero Image
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(LinearGradient(
                            colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(height: 300)
                        .overlay(
                            VStack {
                                Image(systemName: "fish.fill")
                                    .font(.system(size: 100))
                                    .foregroundColor(.white.opacity(0.8))

                                Text("3D Model Viewer")
                                    .font(.body)
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        )

                    // Back Button
                    VStack {
                        HStack {
                            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }

                            Spacer()

                            Button(action: {}) {
                                Image(systemName: "heart")
                                    .font(.title2)
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }

                // Fish Info
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(fish.name)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)

                        Text(fish.scientific)
                            .font(.title3)
                            .italic()
                            .foregroundColor(.white.opacity(0.8))

                        HStack {
                            Image(systemName: "flag")
                                .foregroundColor(.white.opacity(0.6))
                            Text(fish.origin)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                        }

                        Text("1 of only 3 in existence")
                            .font(.body)
                            .foregroundColor(Color(hex: "00D4FF"))
                    }

                    // Stats
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Specifications")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        VStack(spacing: 12) {
                            StatRow(label: "Current Size", value: "28.5 cm")
                            StatRow(label: "Max Size", value: "32.0 cm")
                            StatRow(label: "Age", value: "4.2 years")
                            StatRow(label: "Vitality", value: "95%")
                            StatRow(label: "Activity Level", value: "High")
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    // Description
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("The crown jewel of Asian arowanas, this platinum specimen displays unparalleled metallic luster and perfect fin formation. Known for their intelligence and longevity, this particular specimen represents the pinnacle of aquatic breeding excellence.")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                            .lineSpacing(4)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Spacer(minLength: 120)
                }
                .padding()
            }
        }
        .background(Color(hex: "0A0E1A").ignoresSafeArea())
        .navigationBarHidden(true)
        .overlay(
            // Action Bar
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("$\(fish.price)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "00D4FF"))

                        Text("\(fish.change > 0 ? "+" : "")\(fish.change, specifier: "%.1f")% today")
                            .font(.caption)
                            .foregroundColor(fish.change > 0 ? .green : .red)
                    }

                    Spacer()

                    Button("Make Offer") {
                        // Handle offer
                    }
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button("Buy Now") {
                        showBuyAlert = true
                    }
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color(hex: "00D4FF"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding()
                .background(Color(hex: "0A0E1A").opacity(0.95))
            }
        )
        .alert("Purchase Successful!", isPresented: $showBuyAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Congratulations! You are now the proud owner of this magnificent \(fish.name).")
        }
    }
}

struct StatRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label + ":")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
            Spacer()
            Text(value)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    FishDetailView(fish: SampleFish(
        name: "Platinum Arowana",
        scientific: "Scleropages formosus",
        price: "45,000",
        change: 8.5,
        rarity: "Legendary",
        origin: "Indonesia"
    ))
}