import 'package:flutter/material.dart';

/// Typedef for custom widget transformers
/// Takes a widget and returns a transformed skeleton widget
typedef WidgetTransformer = Widget? Function(Widget widget);

/// Typedef for transformer predicate
/// Determines if a widget should be transformed by this transformer
typedef TransformerPredicate = bool Function(Widget widget);

/// A custom transformer for SmartSkeleton
class SkeletonTransformer {
  /// Predicate to match widgets
  final TransformerPredicate predicate;

  /// Transformer function to create skeleton
  final WidgetTransformer transformer;

  /// Optional priority (higher = applied first)
  final int priority;

  /// Optional debug name for this transformer
  final String? name;

  SkeletonTransformer({
    required this.predicate,
    required this.transformer,
    this.priority = 0,
    this.name,
  });

  /// Check if this transformer can handle the widget
  bool canTransform(Widget widget) => predicate(widget);

  /// Apply transformation to widget
  Widget? transform(Widget widget) => transformer(widget);

  @override
  String toString() => 'SkeletonTransformer(${name ?? "custom"})';
}

/// Memoization cache for widget transformations
class TransformationCache {
  final Map<int, Widget> _cache = {};
  final int maxSize;

  TransformationCache({this.maxSize = 1000});

  /// Get cached transformation
  Widget? get(Widget widget) => _cache[widget.hashCode];

  /// Store transformation in cache
  void set(Widget widget, Widget transformed) {
    if (_cache.length < maxSize) {
      _cache[widget.hashCode] = transformed;
    }
  }

  /// Clear cache
  void clear() => _cache.clear();

  /// Get cache statistics
  CacheStats getStats() => CacheStats(
        size: _cache.length,
        maxSize: maxSize,
        utilization: (_cache.length / maxSize * 100).toStringAsFixed(1),
      );
}

/// Cache statistics
class CacheStats {
  final int size;
  final int maxSize;
  final String utilization;

  CacheStats({
    required this.size,
    required this.maxSize,
    required this.utilization,
  });

  @override
  String toString() =>
      'CacheStats(size: $size/$maxSize, utilization: $utilization%)';
}

/// Nested skeleton control
class NestedSkeletonScope extends InheritedWidget {
  /// Current nesting level
  final int nestingLevel;

  /// Maximum nesting level (prevents infinite nesting)
  final int maxNestingLevel;

  /// Debug mode for nested skeletons
  final bool debug;

  const NestedSkeletonScope({
    super.key,
    required super.child,
    this.nestingLevel = 0,
    this.maxNestingLevel = 5,
    this.debug = false,
  });

  /// Get current scope from context
  static NestedSkeletonScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NestedSkeletonScope>();
  }

  /// Check if max nesting is reached
  bool isMaxNestingReached() => nestingLevel >= maxNestingLevel;

  /// Get next nesting level
  int getNextNestingLevel() => nestingLevel + 1;

  @override
  bool updateShouldNotify(NestedSkeletonScope oldWidget) {
    return nestingLevel != oldWidget.nestingLevel ||
        maxNestingLevel != oldWidget.maxNestingLevel ||
        debug != oldWidget.debug;
  }
}
