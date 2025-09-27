import Foundation
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