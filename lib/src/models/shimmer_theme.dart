import 'package:flutter/material.dart';

/// Shimmer theme configuration
class ShimmerTheme {
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final double intensity;

  const ShimmerTheme({
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
    required this.intensity,
  });

  /// Light theme (gray shades)
  static const ShimmerTheme light = ShimmerTheme(
    baseColor: Color(0xFFE0E0E0),
    highlightColor: Color(0xFFF5F5F5),
    duration: Duration(milliseconds: 1500),
    intensity: 0.7,
  );

  /// Dark theme (darker gray shades)
  static const ShimmerTheme dark = ShimmerTheme(
    baseColor: Color(0xFF424242),
    highlightColor: Color(0xFF616161),
    duration: Duration(milliseconds: 1500),
    intensity: 0.6,
  );

  /// Fast shimmer effect
  static const ShimmerTheme fast = ShimmerTheme(
    baseColor: Color(0xFFE0E0E0),
    highlightColor: Color(0xFFF5F5F5),
    duration: Duration(milliseconds: 800),
    intensity: 0.8,
  );

  /// Slow shimmer effect
  static const ShimmerTheme slow = ShimmerTheme(
    baseColor: Color(0xFFE0E0E0),
    highlightColor: Color(0xFFF5F5F5),
    duration: Duration(milliseconds: 2500),
    intensity: 0.6,
  );

  /// Subtle shimmer effect
  static const ShimmerTheme subtle = ShimmerTheme(
    baseColor: Color(0xFFF0F0F0),
    highlightColor: Color(0xFFFAFAFA),
    duration: Duration(milliseconds: 1500),
    intensity: 0.4,
  );

  /// Prominent shimmer effect
  static const ShimmerTheme prominent = ShimmerTheme(
    baseColor: Color(0xFFD0D0D0),
    highlightColor: Color(0xFFFFFFFF),
    duration: Duration(milliseconds: 1500),
    intensity: 0.9,
  );

  /// Material Design 3 light
  static const ShimmerTheme materialLight = ShimmerTheme(
    baseColor: Color(0xFFF5F5F5),
    highlightColor: Color(0xFFFFFFFF),
    duration: Duration(milliseconds: 1500),
    intensity: 0.65,
  );

  /// Material Design 3 dark
  static const ShimmerTheme materialDark = ShimmerTheme(
    baseColor: Color(0xFF1F1F1F),
    highlightColor: Color(0xFF2C2C2C),
    duration: Duration(milliseconds: 1500),
    intensity: 0.55,
  );

  /// Create custom theme
  factory ShimmerTheme.custom({
    required Color baseColor,
    required Color highlightColor,
    Duration duration = const Duration(milliseconds: 1500),
    double intensity = 0.7,
  }) {
    assert(intensity >= 0.0 && intensity <= 1.0,
        'Intensity must be between 0.0 and 1.0');
    return ShimmerTheme(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      intensity: intensity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShimmerTheme &&
          runtimeType == other.runtimeType &&
          baseColor == other.baseColor &&
          highlightColor == other.highlightColor &&
          duration == other.duration &&
          intensity == other.intensity;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      highlightColor.hashCode ^
      duration.hashCode ^
      intensity.hashCode;
}
