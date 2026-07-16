import 'package:flutter/material.dart';
import '../models/animation_type.dart';
import '../models/shimmer_direction.dart';

/// Smooth transition from shimmer to actual content
/// Fades out shimmer while fading in real content
class ShimmerTransition extends StatefulWidget {
  /// Whether to show loading state
  final bool loading;

  /// The widget to show during loading (shimmer placeholder)
  final Widget loadingChild;

  /// The actual content to show when loaded
  final Widget child;

  /// Transition duration
  final Duration transitionDuration;

  /// Curve for the transition animation
  final Curve curve;

  /// Animation type for the shimmer
  final AnimationType animationType;

  /// Base color
  final Color baseColor;

  /// Highlight color
  final Color highlightColor;

  /// Direction of shimmer
  final ShimmerDirection direction;

  /// Intensity of shimmer
  final double intensity;

  const ShimmerTransition({
    Key? key,
    required this.loading,
    required this.loadingChild,
    required this.child,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.animationType = AnimationType.shimmer,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.direction = ShimmerDirection.ltr,
    this.intensity = 0.7,
  }) : super(key: key);

  @override
  State<ShimmerTransition> createState() => _ShimmerTransitionState();
}

class _ShimmerTransitionState extends State<ShimmerTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _transitionController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _transitionController, curve: widget.curve),
    );

    if (!widget.loading) {
      _transitionController.forward();
    }
  }

  @override
  void didUpdateWidget(ShimmerTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.loading && oldWidget.loading) {
      _transitionController.forward();
    } else if (widget.loading && !oldWidget.loading) {
      _transitionController.reverse();
    }
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Real content - fades in
        Opacity(
          opacity: 1.0 - _fadeAnimation.value,
          child: widget.child,
        ),
        // Shimmer - fades out
        Opacity(
          opacity: _fadeAnimation.value,
          child: widget.loadingChild,
        ),
      ],
    );
  }
}
