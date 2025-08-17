import SwiftUI

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

public extension View {
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
}