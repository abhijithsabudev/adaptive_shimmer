import 'package:flutter/material.dart';

/// Accessibility utilities for shimmer animations
class ShimmerAccessibility {
  /// Check if user prefers reduced motion
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Get safe duration based on accessibility settings
  static Duration getSafeDuration(
    Duration duration,
    BuildContext context,
  ) {
    if (shouldReduceMotion(context)) {
      // Return a very short duration when animations are disabled
      return const Duration(milliseconds: 1);
    }
    return duration;
  }

  /// Get safe intensity based on accessibility settings
  static double getSafeIntensity(
    double intensity,
    BuildContext context,
  ) {
    if (shouldReduceMotion(context)) {
      // Reduce intensity when animations are disabled
      return 0.3;
    }
    return intensity;
  }

  /// Should show animation based on accessibility settings
  static bool shouldShowAnimation(BuildContext context) {
    return !MediaQuery.of(context).disableAnimations;
  }
}
