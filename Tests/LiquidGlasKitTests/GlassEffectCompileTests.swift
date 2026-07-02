import SwiftUI
import Testing
@testable import LiquidGlasKit

@MainActor
@Test func applyGlassEffectOverloadsCompile() {
    _ = Text("Default glass").applyGlassEffect()
    _ = Text("Tinted glass").applyGlassEffect(tint: .blue)
    _ = Text("Rounded glass").applyGlassEffect(.regularInteractive, cornerRadius: 12, tint: .blue)
    _ = Text("Capsule glass").applyGlassEffect(.clearInteractive, shape: .capsule, tint: .blue)
    _ = Text("Explicit no shape").applyGlassEffect(.regular, shape: nil)
}
