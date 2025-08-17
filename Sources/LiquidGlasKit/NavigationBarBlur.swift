import SwiftUI

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

public extension View {
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
}