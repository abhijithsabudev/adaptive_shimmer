# Adaptive Shimmer

A lightweight, **zero-dependency** Flutter skeleton loader package with shimmer and pulse animations. Perfect as a lightweight alternative to skeletonizer with shape-adaptive capabilities.

## Features

✨ **Zero External Dependencies** - Pure Flutter implementation
- 🎨 Multiple animation types (shimmer, pulse, combined)
- 📦 Pre-built skeleton widgets (box, circle, line, paragraph)
- 🎯 Shape-adaptive shimmer effect
- 🎨 Custom colors and gradients
- ⚡ Lightweight and performant
- 🔧 Highly customizable

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  adaptive_shimmer: ^0.2.0
```

## Quick Start

### Basic Shimmer

```dart
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

AdaptiveShimmer(
  loading: isLoading,
  child: Container(
    height: 100,
    color: Colors.blue,
    child: Text('Loading...'),
  ),
)
```

### Skeleton Widgets

#### Box Skeleton
```dart
SkeletonBox(
  width: 200,
  height: 100,
  borderRadius: 8,
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

#### Paragraph Skeleton
```dart
SkeletonParagraph(
  width: double.infinity,
  lineCount: 3,
  spacing: 8,
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
| Custom Shapes | Yes | Yes | Limited |
| Ease of Use | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |

## License

MIT License - See LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues, questions, or suggestions, please open an issue on [GitHub](https://github.com/abhijithsabudev/adaptive_shimmer). 
