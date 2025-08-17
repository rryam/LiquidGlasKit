# LiquidGlasKit

A Swift package providing customizable modifiers for easy liquid glass effects and materials in SwiftUI applications.

## Features

- **GlassCardModifier**: Creates liquid glass card effects with adaptive transparency based on light/dark mode
- **SwiftUI Integration**: Easy-to-use view modifiers that integrate with your existing SwiftUI code
- **Adaptive Design**: Automatically adjusts appearance based on the current color scheme

## Requirements

- iOS 26.0+
- macOS 26.0+
- Swift 6.2+

## Installation

### Swift Package Manager

Add LiquidGlasKit to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/rryam/LiquidGlasKit.git", from: "0.0.1")
]
```

## Usage

### GlassCardModifier

The `GlassCardModifier` creates a beautiful liquid glass effect with a semi-transparent background that adapts to the current color scheme.

#### Basic Usage

```swift
import SwiftUI
import LiquidGlasKit

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .glassCard()
        }
        .padding()
    }
}
```

#### Custom Corner Radius

```swift
Text("Custom Glass Card")
    .padding()
    .glassCard(radius: 24)
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
