import 'package:flutter/material.dart';
import 'shimmer_widget.dart';
import '../models/animation_type.dart';
import '../models/shimmer_direction.dart';

/// Staggered shimmer that applies cascade effect to multiple widgets
/// Each child shimmers with a delay for a waterfall/cascade effect
class StaggeredShimmer extends StatelessWidget {
  /// List of widgets to shimmer with stagger effect
  final List<Widget> children;

  /// Delay between each child's shimmer start
  final Duration staggerDuration;

  /// Animation duration for each child
  final Duration animationDuration;

  /// Type of animation
  final AnimationType animationType;

  /// Base color
  final Color baseColor;

  /// Highlight color
  final Color highlightColor;

  /// Direction of shimmer
  final ShimmerDirection direction;

  /// Intensity of shimmer (0.0 - 1.0)
  final double intensity;

  /// Whether to repeat the stagger effect
  final bool repeat;

  const StaggeredShimmer({
    Key? key,
    required this.children,
    this.staggerDuration = const Duration(milliseconds: 200),
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.direction = ShimmerDirection.ltr,
    this.intensity = 0.7,
    this.repeat = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        children.length,
        (index) {
          return _StaggeredChild(
            delay: staggerDuration * index,
            animationDuration: animationDuration,
            animationType: animationType,
            baseColor: baseColor,
            highlightColor: highlightColor,
            direction: direction,
            intensity: intensity,
            repeat: repeat,
            child: children[index],
          );
        },
      ),
    );
  }
}

class _StaggeredChild extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration animationDuration;
  final AnimationType animationType;
  final Color baseColor;
  final Color highlightColor;
  final ShimmerDirection direction;
  final double intensity;
  final bool repeat;

  const _StaggeredChild({
    required this.delay,
    required this.animationDuration,
    required this.animationType,
    required this.baseColor,
    required this.highlightColor,
    required this.direction,
    required this.intensity,
    required this.repeat,
    required this.child,
  });

  @override
  State<_StaggeredChild> createState() => _StaggeredChildState();
}

class _StaggeredChildState extends State<_StaggeredChild>
    with SingleTickerProviderStateMixin {
  late AnimationController _delayController;

  @override
  void initState() {
    super.initState();
    _delayController = AnimationController(
      duration: widget.delay,
      vsync: this,
    );

    _delayController.forward().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _delayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_delayController.status != AnimationStatus.completed) {
      return widget.child;
    }

    return ShimmerWidget(
      duration: widget.animationDuration,
      animationType: widget.animationType,
      baseColor: widget.baseColor,
      highlightColor: widget.highlightColor,
      direction: widget.direction,
      intensity: widget.intensity,
      child: widget.child,
    );
  }
}
