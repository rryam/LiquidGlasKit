import SwiftUI

/// A compact comparison view that showcases the legacy (iOS 18) and modern (iOS 26) glass card styles.
///
/// The top card uses `GlassCardLegacyBackgroundView`, while the bottom card demonstrates
/// the new `GlassCardModernBackgroundView` when available.
public struct LiquidGlasKitComparisionView: View {
    public init() {}
    
    public var body: some View {
        VStack(spacing: 28) {
            legacyCard
            modernCard
        }
        .padding(24)
        .background(
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.25),
                    Color.purple.opacity(0.2),
                    Color.black.opacity(0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    private var legacyCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            label(title: "iOS 18 • Legacy style", systemImage: "clock.arrow.circlepath")
            Text("Classic frosted glass appearance with layered shadows and gradient borders.")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            GlassCardLegacyBackgroundView(radius: 12)
        )
    }
    
    @ViewBuilder
    private var modernCard: some View {
#if compiler(>=6.2)
        if #available(iOS 26.0, macOS 26.0, *) {
            VStack(alignment: .leading, spacing: 12) {
                label(title: "iOS 26 • Liquid Glass", systemImage: "sparkles")
                Text("Dynamic Liquid Glass material leveraging the latest glassEffect APIs.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                GlassCardModernBackgroundView(radius: 12, fill: .clear)
            )
        } else {
            legacyCard
        }
#else
        legacyCard
#endif
    }
    
    private func label(title: String, systemImage: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.accentColor)
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    LiquidGlasKitComparisionView()
        .preferredColorScheme(.dark)
}
