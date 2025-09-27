import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // Background color
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
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}