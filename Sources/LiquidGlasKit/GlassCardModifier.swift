import SwiftUI

/// A view modifier that applies a glass card effect with customizable corner radius.
///
/// The glass card modifier creates a translucent background with a glass-like appearance
/// that adapts to the current color scheme. In dark mode, it uses a clear overlay,
/// while in light mode, it uses a secondary color overlay.
///
/// ```swift
/// Text("Hello, World!")
///     .glassCard(radius: 20)
/// ```
public struct GlassCardModifier: ViewModifier {
    @Environment(\.colorScheme) var scheme
    
    /// The corner radius for the glass card background.
    public let radius: CGFloat
    
    /// The fill color for the glass card, determined by the current color scheme.
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
    
    /// Creates a glass card modifier with the specified corner radius.
    ///
    /// - Parameter radius: The corner radius for the glass card. Defaults to 16 points.
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
    /// Applies a glass card effect to the view.
    ///
    /// The glass card effect creates a translucent background with rounded corners
    /// that provides a modern, glass-like appearance.
    ///
    /// ```swift
    /// VStack {
    ///     Text("Content")
    /// }
    /// .glassCard(radius: 12)
    /// ```
    ///
    /// - Parameter radius: The corner radius for the glass card. Defaults to 16 points.
    /// - Returns: A view with the glass card effect applied.
    func glassCard(radius: CGFloat = 16) -> some View {
        modifier(GlassCardModifier(radius: radius))
    }
    
    /// Applies a glass effect with optional corner radius and tint.
    ///
    /// This modifier provides fine-grained control over the glass effect appearance,
    /// allowing you to specify the type of glass effect, corner radius, and tint color.
    /// The glass effect is only available on iOS 26.0 and later.
    ///
    /// ```swift
    /// Rectangle()
    ///     .frame(width: 200, height: 100)
    ///     .applyGlassEffect(.regularInteractive, cornerRadius: 12, tint: .blue)
    /// ```
    ///
    /// - Parameters:
    ///   - effect: The type of glass effect to apply. Defaults to `.clearInteractive`.
    ///   - cornerRadius: An optional corner radius. If `nil`, no corner radius is applied.
    ///   - tint: An optional tint color. If `nil`, no tint is applied.
    /// - Returns: A view with the specified glass effect applied.
    func applyGlassEffect(_ effect: GlassEffect = .clearInteractive, cornerRadius: CGFloat? = nil, tint: Color? = nil) -> some View {
        modifier(GlassEffectModifier(effect: effect, cornerRadius: cornerRadius, tint: tint))
    }
    
    /// Applies a custom blurred accent-colored overlay to the navigation bar area.
    ///
    /// This modifier creates a blurred overlay at the top of the view, which can be used
    /// as an alternative to `scrollEdgeEffect` for the status bar area on iOS versions
    /// prior to iOS 26.
    ///
    /// ```swift
    /// ScrollView {
    ///     // Content
    /// }
    /// .customNavBarBlur(.blue)
    /// ```
    ///
    /// - Parameter accent: The accent color for the blur effect. Defaults to `.primary`.
    /// - Returns: A view with the custom navigation bar blur effect applied.
    func customNavBarBlur(_ accent: Color = .primary) -> some View {
        modifier(CustomNavBarBlurModifier(accent: accent))
    }
    
    /// Applies a scroll edge effect style to the view.
    ///
    /// This modifier controls how the view behaves when scrolling reaches the edges.
    /// On iOS 26.0 and later, it uses the system's scroll edge effect styles.
    /// On earlier versions, it falls back to a custom navigation bar blur effect.
    ///
    /// ```swift
    /// ScrollView {
    ///     // Content
    /// }
    /// .applyScrollEdgeEffect(.soft)
    /// ```
    ///
    /// - Parameter effect: The scroll edge effect state to apply.
    /// - Returns: A view with the specified scroll edge effect applied.
    func applyScrollEdgeEffect(_ effect: EffectState) -> some View {
        modifier(ScrollEdgeEffectModifier(effect: effect))
    }
}

// MARK: - Supporting Types

/// Defines the possible scroll edge effect states.
///
/// These states control how a view behaves when scrolling reaches the edges,
/// providing different visual feedback and interaction patterns.
public enum EffectState {
    /// No scroll edge effect is applied.
    case off
    
    /// A hard scroll edge effect with distinct visual feedback.
    case hard
    
    /// A soft scroll edge effect with subtle visual feedback.
    case soft
    
    /// Automatic scroll edge effect that adapts to the system preferences.
    case auto
}

/// Defines the possible glass effect variants.
///
/// Glass effects provide different levels of transparency and interactivity,
/// allowing for various visual styles in your user interface.
public enum GlassEffect {
    /// A clear glass effect with minimal visual impact.
    case clear
    
    /// A regular glass effect with standard opacity and blur.
    case regular
    
    /// A clear glass effect that responds to user interaction.
    case clearInteractive
    
    /// A regular glass effect that responds to user interaction.
    case regularInteractive
}

// MARK: - Modifiers

/// A modifier that applies a glass effect with optional corner radius and tint.
///
/// This modifier provides the implementation for the glass effect functionality,
/// utilizing iOS 26.0's native glass effects when available.
struct GlassEffectModifier: ViewModifier {
    /// The type of glass effect to apply.
    let effect: GlassEffect
    
    /// The optional corner radius for the glass effect.
    let cornerRadius: CGFloat?
    
    /// The optional tint color for the glass effect.
    let tint: Color?
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            // Choose effect type and apply modifications
            let base: Glass = {
                switch effect {
                case .clear:
                    return .clear
                case .regular:
                    return .regular
                case .clearInteractive:
                    return .clear.interactive()
                case .regularInteractive:
                    return .regular.interactive()
                }
            }()
            
            // Apply tint if provided
            let glassWithTint = tint != nil ? base.tint(tint!) : base
            
            // Apply corner radius shape if provided
            if let cornerRadius {
                content.glassEffect(glassWithTint, in: .rect(cornerRadius: cornerRadius))
            } else {
                content.glassEffect(glassWithTint)
            }
        } else {
            content
        }
    }
}

/// A modifier that applies a blurred accent overlay to the navigation bar area.
///
/// This modifier creates a visual effect that simulates a blurred navigation bar
/// by overlaying a blurred rectangle at the top of the view.
struct CustomNavBarBlurModifier: ViewModifier {
    /// The accent color for the blur effect.
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
///
/// This modifier handles the application of scroll edge effects, using native
/// iOS 26.0 functionality when available and falling back to custom implementations
/// on earlier versions.
struct ScrollEdgeEffectModifier: ViewModifier {
    /// The scroll edge effect state to apply.
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
