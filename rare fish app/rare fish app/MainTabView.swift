import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Home")
                }
                .tag(0)

            DiscoveryView()
                .tabItem {
                    Image(systemName: "location")
                    Text("Discover")
                }
                .tag(1)

            TradingView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Trade")
                }
                .tag(2)

            PortfolioView()
                .tabItem {
                    Image(systemName: "diamond")
                    Text("Collection")
                }
                .tag(3)

            ProfileView()
                .tabItem {
                    Image(systemName: "crown")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(Color(hex: "00D4FF"))
        .background(Color(hex: "0A0E1A").ignoresSafeArea())
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
}