import SwiftUI

// MARK: - Enhanced Button Interactions

struct InteractiveButton<Content: View>: View {
    let content: Content
    let action: () -> Void
    let hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle

    @State private var isPressed = false
    @State private var showRipple = false
    @State private var rippleOffset = CGPoint.zero

    init(
        hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle = .medium,
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.action = action
        self.hapticStyle = hapticStyle
    }

    var body: some View {
        ZStack {
            content
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .brightness(isPressed ? -0.1 : 0)
                .animation(.easeOut(duration: 0.1), value: isPressed)

            // Ripple Effect
            if showRipple {
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 20, height: 20)
                    .position(rippleOffset)
                    .scaleEffect(showRipple ? 3 : 0)
                    .opacity(showRipple ? 0 : 1)
                    .animation(.easeOut(duration: 0.6), value: showRipple)
            }
        }
        .onTapGesture { location in
            performTap(at: location)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        withAnimation(.easeOut(duration: 0.1)) {
                            isPressed = true
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeOut(duration: 0.1)) {
                        isPressed = false
                    }
                }
        )
    }

    private func performTap(at location: CGPoint) {
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: hapticStyle)
        impactFeedback.impactOccurred()

        // Ripple effect
        rippleOffset = location
        withAnimation(.easeOut(duration: 0.6)) {
            showRipple = true
        }

        // Reset ripple
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            showRipple = false
        }

        // Execute action
        action()
    }
}

// MARK: - Loading States

struct LoadingState: View {
    let style: LoadingStyle
    @State private var isAnimating = false

    enum LoadingStyle {
        case dots
        case wave
        case shimmer
        case fishSwim
    }

    var body: some View {
        Group {
            switch style {
            case .dots:
                dotsLoading
            case .wave:
                waveLoading
            case .shimmer:
                shimmerLoading
            case .fishSwim:
                fishSwimLoading
            }
        }
        .onAppear {
            isAnimating = true
        }
    }

    private var dotsLoading: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.aqua.electricCyan)
                    .frame(width: 8, height: 8)
                    .scaleEffect(isAnimating ? 1.2 : 0.8)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        }
    }

    private var waveLoading: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.aqua.electricCyan)
                    .frame(width: 4, height: isAnimating ? 30 : 10)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.1),
                        value: isAnimating
                    )
            }
        }
    }

    private var shimmerLoading: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 100, height: 20)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.clear,
                                Color.white.opacity(0.4),
                                Color.clear
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .offset(x: isAnimating ? 100 : -100)
                    .animation(
                        Animation.linear(duration: 1.5)
                            .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            )
            .clipped()
    }

    private var fishSwimLoading: some View {
        HStack(spacing: 12) {
            Image(systemName: "fish.fill")
                .font(.title2)
                .foregroundColor(.aqua.electricCyan)
                .scaleEffect(isAnimating ? 1.1 : 0.9)
                .rotationEffect(.degrees(isAnimating ? 5 : -5))
                .animation(
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )

            WaveAnimation()
                .frame(height: 20)
        }
    }
}

// MARK: - Transition Animations

struct SlideTransition: ViewModifier {
    let direction: Direction
    let isActive: Bool

    enum Direction {
        case leading, trailing, top, bottom
    }

    func body(content: Content) -> some View {
        content
            .offset(offset)
            .opacity(isActive ? 1 : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isActive)
    }

    private var offset: CGSize {
        guard !isActive else { return .zero }

        switch direction {
        case .leading:
            return CGSize(width: -300, height: 0)
        case .trailing:
            return CGSize(width: 300, height: 0)
        case .top:
            return CGSize(width: 0, height: -300)
        case .bottom:
            return CGSize(width: 0, height: 300)
        }
    }
}

struct FadeSlideTransition: ViewModifier {
    let isActive: Bool
    let delay: Double

    func body(content: Content) -> some View {
        content
            .opacity(isActive ? 1 : 0)
            .offset(y: isActive ? 0 : 20)
            .animation(
                .spring(response: 0.6, dampingFraction: 0.8)
                .delay(delay),
                value: isActive
            )
    }
}

struct ScaleTransition: ViewModifier {
    let isActive: Bool
    let startScale: CGFloat

    func body(content: Content) -> some View {
        content
            .scaleEffect(isActive ? 1.0 : startScale)
            .opacity(isActive ? 1 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isActive)
    }
}

// MARK: - Gesture Interactions

struct PullToRefreshModifier: ViewModifier {
    @Binding var isRefreshing: Bool
    let onRefresh: () async -> Void

    @State private var pullOffset: CGFloat = 0
    @State private var isThresholdReached = false

    private let threshold: CGFloat = 100

    func body(content: Content) -> some View {
        content
            .offset(y: max(0, pullOffset))
            .overlay(
                refreshIndicator,
                alignment: .top
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.y > 0 && !isRefreshing {
                            pullOffset = value.translation.y * 0.5
                            isThresholdReached = pullOffset > threshold
                        }
                    }
                    .onEnded { _ in
                        if isThresholdReached && !isRefreshing {
                            withAnimation(.spring()) {
                                isRefreshing = true
                                pullOffset = threshold
                            }

                            Task {
                                await onRefresh()
                                await MainActor.run {
                                    withAnimation(.spring()) {
                                        isRefreshing = false
                                        pullOffset = 0
                                        isThresholdReached = false
                                    }
                                }
                            }
                        } else {
                            withAnimation(.spring()) {
                                pullOffset = 0
                                isThresholdReached = false
                            }
                        }
                    }
            )
    }

    private var refreshIndicator: some View {
        VStack {
            if pullOffset > 20 {
                HStack(spacing: 8) {
                    if isRefreshing {
                        LoadingState(style: .fishSwim)
                    } else {
                        Image(systemName: isThresholdReached ? "arrow.down.circle.fill" : "arrow.down.circle")
                            .font(.title2)
                            .foregroundColor(.aqua.electricCyan)
                            .rotationEffect(.degrees(isThresholdReached ? 180 : 0))
                            .animation(.spring(), value: isThresholdReached)
                    }

                    Text(isRefreshing ? "Refreshing..." : (isThresholdReached ? "Release to refresh" : "Pull to refresh"))
                        .font(.aqua.captionLarge)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
                .background(Color.aqua.glassOverlay)
                .clipShape(Capsule())
                .padding(.top, max(0, pullOffset - 60))
            }
        }
        .opacity(pullOffset > 20 ? 1 : 0)
        .animation(.easeOut(duration: 0.2), value: pullOffset)
    }
}

// MARK: - Card Interactions

struct CardFlipModifier: ViewModifier {
    @Binding var isFlipped: Bool
    let frontContent: AnyView
    let backContent: AnyView

    func body(content: Content) -> some View {
        ZStack {
            if isFlipped {
                backContent
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0, y: 1, z: 0)
                    )
            } else {
                frontContent
            }
        }
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.spring(response: 0.8, dampingFraction: 0.8), value: isFlipped)
    }
}

struct SwipeActionsModifier: ViewModifier {
    let leadingActions: [SwipeAction]
    let trailingActions: [SwipeAction]

    @State private var offset: CGFloat = 0
    @State private var activeAction: SwipeAction?

    func body(content: Content) -> some View {
        ZStack {
            // Action backgrounds
            HStack {
                if offset > 0 {
                    leadingActionsView
                }

                Spacer()

                if offset < 0 {
                    trailingActionsView
                }
            }

            // Main content
            content
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation.x

                            // Determine active action
                            if offset > 60 && !leadingActions.isEmpty {
                                activeAction = leadingActions.first
                            } else if offset < -60 && !trailingActions.isEmpty {
                                activeAction = trailingActions.first
                            } else {
                                activeAction = nil
                            }
                        }
                        .onEnded { _ in
                            if let action = activeAction {
                                // Execute action
                                action.action()

                                // Reset with animation
                                withAnimation(.spring()) {
                                    offset = 0
                                    activeAction = nil
                                }
                            } else {
                                // Return to center
                                withAnimation(.spring()) {
                                    offset = 0
                                }
                            }
                        }
                )
        }
    }

    private var leadingActionsView: some View {
        HStack {
            ForEach(leadingActions) { action in
                Button(action: action.action) {
                    VStack {
                        Image(systemName: action.icon)
                        Text(action.title)
                            .font(.caption)
                    }
                    .foregroundColor(.white)
                    .frame(width: 60)
                    .frame(maxHeight: .infinity)
                    .background(action.color)
                }
            }
            Spacer()
        }
    }

    private var trailingActionsView: some View {
        HStack {
            Spacer()
            ForEach(trailingActions) { action in
                Button(action: action.action) {
                    VStack {
                        Image(systemName: action.icon)
                        Text(action.title)
                            .font(.caption)
                    }
                    .foregroundColor(.white)
                    .frame(width: 60)
                    .frame(maxHeight: .infinity)
                    .background(action.color)
                }
            }
        }
    }
}

struct SwipeAction: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
}

// MARK: - View Extensions

extension View {
    func slideTransition(direction: SlideTransition.Direction, isActive: Bool) -> some View {
        modifier(SlideTransition(direction: direction, isActive: isActive))
    }

    func fadeSlideTransition(isActive: Bool, delay: Double = 0) -> some View {
        modifier(FadeSlideTransition(isActive: isActive, delay: delay))
    }

    func scaleTransition(isActive: Bool, startScale: CGFloat = 0.8) -> some View {
        modifier(ScaleTransition(isActive: isActive, startScale: startScale))
    }

    func pullToRefresh(isRefreshing: Binding<Bool>, onRefresh: @escaping () async -> Void) -> some View {
        modifier(PullToRefreshModifier(isRefreshing: isRefreshing, onRefresh: onRefresh))
    }

    func cardFlip(
        isFlipped: Binding<Bool>,
        @ViewBuilder front: () -> some View,
        @ViewBuilder back: () -> some View
    ) -> some View {
        modifier(CardFlipModifier(
            isFlipped: isFlipped,
            frontContent: AnyView(front()),
            backContent: AnyView(back())
        ))
    }

    func swipeActions(
        leading: [SwipeAction] = [],
        trailing: [SwipeAction] = []
    ) -> some View {
        modifier(SwipeActionsModifier(
            leadingActions: leading,
            trailingActions: trailing
        ))
    }

    func interactiveButton(
        hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle = .medium,
        action: @escaping () -> Void
    ) -> some View {
        InteractiveButton(hapticStyle: hapticStyle, action: action) {
            self
        }
    }
}