import 'package:flutter/material.dart';
import '../models/animation_type.dart';

/// Base widget for shimmer animation
class ShimmerWidget extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final AnimationType animationType;
  final bool enabled;

  const ShimmerWidget({
    Key? key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
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
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _buildAnimation();
      },
    );
  }

  Widget _buildAnimation() {
    switch (widget.animationType) {
      case AnimationType.shimmer:
        return _buildShimmer();
      case AnimationType.pulse:
        return _buildPulse();
      case AnimationType.combined:
        return _buildCombined();
    }
  }

  Widget _buildShimmer() {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  _shimmerAnimation.value - 0.3,
                  _shimmerAnimation.value,
                  _shimmerAnimation.value + 0.3,
                ],
                colors: [
                  widget.baseColor.withValues(alpha: 0),
                  widget.highlightColor.withValues(alpha: 0.7),
                  widget.baseColor.withValues(alpha: 0),
                ],
              ).createShader(bounds);
            },
            child: Container(
              color: widget.baseColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPulse() {
    return Opacity(
      opacity: _pulseAnimation.value,
      child: widget.child,
    );
  }

  Widget _buildCombined() {
    return Opacity(
      opacity: _pulseAnimation.value,
      child: Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    _shimmerAnimation.value - 0.3,
                    _shimmerAnimation.value,
                    _shimmerAnimation.value + 0.3,
                  ],
                  colors: [
                    widget.baseColor.withValues(alpha: 0),
                    widget.highlightColor.withValues(alpha: 0.4),
                    widget.baseColor.withValues(alpha: 0),
                  ],
                ).createShader(bounds);
              },
              child: Container(
                color: widget.baseColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
