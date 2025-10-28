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
#if compiler(>=6.2)
            .background {
                if #available(iOS 26.0, macOS 26.0, *) {
                    GlassCardModernBackgroundView(radius: radius, fill: fill)
                } else {
                    GlassCardLegacyBackgroundView(radius: radius)
                }
            }
#else
            .background(GlassCardLegacyBackgroundView(radius: radius))
#endif
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
}
