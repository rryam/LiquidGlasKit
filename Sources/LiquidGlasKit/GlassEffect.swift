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

/// Represents the available shapes that can be applied to a glass effect.
public enum GlassShape: Equatable {
    
    /// No specific shape.
    /// Defaults to a container-relative shape (adapts based on container's style).
    case none
    
    /// A standard rectangle shape.
    case rect
    
    /// A rounded rectangle shape with a specified corner radius.
    /// - Parameter cornerRadius: The radius to apply to each corner.
    case roundedRect(cornerRadius: CGFloat)
    
    /// A concentric shape (new in iOS 26).
    /// Falls back to a rounded rectangle with radius `26.0` on older versions.
    case concentric
    
    /// A capsule shape (pill-like, stretched to container dimensions).
    case capsule
    
    /// A circle shape (forces equal width and height).
    case circle
    
    /// Returns the corresponding SwiftUI `Shape` for the enum case.
    var shape: any Shape {
        get {
            switch self {
            case .none:
                // Adapts to the container's relative shape
                return .containerRelative
                
            case .rect:
                return .rect
                
            case .roundedRect(let cornerRadius):
                return .rect(cornerRadius: cornerRadius)
                
            case .concentric:
#if compiler(>=6.2)
                if #available(iOS 26.0, macOS 26.0, *) {
                    // Uses the new concentric corners API
                    return .rect(corners: .concentric, isUniform: true)
                } else {
                    // Fallback to rounded rect for older iOS
                    return .rect(cornerRadius: 26.0)
                }
#else
                // Fallback to rounded rect for older iOS
                return .rect(cornerRadius: 26.0)
#endif
                
            case .capsule:
                return .capsule
                
            case .circle:
                return .circle
            }
        }
    }
}

/// A modifier that applies a glass effect with optional corner radius and tint.
///
/// This modifier provides the implementation for the glass effect functionality,
/// utilizing iOS 26.0's native glass effects when available.
struct GlassEffectModifier: ViewModifier {
    /// The type of glass effect to apply.
    let effect: GlassEffect
    
    /// The optional shape for the glass effect.
    let shape: GlassShape?
    
    /// The optional tint color for the glass effect.
    let tint: Color?
    
    @ViewBuilder
    func body(content: Content) -> some View {
#if compiler(>=6.2)
        if #available(iOS 26.0, macOS 26.0, *) {
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
            
            // Apply shape if provided
            if let shape, shape != .none {
                content.glassEffect(glassWithTint, in: AnyShape(shape.shape))
                    .clipShape(AnyShape(shape.shape))
            } else {
                content.glassEffect(glassWithTint)
            }
        } else {
            content
        }
#else
        content
#endif
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
        let shape: GlassShape? = cornerRadius != nil ? .roundedRect(cornerRadius: cornerRadius!) : nil
        return modifier(GlassEffectModifier(effect: effect, shape: shape, tint: tint))
    }
    
    /// Applies a glass effect with a specific shape and optional tint.
    ///
    /// This modifier provides fine-grained control over the glass effect appearance,
    /// allowing you to specify the type of glass effect, shape, and tint color.
    /// The glass effect is only available on iOS 26.0 and later.
    ///
    /// ```swift
    /// Rectangle()
    ///     .frame(width: 200, height: 100)
    ///     .applyGlassEffect(.regularInteractive, shape: .capsule, tint: .blue)
    /// ```
    ///
    /// - Parameters:
    ///   - effect: The type of glass effect to apply. Defaults to `.clearInteractive`.
    ///   - shape: The shape to apply to the glass effect. If `nil`, no specific shape is applied.
    ///   - tint: An optional tint color. If `nil`, no tint is applied.
    /// - Returns: A view with the specified glass effect applied.
    func applyGlassEffect(_ effect: GlassEffect = .clearInteractive, shape: GlassShape? = nil, tint: Color? = nil) -> some View {
        return modifier(GlassEffectModifier(effect: effect, shape: shape, tint: tint))
    }
}
