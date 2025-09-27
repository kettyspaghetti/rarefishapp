import Foundation

enum RarityLevel: String, CaseIterable {
    case common = "Common"
    case rare = "Rare"
    case ultraRare = "Ultra Rare"
    case mythic = "Mythic"
    case legendary = "Legendary"

    var color: String {
        switch self {
        case .common: return "gray"
        case .rare: return "yellow"
        case .ultraRare: return "purple"
        case .mythic: return "cyan"
        case .legendary: return "black"
        }
    }

    var multiplier: Double {
        switch self {
        case .common: return 1.0
        case .rare: return 2.5
        case .ultraRare: return 5.0
        case .mythic: return 10.0
        case .legendary: return 25.0
        }
    }
}

enum VerificationLevel: String, CaseIterable {
    case bronze = "Bronze"
    case silver = "Silver"
    case gold = "Gold"
    case platinum = "Platinum"

    var checkmarks: String {
        switch self {
        case .bronze: return "✓"
        case .silver: return "✓✓"
        case .gold: return "✓✓✓"
        case .platinum: return "✓✓✓✓"
        }
    }
}

struct Fish: Identifiable, Codable {
    let id = UUID()
    let name: String
    let scientificName: String
    let price: Double
    let priceChange24h: Double
    let rarity: RarityLevel
    let verification: VerificationLevel
    let origin: String
    let available: Int
    let size: Double
    let maxSize: Double
    let age: Double
    let colorationIndex: Int
    let vitality: Int
    let activityLevel: String
    let lastHealthCheck: String
    let imageURL: String?
    let description: String

    static let sampleData: [Fish] = [
        Fish(
            name: "Platinum Arowana",
            scientificName: "Scleropages formosus",
            price: 45000,
            priceChange24h: 8.5,
            rarity: .legendary,
            verification: .platinum,
            origin: "Indonesia",
            available: 3,
            size: 28.5,
            maxSize: 32.0,
            age: 4.2,
            colorationIndex: 98,
            vitality: 95,
            activityLevel: "High",
            lastHealthCheck: "2 days ago",
            imageURL: nil,
            description: "The crown jewel of Asian arowanas, this platinum specimen displays unparalleled metallic luster and perfect fin formation."
        ),
        Fish(
            name: "Peppermint Angelfish",
            scientificName: "Paracentropyge boylei",
            price: 30000,
            priceChange24h: -2.3,
            rarity: .mythic,
            verification: .gold,
            origin: "Pacific Ocean",
            available: 7,
            size: 6.8,
            maxSize: 7.5,
            age: 2.1,
            colorationIndex: 92,
            vitality: 88,
            activityLevel: "Moderate",
            lastHealthCheck: "1 day ago",
            imageURL: nil,
            description: "Extremely rare deep-water angelfish with distinctive red and white banding. Found only in specific Pacific depths."
        ),
        Fish(
            name: "Masked Angelfish",
            scientificName: "Genicanthus personatus",
            price: 15000,
            priceChange24h: 5.2,
            rarity: .ultraRare,
            verification: .gold,
            origin: "Hawaii",
            available: 12,
            size: 18.2,
            maxSize: 20.0,
            age: 3.8,
            colorationIndex: 85,
            vitality: 92,
            activityLevel: "High",
            lastHealthCheck: "3 days ago",
            imageURL: nil,
            description: "Endemic to Hawaiian waters, this elegant angelfish features distinctive facial markings and graceful swimming patterns."
        ),
        Fish(
            name: "Clarion Angelfish",
            scientificName: "Holacanthus clarionensis",
            price: 8500,
            priceChange24h: 12.1,
            rarity: .rare,
            verification: .silver,
            origin: "Mexico",
            available: 18,
            size: 15.4,
            maxSize: 18.0,
            age: 2.9,
            colorationIndex: 78,
            vitality: 89,
            activityLevel: "Moderate",
            lastHealthCheck: "1 day ago",
            imageURL: nil,
            description: "Vibrant orange angelfish from the Clarion Islands, known for its bold coloration and hardy nature."
        ),
        Fish(
            name: "Wrought Iron Butterflyfish",
            scientificName: "Chaetodon daedalma",
            price: 3500,
            priceChange24h: -1.8,
            rarity: .rare,
            verification: .bronze,
            origin: "Japan",
            available: 25,
            size: 12.1,
            maxSize: 15.0,
            age: 1.8,
            colorationIndex: 82,
            vitality: 91,
            activityLevel: "High",
            lastHealthCheck: "2 days ago",
            imageURL: nil,
            description: "Distinctive Japanese butterflyfish with metallic dark coloration and elegant yellow trim."
        ),
        Fish(
            name: "Candy Basslet",
            scientificName: "Liopropoma carmabi",
            price: 1200,
            priceChange24h: 3.7,
            rarity: .common,
            verification: .bronze,
            origin: "Caribbean",
            available: 45,
            size: 4.2,
            maxSize: 5.0,
            age: 1.2,
            colorationIndex: 75,
            vitality: 86,
            activityLevel: "Moderate",
            lastHealthCheck: "1 day ago",
            imageURL: nil,
            description: "Colorful Caribbean basslet with purple and yellow striping, perfect for nano reef systems."
        )
    ]
}

struct Portfolio: Codable {
    let totalValue: Double
    let fishCount: Int
    let rarityScore: Int
    let badges: [String]
    let change24h: Double
    let changePercent: Double

    static let sampleData = Portfolio(
        totalValue: 127450,
        fishCount: 23,
        rarityScore: 9450,
        badges: ["early_adopter", "rare_collector", "verified_breeder"],
        change24h: 3200,
        changePercent: 2.5
    )
}