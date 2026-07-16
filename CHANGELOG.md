## 1.0.0 - Production Ready with Screen Shimmer

### 🎯 Major Features
- **Screen Shimmer**: Apply shimmer effect to entire screen and all components
  - Perfect for page-level loading states
  - Maintains responsiveness during loading
  - GPU-accelerated screen-wide shader
- **Shimmer Exclude**: Exclude specific widgets from screen shimmer effect
  - Use `ShimmerExclude` wrapper for widgets that should not shimmer
  - Useful for buttons, navigation, or interactive elements
  - Flexible component-level control

### ✨ Additional Improvements
- Enhanced screen shimmer with three animation types
- Better integration with page layouts
- Improved performance with IgnorePointer to prevent interaction during shimmer
- Full backward compatibility with AdaptiveShimmer

### 📚 Documentation
- Added screen shimmer examples
- Shimmer exclude usage patterns
- Advanced layout examples

---

## 0.2.0 - Major Rebuild

### ⚡ Breaking Changes
- Removed dependency on `shimmer` package - now zero-dependency
- Changed API: Removed `isEnabled`, `period`, `direction`, `loop` parameters
- Updated to new `enabled`, `duration`, `animationType` parameters
- New parameter names for consistency

### ✨ New Features
- **Zero External Dependencies**: Pure Flutter implementation using native animations
- **Multiple Animation Types**: 
  - `AnimationType.shimmer` - Classic left-to-right shimmer wave
  - `AnimationType.pulse` - Fade in/out effect
  - `AnimationType.combined` - Shimmer + pulse combined
- **Skeleton Widgets**:
  - `SkeletonBox` - Rectangular placeholder with customizable border radius
  - `SkeletonCircle` - Circular placeholder for avatars
  - `SkeletonLine` - Line placeholder for text
  - `SkeletonParagraph` - Multiple lines with auto-decreasing width
- **Enhanced Customization**:
  - Custom animation duration
  - Custom base and highlight colors
  - Animation enable/disable toggle
  - Shape-adaptive shimmer effect

### 🎨 Improvements
- Lightweight shader-based implementation for better performance
- GPU-accelerated animations using `ShaderMask`
- Better memory efficiency with minimal widget overhead
- Improved visual quality with smooth gradient transitions
- More comprehensive example app showcasing all features

### 📚 Documentation
- Complete API reference with examples
- Advanced product card example
- Performance comparison with alternatives
- Multiple usage patterns

## 0.1.2
Support added

## 0.1.1
Support added

## 0.1.0
Updated interaction

## 0.0.9
Stable

## 0.0.8
Demo

## 0.0.7
Updates animation

## 0.0.6
Fix

## 0.0.5
Fix

## 0.0.4
Fix

## 0.0.3
Fix

## 0.0.2
Graphic changes

## 0.0.1
Extensive support in all platforms
