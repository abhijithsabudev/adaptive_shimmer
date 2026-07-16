# 🎨 Adaptive Shimmer

<div align="center">

**The most powerful, lightweight skeleton loader for Flutter.** Zero dependencies, infinite possibilities.

[![Pub Version](https://img.shields.io/pub/v/adaptive_shimmer)](https://pub.dev/packages/adaptive_shimmer)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/abhijithsabudev/adaptive_shimmer?style=flat)](https://github.com/abhijithsabudev/adaptive_shimmer)

[Features](#-features) • [Installation](#-installation) • [Quick Start](#-quick-start) • [Examples](#-examples) • [API](#-api-reference)

</div>

---

## ✨ Features

### 🎯 Core Features
- **Zero External Dependencies** - Pure Flutter, no bloat
- **Multiple Animation Types** - Shimmer, Pulse, Combined
- **8-Direction Shimmer** - LTR, RTL, TTB, BTB, and 4 diagonal directions
- **Staggered Shimmer** - Cascade effect for multiple widgets
- **Smooth Transitions** - Elegant fade from loading to content
- **Screen-Wide Shimmer** - Page-level loading states
- **Shimmer Exclude** - Keep certain widgets visible during loading
- **Intensity Control** - Adjust shimmer brightness (0.0 - 1.0)

### 📦 Pre-built Components
- **Skeleton Widgets** - Box, Circle, Line, Paragraph
- **Themed Support** - Auto light/dark mode detection
- **Custom Colors & Gradients** - Full customization
- **Highly Performant** - GPU-accelerated animations

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  adaptive_shimmer: ^1.0.0
```

Then run:
```bash
flutter pub get
```

---

## 🚀 Quick Start

### 1. Basic Shimmer (Widget-level)

```dart
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

AdaptiveShimmer(
  loading: isLoading,
  child: MyContentWidget(),
)
```

### 2. Screen-Wide Shimmer (Page-level)

```dart
ScreenShimmer(
  loading: isLoading,
  child: Scaffold(
    appBar: AppBar(title: Text('My App')),
    body: MyPageContent(),
  ),
)
```

### 3. Staggered Shimmer (Cascade effect)

```dart
StaggeredShimmer(
  children: [
    ShimmerBox(width: 300, height: 100),
    SizedBox(height: 16),
    ShimmerLine(width: 250),
    SizedBox(height: 8),
    ShimmerLine(width: 200),
  ],
  staggerDuration: Duration(milliseconds: 200),
)
```

### 4. Smooth Transition

```dart
ShimmerTransition(
  loading: isLoading,
  loadingChild: SkeletonParagraph(width: double.infinity),
  child: ActualContent(),
  transitionDuration: Duration(milliseconds: 500),
)
```

---

## 🎨 Animation Types

### Shimmer (Default)
Classic left-to-right wave effect.

```dart
AdaptiveShimmer(
  loading: true,
  animationType: AnimationType.shimmer,
  child: MyWidget(),
)
```

### Pulse
Smooth fade in/out effect.

```dart
AdaptiveShimmer(
  loading: true,
  animationType: AnimationType.pulse,
  child: MyWidget(),
)
```

### Combined
Shimmer + Pulse for enhanced feedback.

```dart
AdaptiveShimmer(
  loading: true,
  animationType: AnimationType.combined,
  child: MyWidget(),
)
```

---

## 🧭 Direction Control

Apply shimmer in any direction:

```dart
AdaptiveShimmer(
  loading: true,
  direction: ShimmerDirection.diagonalLTR, // or .ltr, .rtl, .ttb, .wave, etc.
  child: MyWidget(),
)
```

**Supported Directions:**
- `ltr` - Left to Right
- `rtl` - Right to Left  
- `ttb` - Top to Bottom
- `btt` - Bottom to Top
- `diagonalLTR` - Diagonal (top-left to bottom-right)
- `diagonalRTL` - Diagonal (top-right to bottom-left)
- `diagonalBLTR` - Diagonal (bottom-left to top-right)
- `wave` - Wave pattern

---

## 💡 Advanced Features

### Intensity Control

Control shimmer brightness:

```dart
AdaptiveShimmer(
  loading: true,
  intensity: 0.5, // 0.0 (subtle) to 1.0 (bright)
  child: MyWidget(),
)
```

### Custom Colors

```dart
AdaptiveShimmer(
  loading: true,
  baseColor: Color(0xFFE0E0E0),
  highlightColor: Color(0xFFFFF8E1),
  child: MyWidget(),
)
```

### Exclude Widgets from Screen Shimmer

```dart
ScreenShimmer(
  loading: isLoading,
  child: Column(
    children: [
      // Will shimmer
      MyContent(),
      
      // Won't shimmer - stays interactive
      ShimmerExclude(
        child: ElevatedButton(
          onPressed: retryFunction,
          child: Text('Retry'),
        ),
      ),
    ],
  ),
)
```

---

## 📱 Examples

### Product Card

```dart
ShimmerTransition(
  loading: isLoading,
  loadingChild: SkeletonProductCard(),
  child: ProductCard(product: product),
)
```

### Profile Page

```dart
ScreenShimmer(
  loading: isLoading,
  child: ProfilePage(),
)
```

### Feed List

```dart
StaggeredShimmer(
  children: List.generate(5, (_) => ShimmerBox(width: double.infinity, height: 200)),
  staggerDuration: Duration(milliseconds: 150),
)
```

---

## 📚 API Reference

### AdaptiveShimmer

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Widget` | required | Widget to apply shimmer to |
| `loading` | `bool` | required | Show loading state |
| `enabled` | `bool` | `true` | Enable/disable animation |
| `duration` | `Duration` | 1500ms | Animation duration |
| `animationType` | `AnimationType` | `shimmer` | Animation style |
| `direction` | `ShimmerDirection` | `ltr` | Shimmer direction |
| `intensity` | `double` | `0.7` | Brightness (0.0-1.0) |
| `baseColor` | `Color` | grey[300] | Background color |
| `highlightColor` | `Color` | grey[100] | Highlight color |

### ScreenShimmer

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Widget` | required | Screen content |
| `loading` | `bool` | required | Show loading state |
| `enabled` | `bool` | `true` | Enable/disable animation |
| `duration` | `Duration` | 1500ms | Animation duration |
| `animationType` | `AnimationType` | `shimmer` | Animation style |
| `baseColor` | `Color` | grey[300] | Background color |
| `highlightColor` | `Color` | grey[100] | Highlight color |

### StaggeredShimmer

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Widget>` | required | Widgets to animate |
| `staggerDuration` | `Duration` | 200ms | Delay between children |
| `animationDuration` | `Duration` | 1500ms | Animation duration |
| `animationType` | `AnimationType` | `shimmer` | Animation style |
| `direction` | `ShimmerDirection` | `ltr` | Shimmer direction |
| `intensity` | `double` | `0.7` | Brightness (0.0-1.0) |
| `repeat` | `bool` | `true` | Repeat animation |

### ShimmerTransition

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `loading` | `bool` | required | Show loading state |
| `loadingChild` | `Widget` | required | Loading placeholder |
| `child` | `Widget` | required | Actual content |
| `transitionDuration` | `Duration` | 500ms | Fade duration |
| `curve` | `Curve` | easeInOut | Animation curve |
| `animationType` | `AnimationType` | `shimmer` | Loading animation |

### ShimmerExclude

```dart
ShimmerExclude(
  child: YourWidget(), // Won't shimmer in ScreenShimmer
)
```

### Skeleton Widgets

#### SkeletonBox
```dart
SkeletonBox(
  width: 200,
  height: 100,
  borderRadius: 8,
)
```

#### SkeletonCircle
```dart
SkeletonCircle(radius: 40)
```

#### SkeletonLine
```dart
SkeletonLine(
  width: 150,
  height: 10,
  borderRadius: 5,
)
```

#### SkeletonParagraph
```dart
SkeletonParagraph(
  width: double.infinity,
  lineCount: 3,
  lineHeight: 10,
  spacing: 8,
)
```

---

## ⚡ Performance

- **Zero Dependencies** - Minimal bundle size
- **GPU Accelerated** - ShaderMask-based animations
- **Efficient Rendering** - Only redraws during animation frames
- **Memory Optimized** - Minimal widget overhead
- **Smooth 60 FPS** - Even on older devices

---

## 🎯 Comparison with Alternatives

| Feature | Adaptive Shimmer | Skeletonizer | Shimmer |
|---------|-----------------|--------------|---------|
| **Bundle Size** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Dependencies** | None | None | None |
| **Animation Types** | 3 | 1 | 1 |
| **Directions** | 8 | Limited | 1 |
| **Skeleton Widgets** | Yes | Yes | No |
| **Screen Shimmer** | ✅ | ❌ | ❌ |
| **Exclude Widgets** | ✅ | ❌ | ❌ |
| **Staggered Effect** | ✅ | ❌ | ❌ |
| **Smooth Transition** | ✅ | ❌ | ❌ |
| **Intensity Control** | ✅ | ❌ | ❌ |
| **Dark Mode** | ✅ | ✅ | ✅ |
| **Ease of Use** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |

---

## 📖 Real-World Examples

### E-commerce Product List
```dart
ScreenShimmer(
  loading: isLoadingProducts,
  child: ListView.builder(
    itemCount: products.length,
    itemBuilder: (_, i) => ProductCard(product: products[i]),
  ),
)
```

### Social Media Feed
```dart
StaggeredShimmer(
  children: List.generate(3, (_) => ShimmerBox(width: double.infinity, height: 300)),
  staggerDuration: Duration(milliseconds: 150),
)
```

### User Profile
```dart
ShimmerTransition(
  loading: isLoadingProfile,
  loadingChild: SkeletonProfilePage(),
  child: ProfilePage(user: user),
)
```

---

## 🐛 Troubleshooting

### Shimmer appears too bright/dim
Adjust the `intensity` parameter (0.0 - 1.0).

### Animation is too fast/slow
Modify the `duration` parameter.

### Widget not shimmering on ScreenShimmer
Ensure it's not wrapped with `ShimmerExclude`.

---

## 📝 License

MIT License - See [LICENSE](LICENSE) file for details

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request to [GitHub](https://github.com/abhijithsabudev/adaptive_shimmer).

### To contribute:
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 💬 Support & Feedback

- **GitHub Issues**: [Report bugs or request features](https://github.com/abhijithsabudev/adaptive_shimmer/issues)
- **Email**: Contact us at support@adaptiveshimmer.dev
- **Twitter**: [@adaptiveshimmer](https://twitter.com/adaptiveshimmer)

---

## 🌟 Show Your Support

If you find this package helpful, please consider:
- ⭐ Starring the [GitHub repository](https://github.com/abhijithsabudev/adaptive_shimmer)
- 👍 Liking on [pub.dev](https://pub.dev/packages/adaptive_shimmer)
- 📢 Sharing with your Flutter community

---

**Built with ❤️ by [Abhijith Sabu](https://github.com/abhijithsabudev)**
)
```

#### Circle Skeleton
```dart
SkeletonCircle(
  radius: 40,
)
```

#### Line Skeleton (for text)
```dart
SkeletonLine(
  width: 150,
  height: 10,
)
```

### Screen-Wide Shimmer

Wrap your entire screen to apply shimmer to all components:

```dart
ScreenShimmer(
  loading: isLoading,
  child: Scaffold(
    appBar: AppBar(title: Text('My App')),
    body: SingleChildScrollView(
      child: Column(
        children: [
          // All widgets inside will shimmer during loading
          Text('Content'),
          Image.network('...'),
          // ... more widgets
        ],
      ),
    ),
  ),
)
```

### Excluding Widgets from Screen Shimmer

Use `ShimmerExclude` to keep certain widgets visible during screen shimmer:

```dart
ScreenShimmer(
  loading: isLoading,
  child: Scaffold(
    appBar: AppBar(title: Text('My App')),
    body: Column(
      children: [
        // This will shimmer
        ShimmerBox(width: 200, height: 100),
        
        // This will NOT shimmer - visible during loading
        ShimmerExclude(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Retry'),
          ),
        ),
        
        // This will shimmer
        ShimmerLine(width: 300),
      ],
    ),
  ),
)
```

## Animation Types

### Shimmer (Default)
Classic left-to-right shimmer wave effect.

```dart
AdaptiveShimmer(
  loading: true,
  animationType: AnimationType.shimmer,
  child: MyWidget(),
)
```

### Pulse
Fading in and out effect.

```dart
AdaptiveShimmer(
  loading: true,
  animationType: AnimationType.pulse,
  child: MyWidget(),
)
```

### Combined
Shimmer + pulse effect for enhanced visual feedback.

```dart
AdaptiveShimmer(
  loading: true,
  animationType: AnimationType.combined,
  child: MyWidget(),
)
```

## Customization

### Custom Colors

```dart
AdaptiveShimmer(
  loading: true,
  baseColor: Color(0xFFE0E0E0),
  highlightColor: Color(0xFFF5F5F5),
  child: MyWidget(),
)
```

### Custom Animation Duration

```dart
AdaptiveShimmer(
  loading: true,
  duration: Duration(milliseconds: 1000),
  child: MyWidget(),
)
```

### Disable Animation

```dart
AdaptiveShimmer(
  loading: true,
  enabled: false,
  child: MyWidget(),
)
```

## Advanced Example: Product Card

```dart
Container(
  padding: EdgeInsets.all(12),
  child: Row(
    children: [
      SkeletonCircle(radius: 40),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLine(width: 150, height: 12),
            SizedBox(height: 8),
            SkeletonParagraph(
              width: double.infinity,
              lineCount: 2,
              lineHeight: 10,
            ),
          ],
        ),
      ),
    ],
  ),
)
```

## API Reference

### AdaptiveShimmer

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Widget` | required | The widget to show shimmer effect on |
| `loading` | `bool` | required | Whether to show loading state |
| `enabled` | `bool` | `true` | Whether animation is enabled |
| `duration` | `Duration` | 1500ms | Animation duration |
| `animationType` | `AnimationType` | `shimmer` | Type of animation |
| `baseColor` | `Color` | grey[300] | Background color |
| `highlightColor` | `Color` | grey[100] | Highlight/wave color |

### SkeletonBox

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `width` | `double` | required | Box width |
| `height` | `double` | required | Box height |
| `borderRadius` | `double` | `8.0` | Corner radius |

### SkeletonCircle

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `radius` | `double` | required | Circle radius |

### SkeletonLine

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `width` | `double` | required | Line width |
| `height` | `double` | `8.0` | Line height |
| `borderRadius` | `double` | `4.0` | Corner radius |

### SkeletonParagraph

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `lineCount` | `int` | `3` | Number of lines |
| `width` | `double` | required | Width of lines |
| `lineHeight` | `double` | `10.0` | Height of each line |
| `spacing` | `double` | `8.0` | Space between lines |

### ScreenShimmer

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Widget` | required | The widget to show shimmer effect on (typically your screen) |
| `loading` | `bool` | required | Whether to show loading state |
| `enabled` | `bool` | `true` | Whether animation is enabled |
| `duration` | `Duration` | 1500ms | Animation duration |
| `animationType` | `AnimationType` | `shimmer` | Type of animation |
| `baseColor` | `Color` | grey[300] | Background color |
| `highlightColor` | `Color` | grey[100] | Highlight/wave color |

### ShimmerExclude

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Widget` | required | Widget to exclude from shimmer effect |

## Performance

- **Zero external dependencies** - smaller bundle size
- **GPU accelerated** - uses ShaderMask for smooth animations
- **Efficient re-renders** - only redraws during animation frames
- **Memory optimized** - minimal widget tree overhead

## Comparison with Alternatives

| Feature | Adaptive Shimmer | Skeletonizer | Shimmer |
|---------|-----------------|--------------|---------|
| Bundle Size | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Dependencies | None | None | None |
| Animation Types | 3 | 1 | 1 |
| Skeleton Widgets | Yes | Yes | No |
| Screen Shimmer | Yes | No | No |
| Exclude Widgets | Yes | No | No |
| Custom Shapes | Yes | Yes | Limited |
| Ease of Use | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |

## License

MIT License - See LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues, questions, or suggestions, please open an issue on [GitHub](https://github.com/abhijithsabudev/adaptive_shimmer). 
