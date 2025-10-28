#if compiler(>=6.2)
import SwiftUI

/// A configurable modern glass background using the native glass effect APIs.
@available(iOS 26.0, macOS 26.0, *)
public struct GlassCardModernBackgroundView: View {
    public let radius: CGFloat
    public let fill: Color
    public let effect: Glass
    public let shape: RoundedCornerStyle
    
    /// Creates a modern glass background view.
    /// - Parameters:
    ///   - radius: Corner radius for the rounded rectangle shape.
    ///   - fill: Background fill color applied behind the glass effect.
    ///   - effect: The glass effect to apply. Defaults to `.clear.interactive()`.
    ///   - shape: The corner style for the rounded rectangle. Defaults to `.continuous`.
    public init(
        radius: CGFloat,
        fill: Color,
        effect: Glass = .clear.interactive(),
        shape: RoundedCornerStyle = .continuous
    ) {
        self.radius = radius
        self.fill = fill
        self.effect = effect
        self.shape = shape
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: radius, style: shape)
            .fill(fill)
            .glassEffect(effect, in: .rect(cornerRadius: radius))
    }
}

@available(iOS 26.0, macOS 26.0, *)
#Preview("Modern Glass Card") {
    VStack(spacing: 16) {
        Text("Modern Glass Card")
            .font(.headline)
        Text("This uses the native iOS 26 glass effect.")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    .padding()
    .background(
        GlassCardModernBackgroundView(radius: 20, fill: .white.opacity(0.12))
    )
    .padding()
    .background(
        LinearGradient(
            colors: [.indigo.opacity(0.4), .blue.opacity(0.6)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
}
#endif
