# Adaptive Shimmer API Documentation

## Overview

**Adaptive Shimmer** is a lightweight, zero-dependency Flutter package that provides beautiful loading effects for your UI. It includes shimmer and pulse animations, shape-adaptive capabilities, pre-built skeleton templates, animation control, and accessibility support.

## Table of Contents

1. [Core Widgets](#core-widgets)
2. [Models & Configuration](#models--configuration)
3. [Controllers](#controllers)
4. [Themes](#themes)
5. [Skeleton Templates](#skeleton-templates)
6. [Accessibility](#accessibility)
7. [Examples](#examples)

---

## Core Widgets

### AdaptiveShimmer

Main widget for wrapping any child widget with shimmer or pulse animation.

```dart
AdaptiveShimmer(
  child: Text('Loading...'),
  loading: isLoading,
  duration: Duration(milliseconds: 1500),
  animationType: AnimationType.shimmer,
  baseColor: Color(0xFFE0E0E0),
  highlightColor: Color(0xFFF5F5F5),
  direction: ShimmerDirection.ltr,
  intensity: 0.7,
)
```

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `child` | `Widget` | Required | The widget to apply shimmer effect to |
| `loading` | `bool` | Required | Whether to show loading state |
| `enabled` | `bool` | `true` | Enable/disable animations |
| `duration` | `Duration` | `1500ms` | Animation cycle duration |
| `animationType` | `AnimationType` | `shimmer` | Type of animation |
| `baseColor` | `Color` | Gray | Background/base color |
| `highlightColor` | `Color` | Light gray | Shimmer highlight color |
| `direction` | `ShimmerDirection` | `ltr` | Direction of shimmer |
| `intensity` | `double` | `0.7` | Shimmer brightness (0.0-1.0) |
| `theme` | `ShimmerTheme?` | `null` | Optional theme |
| `controller` | `ShimmerController?` | `null` | Optional animation controller |

#### Factory Constructor

```dart
AdaptiveShimmer.withTheme(
  child: myWidget,
  loading: true,
  theme: ShimmerTheme.dark,
)
```

---

### ScreenShimmer

Apply shimmer effect to entire screen with ability to exclude specific widgets.

```dart
ScreenShimmer(
  loading: isLoading,
  child: Scaffold(
    body: ShimmerExclude(
      child: Text('This won\'t shimmer'),
    ),
  ),
)
```

---

### StaggeredShimmer

Cascade shimmer effect across multiple widgets with staggered delays.

```dart
StaggeredShimmer(
  children: [
    SkeletonBox(width: 100, height: 100),
    SkeletonBox(width: 100, height: 100),
    SkeletonBox(width: 100, height: 100),
  ],
  staggerDuration: Duration(milliseconds: 200),
)
```

---

## Models & Configuration

### AnimationType

Enum defining animation types:

```dart
enum AnimationType {
  shimmer,    // Classic left-to-right shimmer
  pulse,      // Pulsing fade in/out
  combined,   // Shimmer + pulse together
}
```

### ShimmerDirection

Enum defining shimmer directions:

```dart
enum ShimmerDirection {
  ltr,            // Left to right
  rtl,            // Right to left
  ttb,            // Top to bottom
  btt,            // Bottom to top
  diagonalLTR,    // Top-left to bottom-right
  diagonalRTL,    // Top-right to bottom-left
  diagonalBLTR,   // Bottom-left to top-right
  wave,           // Smooth wave pattern
}
```

---

## Controllers

### ShimmerController

Control animation playback programmatically.

```dart
final controller = ShimmerController();

// Pause animation
controller.pause();

// Resume animation
controller.resume();

// Toggle play/pause
controller.toggle();

// Stop and reset
controller.stop();

// Check state
bool isPlaying = controller.isPlaying;
bool isPaused = controller.isPaused;
bool isStopped = controller.isStopped;
```

#### Usage in Widget

```dart
final controller = ShimmerController();

AdaptiveShimmer(
  child: myWidget,
  loading: true,
  controller: controller,
)

// Later, control the animation
controller.pause();  // Pause loading animation
```

---

## Themes

### ShimmerTheme

Predefined themes for consistent styling.

#### Available Presets

```dart
ShimmerTheme.light        // Light gray shimmer
ShimmerTheme.dark         // Dark gray shimmer
ShimmerTheme.fast         // Fast shimmer (800ms)
ShimmerTheme.slow         // Slow shimmer (2500ms)
ShimmerTheme.subtle       // Subtle shimmer (low intensity)
ShimmerTheme.prominent    // Prominent shimmer (high intensity)
ShimmerTheme.materialLight  // Material Design 3 light
ShimmerTheme.materialDark   // Material Design 3 dark
```

#### Custom Themes

```dart
final customTheme = ShimmerTheme.custom(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  duration: Duration(milliseconds: 1200),
  intensity: 0.8,
);

AdaptiveShimmer.withTheme(
  child: myWidget,
  loading: true,
  theme: customTheme,
)
```

---

## Skeleton Templates

Pre-built skeleton layouts for common use cases.

### Card Skeleton

```dart
SkeletonTemplates.cardSkeleton(
  height: 120,
  baseColor: Color(0xFFE0E0E0),
  animationType: AnimationType.shimmer,
)
```

### List Item Skeleton

```dart
SkeletonTemplates.listItemSkeleton(
  height: 80,
)
```

### Blog Post Skeleton

```dart
SkeletonTemplates.postSkeleton(
  imageHeight: 200,
)
```

### Grid Item Skeleton

```dart
SkeletonTemplates.gridItemSkeleton(
  size: 150,
)
```

### Profile Skeleton

```dart
SkeletonTemplates.profileSkeleton(
  avatarRadius: 40,
)
```

### Chat Message Skeleton

```dart
SkeletonTemplates.chatMessageSkeleton(
  isCurrentUser: true,
)
```

---

### Individual Skeleton Widgets

#### SkeletonBox

Rectangular placeholder.

```dart
SkeletonBox(
  width: 200,
  height: 100,
  borderRadius: 8,
  baseColor: Color(0xFFE0E0E0),
  highlightColor: Color(0xFFF5F5F5),
)
```

#### SkeletonCircle

Circular placeholder.

```dart
SkeletonCircle(
  radius: 50,
  baseColor: Color(0xFFE0E0E0),
)
```

#### SkeletonLine

Line/text placeholder.

```dart
SkeletonLine(
  width: 200,
  height: 12,
  borderRadius: 4,
)
```

---

## Accessibility

The package respects system accessibility settings.

### ShimmerAccessibility Utilities

```dart
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

// Check if user prefers reduced motion
bool reduceMotion = ShimmerAccessibility.shouldReduceMotion(context);

// Get safe duration
Duration safe = ShimmerAccessibility.getSafeDuration(
  Duration(milliseconds: 1500),
  context,
);

// Check if animation should be shown
bool show = ShimmerAccessibility.shouldShowAnimation(context);
```

When `reduceMotion` is enabled:
- Animation duration becomes minimal
- Shimmer intensity is reduced
- Users with motion sensitivity get a better experience

---

## Examples

### Basic Shimmer

```dart
bool _isLoading = true;

AdaptiveShimmer(
  child: Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  loading: _isLoading,
)
```

### With Theme

```dart
AdaptiveShimmer.withTheme(
  child: myCard,
  loading: _isLoading,
  theme: ShimmerTheme.dark,
)
```

### With Controller

```dart
final controller = ShimmerController();

Column(
  children: [
    AdaptiveShimmer(
      child: myWidget,
      loading: true,
      controller: controller,
    ),
    ElevatedButton(
      onPressed: () => controller.toggle(),
      child: Text('Toggle Animation'),
    ),
  ],
)
```

### Complex Layout

```dart
ListView.builder(
  itemCount: 10,
  itemBuilder: (context, index) {
    return AdaptiveShimmer(
      child: SkeletonTemplates.listItemSkeleton(),
      loading: _isLoading,
    );
  },
)
```

### Screen-Wide Shimmer

```dart
ScreenShimmer(
  loading: _isLoading,
  child: ListView(
    children: [
      ShimmerExclude(
        child: Text('Title'),
      ),
      SkeletonBox(width: double.infinity, height: 200),
    ],
  ),
)
```

---

## Best Practices

1. **Use Themes** for consistent styling across your app
2. **Respect Accessibility** - the package automatically handles reduce motion
3. **Use Templates** for faster development
4. **Control with Controller** for advanced animation management
5. **Set appropriate intensity** (0.0-1.0) based on your design
6. **Choose correct direction** for visual flow

---

## Performance

- **Zero Dependencies** - pure Flutter
- **Minimal Memory** - efficient animation handling
- **Smooth 60fps** - optimized rendering
- **Shape-Adaptive** - shimmer respects widget boundaries
- **No Overflow** - shimmer stays within widget bounds
