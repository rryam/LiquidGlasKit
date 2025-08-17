import SwiftUI

public struct GlassCardModifier: ViewModifier {
    @Environment(\.colorScheme) var scheme
    public let radius: CGFloat
    
    var fill: Color {
        switch scheme {
        case .dark:
            return Color.clear.opacity(0.1)
        case .light:
            return Color.secondary.opacity(0.1)
        @unknown default:
            return Color.clear
        }
    }
    
    public init(radius: CGFloat = 16) {
        self.radius = radius
    }
    
    public func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(fill)
                    .glassEffect(.clear.interactive(), in: .rect(cornerRadius: radius))
            }
    }
}

public extension View {
    func glassCard(radius: CGFloat = 16) -> some View {
        modifier(GlassCardModifier(radius: radius))
    }

    /// Applies a **glass effect** with optional corner radius and tint.
    ///
    /// - Parameters:
    ///   - effect: The `GlassEffect` type to apply. Default is `.clearInteractive`.
    ///   - cornerRadius: An optional custom corner radius. If `nil`, no corner radius is applied.
    ///   - tint: An optional tint color. If `nil`, no tint is applied.
    func applyGlassEffect(_ effect: GlassEffect = .clearInteractive, cornerRadius: CGFloat? = nil, tint: Color? = nil) -> some View {
        modifier(GlassEffectModifier(effect: effect, cornerRadius: cornerRadius, tint: tint))
    }

    /// Applies a custom blurred accent-colored overlay to the navigation bar. Can be used as alternative for scrollEdgeEffect for top (status bar) pre-iOS 26
    /// - Parameter accent: The accent color for the blur. Defaults to `.primary`.
    func customNavBarBlur(_ accent: Color = .primary) -> some View {
        modifier(CustomNavBarBlurModifier(accent: accent))
    }
    
    /// Applies a **scroll edge effect style**. Defaults to customNavBlur to statusBar area pre-iOS 26
    ///
    /// - Parameter effect: The `EffectState` for scroll edge behavior.
    func applyScrollEdgeEffect(_ effect: EffectState) -> some View {
        modifier(ScrollEdgeEffectModifier(effect: effect))
    }
}

// MARK: - Supporting Types

/// Defines possible **scroll edge effect states**.
enum EffectState {
    case off, hard, soft, auto
}

/// Defines possible **glass effect variants**.
enum GlassEffect {
    case clear, regular, clearInteractive, regularInteractive
}

// MARK: - Modifiers

/// A modifier that applies a glass effect with optional corner radius and tint.
struct GlassEffectModifier: ViewModifier {
    let effect: GlassEffect
    let cornerRadius: CGFloat?
    let tint: Color?
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            var base: Glass
            
            // Choose effect type
            switch effect {
            case .clear:
                base = .clear
                
            case .regular:
                base = .regular
                
            case .clearInteractive:
                base = .clear.interactive()
                
            case .regularInteractive:
                base = .regular.interactive()
            }
            
            // Apply tint if provided
            if let tint {
                base = base.tint(tint)
            }
            
            // Apply corner radius shape if provided
            if let cornerRadius {
                content.glassEffect(base, in: .rect(cornerRadius: cornerRadius))
            } else {
                content.glassEffect(base)
            }
        } else {
            content
        }
    }
}


/// A modifier that applies a blurred accent overlay to the navigation bar.
struct CustomNavBarBlurModifier: ViewModifier {
    
    var accent: Color = .primary
    
    func body(content: Content) -> some View {
        content.overlay {
            ZStack {
                Rectangle()
                    .foregroundStyle(accent)
                    .blur(radius: 15)
                    .frame(width: 1200, height: 100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, -40)
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
        }
    }
}

/// A modifier that applies a scroll edge effect style.
struct ScrollEdgeEffectModifier: ViewModifier {
    let effect: EffectState
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            switch effect {
            case .off:
                content.scrollEdgeEffectStyle(.none, for: .all)
            case .hard:
                content.scrollEdgeEffectStyle(.hard, for: .all)
            case .soft:
                content.scrollEdgeEffectStyle(.soft, for: .all)
            case .auto:
                content.scrollEdgeEffectStyle(.automatic, for: .all)
            }
        } else {
            content
                .customNavBarBlur()
        }
    }
}
