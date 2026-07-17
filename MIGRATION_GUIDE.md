# Adaptive Shimmer - What's New & Migration Guide

## Overview

This guide covers the latest enhancements to the **Adaptive Shimmer** package and how to migrate existing code.

## New Features

### 1. Shimmer Controller ✨

Control animation playback programmatically with pause, resume, and stop capabilities.

**Before:**
```dart
AdaptiveShimmer(
  child: myWidget,
  loading: true,
)
// No way to control animation
```

**After:**
```dart
final controller = ShimmerController();

AdaptiveShimmer(
  child: myWidget,
  loading: true,
  controller: controller,
)

// Now you can control it:
controller.pause();    // Pause animation
controller.resume();   // Resume
controller.toggle();   // Toggle play/pause
controller.stop();     // Stop and reset
```

---

### 2. Theme System 🎨

Pre-built themes and custom theme support for consistent styling.

**Before:**
```dart
AdaptiveShimmer(
  child: myWidget,
  loading: true,
  baseColor: Color(0xFFE0E0E0),
  highlightColor: Color(0xFFF5F5F5),
  duration: Duration(milliseconds: 1500),
  intensity: 0.7,
)
```

**After:**
```dart
// Use preset theme
AdaptiveShimmer.withTheme(
  child: myWidget,
  loading: true,
  theme: ShimmerTheme.dark,
)

// Or create custom theme
final customTheme = ShimmerTheme.custom(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  duration: Duration(milliseconds: 1200),
  intensity: 0.8,
);
```

Available themes:
- `ShimmerTheme.light` - Light gray
- `ShimmerTheme.dark` - Dark gray
- `ShimmerTheme.fast` - 800ms duration
- `ShimmerTheme.slow` - 2500ms duration
- `ShimmerTheme.subtle` - Low intensity
- `ShimmerTheme.prominent` - High intensity
- `ShimmerTheme.materialLight` - Material 3 light
- `ShimmerTheme.materialDark` - Material 3 dark

---

### 3. Skeleton Templates 📋

Pre-built skeleton layouts for common UI patterns.

**Before:**
```dart
// Had to manually create complex skeleton layouts
Column(
  children: [
    SkeletonCircle(radius: 24),
    SizedBox(height: 12),
    SkeletonLine(width: 150, height: 12),
  ],
)
```

**After:**
```dart
// Use ready-made templates
SkeletonTemplates.cardSkeleton()
SkeletonTemplates.listItemSkeleton()
SkeletonTemplates.postSkeleton()
SkeletonTemplates.profileSkeleton()
SkeletonTemplates.chatMessageSkeleton()
SkeletonTemplates.gridItemSkeleton()
```

---

### 4. Accessibility Support ♿

Automatic support for system accessibility settings.

**Before:**
```dart
// Animation would play regardless of user preferences
AdaptiveShimmer(
  child: myWidget,
  loading: true,
)
```

**After:**
```dart
// Automatically respects "reduce motion" preference
AdaptiveShimmer(
  child: myWidget,
  loading: true,
)

// Or manually check if needed:
if (ShimmerAccessibility.shouldShowAnimation(context)) {
  // Show animation
}
```

---

### 5. Enhanced Shape Boundary Handling 🎭

Shimmer now respects widget shapes and doesn't overflow.

**Before:**
```dart
// Shimmer would appear as a rectangle even on rounded corners
AdaptiveShimmer(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(...),
  ),
  loading: true,
)
// Shimmer still appeared rectangular
```

**After:**
```dart
// Shimmer now conforms to the widget shape
AdaptiveShimmer(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(...),
  ),
  loading: true,
)
// Shimmer now respects the rounded corners!
```

---

## Migration Guide

### Basic Migration

If you have existing code, it will continue to work. To use new features:

#### Step 1: Update imports

```dart
// Old (still works)
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

// New features available:
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

// Access new features:
// - ShimmerController
// - ShimmerTheme
// - SkeletonTemplates
// - ShimmerAccessibility
```

#### Step 2: Use themes (optional but recommended)

```dart
// Old way
AdaptiveShimmer(
  child: myWidget,
  loading: true,
  baseColor: Color(0xFFE0E0E0),
  highlightColor: Color(0xFFF5F5F5),
  duration: Duration(milliseconds: 1500),
  intensity: 0.7,
)

// New way
AdaptiveShimmer.withTheme(
  child: myWidget,
  loading: true,
  theme: ShimmerTheme.light,
)
```

#### Step 3: Add controllers where needed

```dart
// For simple UI, no change needed
AdaptiveShimmer(
  child: myWidget,
  loading: true,
  theme: ShimmerTheme.dark,
)

// For advanced control
final controller = ShimmerController();

AdaptiveShimmer(
  child: myWidget,
  loading: true,
  theme: ShimmerTheme.dark,
  controller: controller,
)

// In your UI
ElevatedButton(
  onPressed: () => controller.pause(),
  child: Text('Pause'),
)
```

### Advanced Migration Examples

#### From Manual Skeleton to Template

```dart
// Old
Column(
  children: [
    SkeletonCircle(radius: 24),
    SizedBox(height: 12),
    SkeletonLine(width: double.infinity, height: 12),
    SizedBox(height: 8),
    SkeletonLine(width: 200, height: 10),
  ],
)

// New
SkeletonTemplates.cardSkeleton()
```

#### Multi-Widget Synchronization

```dart
// Old - each widget had separate animation controller
AdaptiveShimmer(child: widget1, loading: true)
AdaptiveShimmer(child: widget2, loading: true)
// Animations could be out of sync

// New - use shared controller
final controller = ShimmerController();
AdaptiveShimmer(child: widget1, loading: true, controller: controller)
AdaptiveShimmer(child: widget2, loading: true, controller: controller)
// Now perfectly synchronized!
```

---

## Breaking Changes

**There are NO breaking changes.** All existing code continues to work as before.

New parameters have default values:
- `controller` - defaults to `null`
- `theme` - defaults to `null`

---

## Performance Impact

- **Zero**: No additional dependencies
- **Minimal memory**: Same as before
- **Same 60fps performance**: No degradation

---

## Deprecation Notices

None. The old API is still fully supported and recommended for simple use cases.

---

## FAQ

**Q: Should I update my existing code to use themes?**
A: Not necessary, but recommended for larger apps. It provides:
- Consistency across widgets
- Easier maintenance
- Better dark mode support

**Q: Do I need to use controllers?**
A: Only if you need to control animations programmatically. For simple loading states, not needed.

**Q: Will accessibility break anything?**
A: No, it only improves the experience for users with motion sensitivity.

**Q: What about existing skeleton widgets?**
A: Still work perfectly. Templates are just helpers for common patterns.

---

## Getting Started with New Features

### 1. For Simple Projects

```dart
AdaptiveShimmer(
  child: myWidget,
  loading: true,
  // No other changes needed
)
```

### 2. For Medium Projects

```dart
AdaptiveShimmer.withTheme(
  child: myWidget,
  loading: true,
  theme: ShimmerTheme.dark,
)
```

### 3. For Complex Projects

```dart
final controller = ShimmerController();

AdaptiveShimmer.withTheme(
  child: SkeletonTemplates.listItemSkeleton(),
  loading: true,
  theme: ShimmerTheme.dark,
  controller: controller,
)
```

---

## Resources

- **API Documentation**: See `API_DOCUMENTATION.md`
- **Advanced Examples**: See `ADVANCED_EXAMPLES.md`
- **GitHub**: https://github.com/abhijithsabudev/adaptive_shimmer
