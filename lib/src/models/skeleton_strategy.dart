/// Strategy for which widgets to replace with skeletons
enum SkeletonReplacementStrategy {
  /// Replace only text widgets with skeleton lines (default)
  textOnly,

  /// Replace only image widgets with skeleton boxes
  imagesOnly,

  /// Replace text and image widgets (default behavior)
  textAndImages,

  /// Replace text, images, and containers (most aggressive)
  all,

  /// Don't replace any widgets (manual transformation only)
  none,
}

/// Strategy for filling empty space in layouts
enum FillingStrategy {
  /// Don't fill any empty space (default)
  none,

  /// Fill empty SizedBox areas with skeleton color
  spaceOnly,

  /// Fill padding areas with skeleton background
  paddingOnly,

  /// Fill both empty SizedBox and padding areas
  all,
}

/// Strategy for widget transformation caching
enum CacheStrategy {
  /// Disable caching - transform widgets every time
  disabled,

  /// Standard caching with 1000 item limit (default)
  enabled,

  /// Aggressive caching - unlimited cache size
  aggressive,
}

/// Strategy for handling nested skeletons
enum NestingStrategy {
  /// Prevent nesting - only first level skeletons work
  disabled,

  /// Allow limited nesting up to 5 levels (default)
  limited,

  /// Allow unlimited nesting levels
  unlimited,
}
