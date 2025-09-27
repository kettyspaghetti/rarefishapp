import SwiftUI

struct PortfolioView: View {
    @State private var viewMode: ViewMode = .grid
    @State private var showingAddFish = false

    enum ViewMode: String, CaseIterable {
        case grid = "Grid"
        case list = "List"
        case aquarium = "Aquarium"

        var icon: String {
            switch self {
            case .grid: return "square.grid.2x2"
            case .list: return "list.bullet"
            case .aquarium: return "cube.transparent"
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Collection")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)

                            Text("Your Rare Specimens")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Spacer()

                        Button(action: { showingAddFish = true }) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color(hex: "00D4FF"))
                                .clipShape(Circle())
                        }
                    }

                    // Portfolio Overview
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Total Value")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))

                                Text("$127,450")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)

                                Text("+$3,200 (+2.5%) today")
                                    .font(.body)
                                    .foregroundColor(.green)
                            }

                            Spacer()

                            // Progress Ring
                            ZStack {
                                Circle()
                                    .stroke(Color.white.opacity(0.2), lineWidth: 8)
                                    .frame(width: 80, height: 80)

                                Circle()
                                    .trim(from: 0, to: 0.75)
                                    .stroke(Color(hex: "00D4FF"), lineWidth: 8)
                                    .frame(width: 80, height: 80)
                                    .rotationEffect(.degrees(-90))

                                VStack(spacing: 2) {
                                    Text("75%")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)

                                    Text("Goal")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.6))
                                }
                            }
                        }

                        // Quick Stats
                        HStack(spacing: 20) {
                            PortfolioStat(title: "Species", value: "23", subtitle: "23/100 Goal")
                            PortfolioStat(title: "Rarity Score", value: "9,450", subtitle: "Top 5%")
                            PortfolioStat(title: "Badges", value: "12", subtitle: "Achievements")
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding()
                .background(Color(hex: "0A0E1A"))

                // View Mode Switcher
                HStack {
                    Text("View:")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))

                    ForEach(ViewMode.allCases, id: \.self) { mode in
                        Button(action: { viewMode = mode }) {
                            HStack(spacing: 6) {
                                Image(systemName: mode.icon)
                                    .font(.caption)
                                Text(mode.rawValue)
                                    .font(.caption)
                            }
                            .foregroundColor(viewMode == mode ? .black : .white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(viewMode == mode ? Color(hex: "00D4FF") : Color.white.opacity(0.1))
                            )
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
                .background(Color(hex: "0A0E1A"))

                // Collection Content
                collectionContent
            }
            .background(Color(hex: "0A0E1A").ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .alert("Add Fish Coming Soon!", isPresented: $showingAddFish) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Fish addition feature will be available in the next update.")
        }
    }

    @ViewBuilder
    private var collectionContent: some View {
        switch viewMode {
        case .grid:
            gridView
        case .list:
            listView
        case .aquarium:
            aquariumView
        }
    }

    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12)
            ], spacing: 16) {
                ForEach(sampleFish, id: \.name) { fish in
                    NavigationLink(destination: FishDetailView(fish: fish)) {
                        PortfolioFishCard(fish: fish, style: .compact)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            .padding(.bottom, 100)
        }
        .background(Color(hex: "0A0E1A"))
    }

    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(sampleFish, id: \.name) { fish in
                    NavigationLink(destination: FishDetailView(fish: fish)) {
                        PortfolioFishCard(fish: fish, style: .detailed)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            .padding(.bottom, 100)
        }
        .background(Color(hex: "0A0E1A"))
    }

    private var aquariumView: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(height: 300)
                        .overlay(
                            VStack {
                                Text("Virtual Aquarium")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                Text("3D Environment")
                                    .font(.body)
                                    .foregroundColor(.white.opacity(0.7))

                                // Floating fish icons
                        ForEach(0..<6, id: \.self) { index in
                            Image(systemName: "fish.fill")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.8))
                                .offset(
                                    x: CGFloat.random(in: -100...100),
                                    y: CGFloat.random(in: -50...50)
                                )
                        }
                            }
                        )

                    // Controls overlay
                    VStack {
                        Spacer()
                        HStack(spacing: 16) {
                            AquariumControl(icon: "camera", title: "Screenshot")
                            AquariumControl(icon: "video", title: "Record")
                            AquariumControl(icon: "arkit", title: "AR Mode")
                            AquariumControl(icon: "eye", title: "Tour Mode")
                        }
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding()
                }
                .padding(.horizontal)

                Spacer(minLength: 100)
            }
        }
        .background(Color(hex: "0A0E1A"))
    }
}

struct PortfolioStat: View {
    let title: String
    let value: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))

            Text(value)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(subtitle)
                .font(.caption)
                .foregroundColor(Color(hex: "00D4FF"))
        }
    }
}

struct AquariumControl: View {
    let icon: String
    let title: String

    var body: some View {
        VStack(spacing: 8) {
            Button(action: {}) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(Color(hex: "00D4FF"))
                    .frame(width: 50, height: 50)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())
            }

            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
    }
}

struct PortfolioFishCard: View {
    let fish: SampleFish
    let style: CardStyle

    enum CardStyle {
        case compact
        case detailed
    }

    var body: some View {
        Group {
            if style == .compact {
                compactLayout
            } else {
                detailedLayout
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var compactLayout: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(
                    colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Image(systemName: "fish.fill")
                        .foregroundColor(.white.opacity(0.8))
                )

            VStack(spacing: 4) {
                Text(fish.name)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text("$\(fish.price)")
                    .font(.caption)
                    .foregroundColor(Color(hex: "00D4FF"))
            }
        }
    }

    private var detailedLayout: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(
                    colors: [Color(hex: "4A00E0"), Color(hex: "8E2DE2")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 80, height: 60)
                .overlay(
                    Image(systemName: "fish.fill")
                        .font(.title)
                        .foregroundColor(.white.opacity(0.8))
                )

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(fish.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Spacer()

                    Text("$\(fish.price)")
                        .font(.headline)
                        .foregroundColor(Color(hex: "00D4FF"))
                }

                Text(fish.scientific)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .italic()

                HStack {
                    Text(fish.rarity.uppercased())
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.purple.opacity(0.6))
                        .clipShape(Capsule())

                    Spacer()

                    Text("\(fish.change > 0 ? "+" : "")\(fish.change, specifier: "%.1f")%")
                        .font(.caption)
                        .foregroundColor(fish.change > 0 ? .green : .red)
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
}