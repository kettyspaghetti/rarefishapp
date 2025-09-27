import SwiftUI

// MARK: - Enhanced Rarity System with Visual Effects

struct EnhancedRarityBadge: View {
    let rarity: RarityLevel
    @State private var isAnimating = false
    @State private var particleOffset = CGSize.zero

    var body: some View {
        ZStack {
            // Base badge
            Text(rarity.rawValue.uppercased())
                .font(.aqua.captionSmall)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(rarityGradient)
                        .shadow(color: rarityColor.opacity(0.6), radius: glowRadius)
                        .overlay(
                            Capsule()
                                .stroke(rarityColor.opacity(0.8), lineWidth: 1)
                        )
                )

            // Special effects for higher rarities
            if rarity == .mythic || rarity == .legendary {
                rarityEffects
            }
        }
        .scaleEffect(isAnimating ? 1.05 : 1.0)
        .onAppear {
            startAnimations()
        }
    }

    private var rarityColor: Color {
        switch rarity {
        case .common: return .gray
        case .rare: return .yellow
        case .ultraRare: return .purple
        case .mythic: return .aqua.electricCyan
        case .legendary: return .aqua.roseGold
        }
    }

    private var rarityGradient: LinearGradient {
        switch rarity {
        case .common:
            return LinearGradient(colors: [.gray, .gray.opacity(0.7)], startPoint: .top, endPoint: .bottom)
        case .rare:
            return LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
        case .ultraRare:
            return LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .mythic:
            return LinearGradient(colors: [.aqua.electricCyan, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .legendary:
            return LinearGradient(colors: [.aqua.roseGold, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    private var glowRadius: CGFloat {
        switch rarity {
        case .common: return 2
        case .rare: return 4
        case .ultraRare: return 6
        case .mythic: return 8
        case .legendary: return 12
        }
    }

    @ViewBuilder
    private var rarityEffects: some View {
        if rarity == .mythic {
            // Prismatic shimmer effect
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.clear, .white.opacity(0.3), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 100, height: 30)
                .clipShape(Capsule())
                .offset(x: isAnimating ? 50 : -50)
                .animation(
                    Animation.linear(duration: 2)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        } else if rarity == .legendary {
            // Floating particles
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.aqua.roseGold.opacity(0.8))
                    .frame(width: 4, height: 4)
                    .offset(
                        x: particleOffset.width + CGFloat(index * 10 - 10),
                        y: particleOffset.height + CGFloat(index * 5 - 5)
                    )
                    .animation(
                        Animation.easeInOut(duration: 2)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.3),
                        value: particleOffset
                    )
            }
        }
    }

    private func startAnimations() {
        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
            isAnimating = true
        }

        if rarity == .legendary {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                particleOffset = CGSize(width: 15, height: -15)
            }
        }
    }
}

// MARK: - Enhanced Verification System

struct EnhancedVerificationBadge: View {
    let level: VerificationLevel
    @State private var isGlowing = false

    var body: some View {
        HStack(spacing: 6) {
            // Verification icon with glow
            ZStack {
                ForEach(0..<level.checkmarkCount, id: \.self) { index in
                    Image(systemName: "checkmark.seal.fill")
                        .font(.caption)
                        .foregroundColor(verificationColor)
                        .offset(x: CGFloat(index * 8))
                        .scaleEffect(isGlowing ? 1.1 : 1.0)
                }
            }
            .shadow(color: verificationColor.opacity(0.6), radius: isGlowing ? 4 : 2)

            Text(level.rawValue)
                .font(.aqua.captionSmall)
                .fontWeight(.semibold)
                .foregroundColor(verificationColor)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(verificationColor.opacity(0.15))
                .overlay(
                    Capsule()
                        .stroke(verificationColor.opacity(0.5), lineWidth: 1)
                )
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isGlowing = true
            }
        }
    }

    private var verificationColor: Color {
        switch level {
        case .bronze: return .orange
        case .silver: return .gray
        case .gold: return .yellow
        case .platinum: return .aqua.roseGold
        }
    }
}

extension VerificationLevel {
    var checkmarkCount: Int {
        switch self {
        case .bronze: return 1
        case .silver: return 2
        case .gold: return 3
        case .platinum: return 4
        }
    }
}

// MARK: - User Level Progression System

enum UserLevel: String, CaseIterable {
    case novice = "Novice Collector"
    case enthusiast = "Enthusiast"
    case connoisseur = "Connoisseur"
    case master = "Master Breeder"
    case legendary = "Legendary Curator"

    var fishRange: ClosedRange<Int> {
        switch self {
        case .novice: return 0...10
        case .enthusiast: return 11...25
        case .connoisseur: return 26...50
        case .master: return 51...100
        case .legendary: return 101...999
        }
    }

    var color: Color {
        switch self {
        case .novice: return .green
        case .enthusiast: return .blue
        case .connoisseur: return .purple
        case .master: return .orange
        case .legendary: return .aqua.roseGold
        }
    }

    var icon: String {
        switch self {
        case .novice: return "leaf.fill"
        case .enthusiast: return "star.fill"
        case .connoisseur: return "diamond.fill"
        case .master: return "crown.fill"
        case .legendary: return "sparkles"
        }
    }

    static func level(for fishCount: Int) -> UserLevel {
        for level in UserLevel.allCases {
            if level.fishRange.contains(fishCount) {
                return level
            }
        }
        return .legendary
    }
}

struct UserLevelBadge: View {
    let level: UserLevel
    let fishCount: Int
    @State private var progressAnimation: CGFloat = 0

    var body: some View {
        HStack(spacing: 8) {
            // Level icon
            Image(systemName: level.icon)
                .font(.caption)
                .foregroundColor(level.color)
                .frame(width: 20, height: 20)
                .background(
                    Circle()
                        .fill(level.color.opacity(0.2))
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(level.rawValue)
                    .font(.aqua.captionLarge)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                // Progress to next level
                if level != .legendary {
                    let nextLevel = UserLevel.allCases[UserLevel.allCases.firstIndex(of: level)! + 1]
                    let progress = CGFloat(fishCount - level.fishRange.lowerBound) / CGFloat(level.fishRange.upperBound - level.fishRange.lowerBound)

                    HStack(spacing: 4) {
                        Text("\(fishCount)/\(level.fishRange.upperBound)")
                            .font(.aqua.captionSmall)
                            .foregroundColor(.white.opacity(0.7))

                        ProgressView(value: progressAnimation, total: 1.0)
                            .progressViewStyle(LinearProgressViewStyle(tint: level.color))
                            .frame(width: 60, height: 2)
                    }
                    .onAppear {
                        withAnimation(.easeOut(duration: 1.5).delay(0.5)) {
                            progressAnimation = progress
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.aqua.glassOverlay)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(level.color.opacity(0.5), lineWidth: 1)
                )
        )
    }
}

// MARK: - Market Status Indicators

enum MarketStatus: String, CaseIterable {
    case hot = "🔥 Hot"
    case trending = "📈 Trending"
    case stable = "⚖️ Stable"
    case cool = "❄️ Cool"
    case volatile = "⚡ Volatile"

    var color: Color {
        switch self {
        case .hot: return .red
        case .trending: return .green
        case .stable: return .blue
        case .cool: return .gray
        case .volatile: return .orange
        }
    }

    var description: String {
        switch self {
        case .hot: return "High trading activity"
        case .trending: return "Rising price and interest"
        case .stable: return "Steady market conditions"
        case .cool: return "Low trading activity"
        case .volatile: return "Rapid price changes"
        }
    }
}

struct MarketStatusBadge: View {
    let status: MarketStatus
    @State private var isPulsing = false

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(status.color)
                .frame(width: 8, height: 8)
                .scaleEffect(isPulsing ? 1.2 : 1.0)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isPulsing)

            Text(status.rawValue)
                .font(.aqua.captionLarge)
                .fontWeight(.medium)
                .foregroundColor(status.color)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(status.color.opacity(0.15))
                .overlay(
                    Capsule()
                        .stroke(status.color.opacity(0.3), lineWidth: 1)
                )
        )
        .onAppear {
            isPulsing = true
        }
    }
}

// MARK: - Activity Status Indicators

enum ActivityType: String, CaseIterable {
    case buy = "BUY"
    case sell = "SELL"
    case auction = "AUCTION"
    case bid = "BID"
    case transfer = "TRANSFER"

    var color: Color {
        switch self {
        case .buy: return .green
        case .sell: return .red
        case .auction: return .aqua.electricCyan
        case .bid: return .orange
        case .transfer: return .blue
        }
    }

    var icon: String {
        switch self {
        case .buy: return "arrow.down.circle.fill"
        case .sell: return "arrow.up.circle.fill"
        case .auction: return "hammer.fill"
        case .bid: return "hand.raised.fill"
        case .transfer: return "arrow.left.arrow.right.circle.fill"
        }
    }
}

struct ActivityBadge: View {
    let type: ActivityType
    let isRecent: Bool

    var body: some View {
        HStack(spacing: 4) {
            if isRecent {
                Image(systemName: type.icon)
                    .font(.caption2)
                    .foregroundColor(type.color)
            }

            Text(type.rawValue)
                .font(.aqua.captionSmall)
                .fontWeight(.bold)
                .foregroundColor(type.color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(type.color.opacity(0.15))
                .overlay(
                    Capsule()
                        .stroke(type.color.opacity(0.5), lineWidth: 1)
                )
        )
        .scaleEffect(isRecent ? 1.0 : 0.9)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isRecent)
    }
}