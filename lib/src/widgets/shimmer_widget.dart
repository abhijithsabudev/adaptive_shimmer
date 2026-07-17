import 'package:flutter/material.dart';
import '../models/animation_type.dart';
import '../models/shimmer_direction.dart';
import '../controllers/shimmer_controller.dart';

/// Base widget for shimmer animation
class ShimmerWidget extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final AnimationType animationType;
  final bool enabled;
  final ShimmerDirection direction;
  final double intensity;
  final ShimmerController? controller;

  const ShimmerWidget({
    Key? key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
    this.enabled = true,
    this.direction = ShimmerDirection.ltr,
    this.intensity = 0.7,
    this.controller,
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

    // Listen to controller changes
    widget.controller?.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    final controller = widget.controller;
    if (controller == null) return;

    switch (controller.state) {
      case ShimmerState.playing:
        _controller.repeat();
        break;
      case ShimmerState.paused:
        _controller.stop();
        break;
      case ShimmerState.stopped:
        _controller.reset();
        break;
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
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
    return ShaderMask(
      shaderCallback: (bounds) {
        final (begin, end) = _getAlignmentForDirection();

        return LinearGradient(
          begin: begin,
          end: end,
          stops: [
            _shimmerAnimation.value - 0.3,
            _shimmerAnimation.value,
            _shimmerAnimation.value + 0.3,
          ],
          colors: [
            widget.baseColor.withValues(alpha: 0),
            widget.highlightColor.withValues(alpha: widget.intensity),
            widget.baseColor.withValues(alpha: 0),
          ],
        ).createShader(bounds);
      },
      child: widget.child,
    );
  }

  (Alignment, Alignment) _getAlignmentForDirection() {
    switch (widget.direction) {
      case ShimmerDirection.ltr:
        return (Alignment.centerLeft, Alignment.centerRight);
      case ShimmerDirection.rtl:
        return (Alignment.centerRight, Alignment.centerLeft);
      case ShimmerDirection.ttb:
        return (Alignment.topCenter, Alignment.bottomCenter);
      case ShimmerDirection.btt:
        return (Alignment.bottomCenter, Alignment.topCenter);
      case ShimmerDirection.diagonalLTR:
        return (Alignment.topLeft, Alignment.bottomRight);
      case ShimmerDirection.diagonalRTL:
        return (Alignment.topRight, Alignment.bottomLeft);
      case ShimmerDirection.diagonalBLTR:
        return (Alignment.bottomLeft, Alignment.topRight);
      case ShimmerDirection.wave:
        return (Alignment.centerLeft, Alignment.centerRight);
    }
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
      child: ShaderMask(
        shaderCallback: (bounds) {
          final (begin, end) = _getAlignmentForDirection();

          return LinearGradient(
            begin: begin,
            end: end,
            stops: [
              _shimmerAnimation.value - 0.3,
              _shimmerAnimation.value,
              _shimmerAnimation.value + 0.3,
            ],
            colors: [
              widget.baseColor.withValues(alpha: 0),
              widget.highlightColor.withValues(alpha: widget.intensity * 0.5),
              widget.baseColor.withValues(alpha: 0),
            ],
          ).createShader(bounds);
        },
        child: widget.child,
      ),
    );
  }
}
