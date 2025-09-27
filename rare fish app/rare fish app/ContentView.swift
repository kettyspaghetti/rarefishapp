import SwiftUI

enum AppPhase {
    case splash
    case authentication
    case main
}

class AppState: ObservableObject {
    @Published var currentPhase: AppPhase = .splash
    @Published var isAuthenticated = false
    @Published var selectedTab = 0

    func authenticate() {
        withAnimation(.easeInOut(duration: 0.8)) {
            isAuthenticated = true
            currentPhase = .main
        }
    }

    func completeSplash() {
        withAnimation(.easeInOut(duration: 0.6)) {
            currentPhase = .authentication
        }
    }
}

struct ContentView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            switch appState.currentPhase {
            case .splash:
                SplashView()
                    .environmentObject(appState)
            case .authentication:
                AuthenticationView()
                    .environmentObject(appState)
            case .main:
                MainTabView()
                    .environmentObject(appState)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: appState.currentPhase)
        .preferredColorScheme(.dark)
    }
}
