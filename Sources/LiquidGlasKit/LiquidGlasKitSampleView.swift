import SwiftUI

/// A comprehensive sample view showcasing all LiquidGlasKit effects.
///
/// This view demonstrates the various glass effects, blur effects, and modifiers
/// available in the LiquidGlasKit package, providing a visual reference for developers.
public struct LiquidGlasKitSampleView: View {
    @State private var selectedTab = 0
    @State private var scrollPosition: CGFloat = 0
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                // Glass Card Effects Tab
                glassCardEffectsView
                    .tabItem {
                        Image(systemName: "rectangle.3.group")
                        Text("Glass Cards")
                    }
                    .tag(0)
                
                // Glass Effects Tab
                glassEffectsView
                    .tabItem {
                        Image(systemName: "sparkles")
                        Text("Glass Effects")
                    }
                    .tag(1)
                
                // Scroll & Blur Effects Tab
                scrollAndBlurEffectsView
                    .tabItem {
                        Image(systemName: "scroll")
                        Text("Scroll & Blur")
                    }
                    .tag(2)
            }
            .navigationTitle("LiquidGlasKit Demo")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // MARK: - Glass Card Effects
    private var glassCardEffectsView: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // Default Glass Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Default Glass Card")
                        .font(.headline)
                    
                    Text("This is a default glass card with radius 16")
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("Featured Content")
                            .fontWeight(.medium)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .glassCard()
                
                // Custom Radius Glass Cards
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                    ForEach([8, 12, 20, 28], id: \.self) { radius in
                        Text("Radius \(radius)")
                            .font(.callout)
                            .bold()
                            .fontWeight(.medium)
                            .padding()
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .glassCard(radius: CGFloat(radius))
                    }
                }
                
                // Content Card Example
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Weather Update")
                                .font(.headline)
                            Text("Partly Cloudy")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("72°")
                            .font(.largeTitle)
                            .fontWeight(.thin)
                            .fontWidth(.expanded)
                    }
                    
                    HStack {
                        ForEach(0..<5) { _ in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.indigo.opacity(0.7))
                        }
                    }
                }
                .padding()
                .glassCard(radius: 16)
            }
            .padding(.horizontal)
        }
        .background(
            LinearGradient(
                colors: [.indigo.opacity(0.5),
                         .indigo.opacity(0.3),
                         .indigo.opacity(0.1)],
                startPoint: .top,
                endPoint: .center
            )
        )
    }
    
    // MARK: - Glass Effects
    private var glassEffectsView: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Glass Effects")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("These effects require iOS 26.0+ and macOS 26.0+ to display properly")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Glass Effect Types
                VStack(spacing: 16) {
                    Text("Glass Effect Types")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                        // Clear Effect
                        VStack {
                            Rectangle()
                                .fill(Color.blue.opacity(0.3))
                                .frame(height: 80)
                                .applyGlassEffect(.clear, cornerRadius: 12)
                            
                            Text("Clear")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        
                        // Regular Effect
                        VStack {
                            Rectangle()
                                .fill(Color.green.opacity(0.3))
                                .frame(height: 80)
                                .applyGlassEffect(.regular, cornerRadius: 12)
                            
                            Text("Regular")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        
                        // Clear Interactive
                        VStack {
                            Rectangle()
                                .fill(Color.orange.opacity(0.3))
                                .frame(height: 80)
                                .applyGlassEffect(.clearInteractive, cornerRadius: 12)
                            
                            Text("Clear Interactive")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        
                        // Regular Interactive
                        VStack {
                            Rectangle()
                                .fill(Color.red.opacity(0.3))
                                .frame(height: 80)
                                .applyGlassEffect(.regularInteractive, cornerRadius: 12)
                            
                            Text("Regular Interactive")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Glass Shapes
                VStack(spacing: 16) {
                    Text("Glass Shapes")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                        // Rectangle
                        VStack {
                            Rectangle()
                                .fill(Color.blue.opacity(0.3))
                                .frame(height: 80)
                                .applyGlassEffect(.clearInteractive, shape: .rect)
                            
                            Text("Rectangle")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        
                        // Rounded Rectangle
                        VStack {
                            Rectangle()
                                .fill(Color.purple.opacity(0.3))
                                .frame(height: 80)
                                .applyGlassEffect(.clearInteractive, shape: .roundedRect(cornerRadius: 20))
                            
                            Text("Rounded Rect")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        
                        // Capsule
                        VStack {
                            Rectangle()
                                .fill(Color.pink.opacity(0.3))
                                .frame(height: 80)
                                .applyGlassEffect(.clearInteractive, shape: .capsule)
                            
                            Text("Capsule")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        
                        // Circle
                        VStack {
                            Circle()
                                .fill(Color.cyan.opacity(0.3))
                                .frame(width: 80, height: 80)
                                .applyGlassEffect(.clearInteractive, shape: .circle)
                            
                            Text("Circle")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Tinted Glass Effects
                VStack(spacing: 16) {
                    Text("Tinted Glass Effects")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                        ForEach([Color.red, Color.green, Color.blue, Color.orange, Color.purple, Color.pink], id: \.self) { color in
                            VStack {
                                Rectangle()
                                    .fill(color.opacity(0.2))
                                    .frame(height: 60)
                                    .applyGlassEffect(.clearInteractive, cornerRadius: 8, tint: color)
                                
                                Text(colorName(for: color))
                                    .font(.caption2)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(
            LinearGradient(
                colors: [.green.opacity(0.1), .blue.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    // MARK: - Scroll and Blur Effects
    private var scrollAndBlurEffectsView: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header explaining the effects
                VStack(spacing: 8) {
                    Text("Scroll & Blur Effects")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Scroll to see edge effects in action")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGroupedBackground))
                
                TabView {
                    // Scroll Edge Effect - Off
                    scrollContent(title: "No Edge Effect", effect: .off)
                        .tabItem {
                            Text("Off")
                        }
                    
                    // Scroll Edge Effect - Hard
                    scrollContent(title: "Hard Edge Effect", effect: .hard)
                        .tabItem {
                            Text("Hard")
                        }
                    
                    // Scroll Edge Effect - Soft
                    scrollContent(title: "Soft Edge Effect", effect: .soft)
                        .tabItem {
                            Text("Soft")
                        }
                    
                    // Scroll Edge Effect - Auto
                    scrollContent(title: "Auto Edge Effect", effect: .auto)
                        .tabItem {
                            Text("Auto")
                        }
                    
                    // Custom Nav Bar Blur
                    customBlurContent()
                        .tabItem {
                            Text("Custom Blur")
                        }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
        }
        .navigationBarHidden(true)
    }
    
    private func scrollContent(title: String, effect: EffectState) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                ForEach(0..<50, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Item \(index + 1)")
                                .font(.headline)
                            Text("Scroll to see the edge effect behavior")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .glassCard()
                }
            }
            .padding(.horizontal)
        }
        .applyScrollEdgeEffect(effect)
    }
    
    private func customBlurContent() -> some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Custom Navigation Bar Blur")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Text("This demonstrates the custom blur overlay")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                ForEach(0..<30, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Blur Demo \(index + 1)")
                                .font(.headline)
                            Spacer()
                            Text("🌟")
                        }
                        
                        Text("The custom navigation bar blur creates a beautiful overlay effect at the top of the screen.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .glassCard()
                }
            }
            .padding(.horizontal)
        }
        .customNavBarBlur(.blue)
    }
    
    // MARK: - Helper Functions
    private func colorName(for color: Color) -> String {
        switch color {
        case .red: return "Red"
        case .green: return "Green"
        case .blue: return "Blue"
        case .orange: return "Orange"
        case .purple: return "Purple"
        case .pink: return "Pink"
        default: return "Color"
        }
    }
}

// MARK: - Preview
#Preview {
    LiquidGlasKitSampleView()
}
