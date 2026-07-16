import 'package:flutter/material.dart';
import 'widgets/shimmer_widget.dart';
import 'models/animation_type.dart';
import 'models/shimmer_direction.dart';

/// Main adaptive shimmer widget
///
/// Provides a lightweight shimmer effect that adapts to any widget shape.
/// No external dependencies - uses pure Flutter animations.
class AdaptiveShimmer extends StatelessWidget {
  /// The child widget to show shimmer effect on
  final Widget child;

  /// Whether to show loading state (shimmer effect)
  final bool loading;

  /// Whether the animation is enabled
  final bool enabled;

  /// Animation duration (period between shimmer cycles)
  final Duration duration;

  /// Type of animation (shimmer, pulse, or combined)
  final AnimationType animationType;

  /// Base color (background)
  final Color baseColor;

  /// Highlight color (shimmer wave)
  final Color highlightColor;

  /// Direction of shimmer effect
  final ShimmerDirection direction;

  /// Intensity of shimmer (0.0 - 1.0, where 1.0 is brightest)
  final double intensity;

  const AdaptiveShimmer({
    super.key,
    required this.child,
    required this.loading,
    this.enabled = true,
    this.duration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.direction = ShimmerDirection.ltr,
    this.intensity = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return child;
    }

    return ShimmerWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      animationType: animationType,
      enabled: enabled,
      direction: direction,
      intensity: intensity,
      child: child,
    );
  }
}
