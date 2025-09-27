import SwiftUI

struct FloatingParticles: View {
    @State private var animateParticles = false
    let particleCount: Int
    let colors: [Color]

    init(particleCount: Int = 20, colors: [Color] = [.aqua.electricCyan, .aqua.roseGold, .white]) {
        self.particleCount = particleCount
        self.colors = colors
    }

    var body: some View {
        ZStack {
            ForEach(0..<particleCount, id: \.self) { index in
                Circle()
                    .fill(colors.randomElement() ?? .white)
                    .frame(width: CGFloat.random(in: 2...6))
                    .opacity(Double.random(in: 0.3...0.8))
                    .offset(
                        x: animateParticles ? CGFloat.random(in: -200...200) : CGFloat.random(in: -50...50),
                        y: animateParticles ? CGFloat.random(in: -300...300) : CGFloat.random(in: -100...100)
                    )
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 3...8))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...2)),
                        value: animateParticles
                    )
            }
        }
        .onAppear {
            animateParticles = true
        }
    }
}

struct WaveAnimation: View {
    @State private var phase = 0.0

    var body: some View {
        Wave(phase: phase)
            .stroke(Color.aqua.electricCyan.opacity(0.6), lineWidth: 2)
            .frame(height: 60)
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                    phase = .pi * 2
                }
            }
    }
}

struct Wave: Shape {
    var phase: Double

    var animatableData: Double {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let amplitude = height * 0.3

        path.move(to: CGPoint(x: 0, y: height / 2))

        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin(relativeX * .pi * 4 + phase)
            let y = height / 2 + amplitude * sine
            path.addLine(to: CGPoint(x: x, y: y))
        }

        return path
    }
}

struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.clear,
                                Color.white.opacity(0.4),
                                Color.clear
                            ],
                            startPoint: .init(x: phase - 0.3, y: 0),
                            endPoint: .init(x: phase, y: 0)
                        )
                    )
                    .animation(
                        Animation.linear(duration: 1.5)
                            .repeatForever(autoreverses: false),
                        value: phase
                    )
            )
            .onAppear {
                phase = 1.3
            }
    }
}

extension View {
    func shimmer() -> some View {
        modifier(ShimmerEffect())
    }
}