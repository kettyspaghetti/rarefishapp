import Foundation

class MockDataManager: ObservableObject {
    @Published var featuredFish: [Fish] = []
    @Published var allFish: [Fish] = []
    @Published var portfolio: Portfolio = Portfolio.sampleData
    @Published var marketTicker: [MarketTickerItem] = []

    init() {
        loadMockData()
    }

    private func loadMockData() {
        allFish = Fish.sampleData
        featuredFish = Array(Fish.sampleData.prefix(3))
        marketTicker = generateMarketTicker()
    }

    private func generateMarketTicker() -> [MarketTickerItem] {
        return Fish.sampleData.map { fish in
            MarketTickerItem(
                symbol: fish.name.prefix(3).uppercased() + String(fish.name.suffix(3).uppercased()),
                price: fish.price,
                changePercent: fish.priceChange24h
            )
        }
    }

    func getFishById(_ id: UUID) -> Fish? {
        return allFish.first { $0.id == id }
    }

    func getRandomFish() -> Fish {
        return allFish.randomElement() ?? Fish.sampleData[0]
    }
}

struct MarketTickerItem: Identifiable {
    let id = UUID()
    let symbol: String
    let price: Double
    let changePercent: Double
}