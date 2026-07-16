import 'package:flutter/material.dart';
import '../models/animation_type.dart';

/// Provides context for shimmer exclusion
class _ShimmerExcludeScope extends InheritedWidget {
  final bool isShimmering;

  const _ShimmerExcludeScope({
    required this.isShimmering,
    required super.child,
  });

  @override
  bool updateShouldNotify(_ShimmerExcludeScope oldWidget) {
    return oldWidget.isShimmering != isShimmering;
  }

  static _ShimmerExcludeScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ShimmerExcludeScope>();
  }
}

/// Screen shimmer widget that applies shimmer to entire screen and components
/// Use [ShimmerExclude] to exclude specific widgets from shimmer effect
class ScreenShimmer extends StatefulWidget {
  /// Whether to show loading state (shimmer effect)
  final bool loading;

  /// The child widget (typically your entire screen)
  final Widget child;

  /// Whether the animation is enabled
  final bool enabled;

  /// Animation duration
  final Duration duration;

  /// Type of animation (shimmer, pulse, or combined)
  final AnimationType animationType;

  /// Base color (background)
  final Color baseColor;

  /// Highlight color (shimmer wave)
  final Color highlightColor;

  const ScreenShimmer({
    Key? key,
    required this.child,
    required this.loading,
    this.enabled = true,
    this.duration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
  }) : super(key: key);

  @override
  State<ScreenShimmer> createState() => _ScreenShimmerState();
}

class _ScreenShimmerState extends State<ScreenShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ShimmerExcludeScope(
      isShimmering: widget.loading && widget.enabled,
      child: _ScreenShimmerOverlay(
        loading: widget.loading,
        enabled: widget.enabled,
        baseColor: widget.baseColor,
        highlightColor: widget.highlightColor,
        animationType: widget.animationType,
        shimmerAnimation: _shimmerAnimation,
        pulseAnimation: _pulseAnimation,
        child: widget.child,
      ),
    );
  }
}

class _ScreenShimmerOverlay extends StatelessWidget {
  final bool loading;
  final bool enabled;
  final Color baseColor;
  final Color highlightColor;
  final AnimationType animationType;
  final Animation<double> shimmerAnimation;
  final Animation<double> pulseAnimation;
  final Widget child;

  const _ScreenShimmerOverlay({
    required this.loading,
    required this.enabled,
    required this.baseColor,
    required this.highlightColor,
    required this.animationType,
    required this.shimmerAnimation,
    required this.pulseAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!loading || !enabled) {
      return child;
    }

    return AnimatedBuilder(
      animation: shimmerAnimation,
      builder: (context, _) {
        return Stack(
          children: [
            child,
            _ShimmerLayerPainter(
              baseColor: baseColor,
              highlightColor: highlightColor,
              animationType: animationType,
              shimmerValue: shimmerAnimation.value,
              pulseValue: pulseAnimation.value,
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerLayerPainter extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final AnimationType animationType;
  final double shimmerValue;
  final double pulseValue;

  const _ShimmerLayerPainter({
    required this.baseColor,
    required this.highlightColor,
    required this.animationType,
    required this.shimmerValue,
    required this.pulseValue,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return IgnorePointer(
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.transparent,
        child: ShaderMask(
          shaderCallback: (bounds) {
            switch (animationType) {
              case AnimationType.shimmer:
              case AnimationType.combined:
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    shimmerValue - 0.3,
                    shimmerValue,
                    shimmerValue + 0.3,
                  ],
                  colors: [
                    baseColor.withValues(alpha: 0),
                    highlightColor.withValues(
                      alpha:
                          animationType == AnimationType.combined ? 0.3 : 0.15,
                    ),
                    baseColor.withValues(alpha: 0),
                  ],
                ).createShader(bounds);
              case AnimationType.pulse:
                return LinearGradient(
                  colors: [
                    baseColor.withValues(alpha: (1 - pulseValue) * 0.3),
                    baseColor.withValues(alpha: (1 - pulseValue) * 0.3),
                  ],
                ).createShader(bounds);
            }
          },
          child: Container(
            color: baseColor.withValues(alpha: 0),
          ),
        ),
      ),
    );
  }
}

/// Exclude specific widgets from screen shimmer effect
///
/// Wrap any widget with [ShimmerExclude] to prevent it from being shimmed
/// when used within a [ScreenShimmer]
class ShimmerExclude extends StatelessWidget {
  /// The child widget to exclude from shimmer
  final Widget child;

  const ShimmerExclude({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scope = _ShimmerExcludeScope.of(context);

    if (scope?.isShimmering == true) {
      // When shimmering, show the child normally without shimmer
      return Opacity(
        opacity: 1.0,
        child: child,
      );
    }

    return child;
  }
}
