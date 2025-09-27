import SwiftUI

struct DiscoveryView: View {
    @State private var searchText = ""
    @State private var showingFilters = false

    var filteredFish: [SampleFish] {
        if searchText.isEmpty {
            return sampleFish
        } else {
            return sampleFish.filter { fish in
                fish.name.localizedCaseInsensitiveContains(searchText) ||
                fish.scientific.localizedCaseInsensitiveContains(searchText) ||
                fish.origin.localizedCaseInsensitiveContains(searchText) ||
                fish.rarity.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Discover")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)

                            Text("Rare Aquatic Specimens")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Spacer()

                        Button(action: { showingFilters = true }) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }

                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.6))

                        TextField("Search specimens...", text: $searchText)
                            .foregroundColor(.white)

                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
                .background(Color(hex: "0A0E1A"))

                // Fish Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)
                    ], spacing: 16) {
                        ForEach(filteredFish, id: \.name) { fish in
                            NavigationLink(destination: FishDetailView(fish: fish)) {
                                FishCard(fish: fish)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
                .background(Color(hex: "0A0E1A"))
            }
            .background(Color(hex: "0A0E1A").ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingFilters) {
            FilterView()
        }
    }
}

struct FishCard: View {
    let fish: SampleFish

    var body: some View {
        VStack(spacing: 12) {
            // Fish Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient(
                        colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .aspectRatio(16/9, contentMode: .fit)
                    .overlay(
                        Image(systemName: "fish.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white.opacity(0.8))
                    )

                // Rarity Badge
                VStack {
                    HStack {
                        Spacer()
                        Text(fish.rarity.uppercased())
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.purple)
                            .clipShape(Capsule())
                    }
                    Spacer()
                }
                .padding(8)
            }

            // Fish Info
            VStack(alignment: .leading, spacing: 6) {
                Text(fish.name)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(fish.scientific)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .italic()
                    .lineLimit(1)

                HStack {
                    Text("$\(fish.price)")
                        .font(.headline)
                        .foregroundColor(Color(hex: "00D4FF"))

                    Spacer()

                    Text("\(fish.change > 0 ? "+" : "")\(fish.change, specifier: "%.1f")%")
                        .font(.caption)
                        .foregroundColor(fish.change > 0 ? .green : .red)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct SampleFish {
    let name: String
    let scientific: String
    let price: String
    let change: Double
    let rarity: String
    let origin: String
}

let sampleFish = [
    SampleFish(name: "Platinum Arowana", scientific: "Scleropages formosus", price: "45,000", change: 8.5, rarity: "Legendary", origin: "Indonesia"),
    SampleFish(name: "Peppermint Angelfish", scientific: "Paracentropyge boylei", price: "30,000", change: -2.3, rarity: "Mythic", origin: "Pacific Ocean"),
    SampleFish(name: "Masked Angelfish", scientific: "Genicanthus personatus", price: "15,000", change: 5.2, rarity: "Ultra Rare", origin: "Hawaii"),
    SampleFish(name: "Clarion Angelfish", scientific: "Holacanthus clarionensis", price: "8,500", change: 12.1, rarity: "Rare", origin: "Mexico"),
    SampleFish(name: "Wrought Iron Butterflyfish", scientific: "Chaetodon daedalma", price: "3,500", change: -1.8, rarity: "Rare", origin: "Japan"),
    SampleFish(name: "Candy Basslet", scientific: "Liopropoma carmabi", price: "1,200", change: 3.7, rarity: "Common", origin: "Caribbean")
]

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedRarity = "All"
    @State private var priceRange = 50000.0
    @State private var selectedOrigin = "All"

    let rarities = ["All", "Common", "Rare", "Ultra Rare", "Mythic", "Legendary"]
    let origins = ["All", "Indonesia", "Pacific Ocean", "Hawaii", "Mexico", "Japan", "Caribbean"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Rarity Filter
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Rarity")
                            .font(.headline)
                            .foregroundColor(.white)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(rarities, id: \.self) { rarity in
                                Button(rarity) {
                                    selectedRarity = rarity
                                }
                                .font(.body)
                                .foregroundColor(selectedRarity == rarity ? .black : .white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(selectedRarity == rarity ? Color(hex: "00D4FF") : Color.white.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }

                    // Price Range
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Max Price: $\(Int(priceRange))")
                            .font(.headline)
                            .foregroundColor(.white)

                        Slider(value: $priceRange, in: 1000...50000, step: 1000)
                            .accentColor(Color(hex: "00D4FF"))
                    }

                    // Origin Filter
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Origin")
                            .font(.headline)
                            .foregroundColor(.white)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(origins, id: \.self) { origin in
                                Button(origin) {
                                    selectedOrigin = origin
                                }
                                .font(.body)
                                .foregroundColor(selectedOrigin == origin ? .black : .white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(selectedOrigin == origin ? Color(hex: "00D4FF") : Color.white.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(hex: "0A0E1A").ignoresSafeArea())
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Reset") {
                    selectedRarity = "All"
                    selectedOrigin = "All"
                    priceRange = 50000.0
                }
                .foregroundColor(Color(hex: "00D4FF")),
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(Color(hex: "00D4FF"))
            )
        }
    }
}

#Preview {
    DiscoveryView()
}