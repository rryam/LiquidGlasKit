import SwiftUI

/// A reusable legacy glass card background that mimics the pre-iOS 26 visual style.
///
/// This view provides a material-filled rounded rectangle with configurable shadows
/// and gradient stroke, allowing it to be reused outside of `GlassCardModifier`.
public struct GlassCardLegacyBackgroundView: View {
    public let radius: CGFloat
    public let materialOpacity: Double
    public let shadowColor: Color
    public let shadowRadius: CGFloat
    public let shadowOffset: CGSize
    public let strokeGradientColors: [Color]
    public let strokeLineWidth: CGFloat
    
    /// Creates a legacy glass card background.
    ///
    /// - Parameters:
    ///   - radius: Corner radius for the background shape.
    ///   - materialOpacity: Opacity applied to the ultra-thin material fill.
    ///   - shadowColor: Color for the drop shadow.
    ///   - shadowRadius: Blur radius for the drop shadow.
    ///   - shadowOffset: Offset for the drop shadow.
    ///   - strokeGradientColors: Colors used in the gradient stroke overlay.
    ///   - strokeLineWidth: Line width for the gradient stroke.
    public init(
        radius: CGFloat,
        materialOpacity: Double = 0.3,
        shadowColor: Color = Color.primary.opacity(0.1),
        shadowRadius: CGFloat = 20,
        shadowOffset: CGSize = CGSize(width: 0, height: 10),
        strokeGradientColors: [Color] = [
            Color.primary.opacity(0.3),
            Color.primary.opacity(0.3)
        ],
        strokeLineWidth: CGFloat = 0.5
    ) {
        self.radius = radius
        self.materialOpacity = materialOpacity
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.strokeGradientColors = strokeGradientColors
        self.strokeLineWidth = strokeLineWidth
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: radius, style: .continuous)
            .fill(.ultraThinMaterial.opacity(materialOpacity))
            .shadow(
                color: shadowColor,
                radius: shadowRadius,
                x: shadowOffset.width,
                y: shadowOffset.height
            )
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: strokeGradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: strokeLineWidth
                    )
            )
    }
}

#Preview {
    VStack(spacing: 16) {
        Text("Legacy Glass Card")
            .font(.headline)
        Text("This background matches the pre-iOS 26 fallback style.")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    .padding()
    .background(
        GlassCardLegacyBackgroundView(
            radius: 20,
            materialOpacity: 0.35,
            shadowColor: .black.opacity(0.12),
            strokeGradientColors: [
                Color.white.opacity(0.4),
                Color.white.opacity(0.1)
            ]
        )
    )
    .padding()
}
