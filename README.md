# 🎨 Adaptive Shimmer

<div align="center">

**The ultimate skeleton loader for Flutter.** Zero dependencies, maximum power.

[![Pub Version](https://img.shields.io/pub/v/adaptive_shimmer)](https://pub.dev/packages/adaptive_shimmer)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[Why Choose This?](#-why-choose-adaptive-shimmer) • [Get Started](#-installation) • [Examples](#-code-examples) • [Learn More](#-advanced-features)

</div>

---

## 🚀 Why Choose Adaptive Shimmer?

| Feature | Details |
|---------|---------|
| **Zero Dependencies** | Pure Flutter, no external packages |
| **One Line of Code** | Wrap any widget, get instant skeleton loading |
| **Smart Auto-Detection** | Automatically transforms your widgets to skeletons |
| **8 Directions** | LTR, RTL, TTB, BTB, Diagonal, Wave, and more |
| **Complete Control** | Pause, resume, stop animations with `ShimmerController` |
| **Beautiful Themes** | 8 built-in presets + unlimited custom options |
| **Accessibility First** | Respects system motion preferences automatically |
| **Advanced Features** | Custom transformers, nested skeletons, memoization |
| **Production Ready** | Enterprise-grade Flutter apps |

---

## 📦 Installation

```bash
flutter pub add adaptive_shimmer
```

Or add to `pubspec.yaml`:
```yaml
dependencies:
  adaptive_shimmer: ^1.2.0
```

---

## ⚡ Code Examples

### 1️⃣ Basic Loading (One Line!)

```dart
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

AdaptiveShimmer(
  loading: isLoading,
  child: MyContentWidget(),
)
```

**That's it!** Shimmer applied, automatic on/off.

---

### 2️⃣ Auto-Transform with SmartSkeleton

No need for separate skeleton widgets!

```dart
SmartSkeleton(
  loading: isLoading,
  child: Column(
    children: [
      Text('Product Name'),
      Image.network(productUrl),
      Text('Price: $99.99'),
    ],
  ),
)
```

Automatically converts:
- `Text()` → Skeleton lines
- `Image()` → Skeleton boxes  
- Respects shapes & borders

---

### 3️⃣ ListView/GridView Skeletons

Perfect for dynamic lists:

```dart
SmartCollectionSkeleton(
  loading: isLoading,
  type: CollectionType.list,  // or .grid
  skeletonConfig: CollectionSkeletonConfig(
    itemCount: 5,
    itemHeight: 120,
  ),
  child: MyListView(),
)
```

---

### 4️⃣ Animation Control

```dart
final controller = ShimmerController();

AdaptiveShimmer(
  loading: true,
  controller: controller,
  child: MyWidget(),
)

controller.pause();    // Pause
controller.resume();   // Resume
controller.stop();     // Stop
controller.toggle();   // Toggle
```

---

### 5️⃣ Themes (8 Built-in)

```dart
AdaptiveShimmer.withTheme(
  loading: isLoading,
  theme: ShimmerTheme.dark,  // light, fast, slow, subtle, prominent
  child: MyWidget(),
)
```

Or custom:
```dart
theme: ShimmerTheme.custom(
  baseColor: Colors.grey[300],
  highlightColor: Colors.white,
  duration: Duration(milliseconds: 1200),
  intensity: 0.6,
)
```

---

### 6️⃣ Staggered Effect

```dart
StaggeredShimmer(
  children: [
    SkeletonBox(width: 300, height: 100),
    SizedBox(height: 16),
    SkeletonLine(width: 250),
    SizedBox(height: 8),
    SkeletonLine(width: 200),
  ],
  staggerDuration: Duration(milliseconds: 200),
)
```

---

## 🎨 Animation Types

```dart
AnimationType.shimmer,    // Wave effect (default)
AnimationType.pulse,      // Fade in/out
AnimationType.combined,   // Both effects
```

---

## 🧭 8 Directions

```dart
ShimmerDirection.ltr,            // Left to Right
ShimmerDirection.rtl,            // Right to Left
ShimmerDirection.ttb,            // Top to Bottom
ShimmerDirection.btt,            // Bottom to Top
ShimmerDirection.diagonalLTR,    // Diagonal ↘
ShimmerDirection.diagonalRTL,    // Diagonal ↙
ShimmerDirection.diagonalBLTR,   // Diagonal ↗
ShimmerDirection.wave,           // Wave pattern
```

---

## ⚙️ Smart Configuration Strategies

Clean, semantic API using enums:

```dart
SmartSkeletonConfig(
  // What to replace?
  replacementStrategy: SkeletonReplacementStrategy.textAndImages,
  
  // Fill empty space?
  fillingStrategy: FillingStrategy.spaceOnly,
  
  // Cache performance?
  cacheStrategy: CacheStrategy.enabled,
  
  // Allow nesting?
  nestingStrategy: NestingStrategy.limited,
)
```

---

## 🔧 Advanced Features

### Nested Skeletons
```dart
SmartSkeleton(
  loading: outerLoading,
  child: SmartSkeleton(
    loading: innerLoading,
    child: InnerWidget(),
  ),
)
```

### Performance Optimization
```dart
SmartSkeletonConfig(
  cacheStrategy: CacheStrategy.aggressive,
)

final stats = SmartSkeleton.getCacheStats();
SmartSkeleton.clearCache();
```

### Testing Utilities
```dart
import 'package:adaptive_shimmer/testing_utils.dart';

ShimmerTester.findSkeletonWidgets(context);
ShimmerTester.countSkeletonsByType(context);
ShimmerTester.verifySkeletonCount(context, expected: 5);
```

### Custom Transformers

```dart
SmartSkeleton(
  loading: isLoading,
  config: SmartSkeletonConfig(
    customTransformers: [
      SkeletonTransformer(
        predicate: (w) => w is MyCustomWidget,
        transformer: (w) => SkeletonBox(width: 200, height: 100),
        priority: 10,
      ),
    ],
  ),
  child: YourWidget(),
)
```

---

## 📦 Pre-built Components

```dart
SkeletonBox(width: 100, height: 100)        // Rectangle
SkeletonCircle(radius: 40)                  // Circle
SkeletonLine(width: 200, height: 12)        // Text line
SkeletonParagraph(width: double.infinity)   // Multi-line

ScreenShimmer(...)                          // Full-page loading
ShimmerTransition(...)                      // Smooth fade-in
StaggeredShimmer(...)                       // Cascade effect
CollectionSkeleton(...)                     // List/grid skeletons
```

---

## 💡 Best Practices

✅ Use `SmartSkeleton` for auto-detection  
✅ Set realistic `itemCount` for collections  
✅ Theme consistently with presets  
✅ Motion preferences are automatic  
✅ Cache for high-frequency transforms  
✅ Test with testing utilities  

---

## 🎯 Use Cases

✓ E-commerce products  
✓ Social media feeds  
✓ Search results  
✓ User profiles  
✓ News articles  
✓ Chat messages  
✓ Data tables  
✓ Dashboards  

---

## ⚡ Performance

- GPU-accelerated animations (ShaderMask)
- Built-in transformation caching
- Zero re-renders on rebuilds
- ~10KB package size (no dependencies)

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

---

## 📄 License

MIT License - feel free to use in commercial projects

---

## 🤝 Contributing

Found a bug or have a feature idea? Contributions welcome!

- [GitHub Issues](https://github.com/abhijithsabudev/adaptive_shimmer/issues)
- [GitHub Discussions](https://github.com/abhijithsabudev/adaptive_shimmer/discussions)

---

## 🙏 Support

Love this package? Please:
- ⭐ Star on [GitHub](https://github.com/abhijithsabudev/adaptive_shimmer)
- 👍 Give it a like on [pub.dev](https://pub.dev/packages/adaptive_shimmer)
- 📣 Share with the Flutter community

---

<div align="center">

**Made with ❤️ by the Flutter community**

[Pub.dev](https://pub.dev/packages/adaptive_shimmer) • [GitHub](https://github.com/abhijithsabudev/adaptive_shimmer)

</div> 
