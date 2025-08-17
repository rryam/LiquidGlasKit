import SwiftUI

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

public extension View {
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