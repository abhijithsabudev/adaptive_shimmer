import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdaptiveShimmer extends StatelessWidget {
  final Widget child;
  final bool loading;
  final bool? isEnabled;
  final Duration? period;
  final ShimmerDirection? direction;
  final int? loop;
  final Color? baseColor;
  final Color? highlightColor;

  AdaptiveShimmer(
      {super.key, required this.child,
        required this.loading,
        this.isEnabled,
        this.period,
        this.direction,
        this.loop,
        this.baseColor,
        this.highlightColor});

  @override
  Widget build(BuildContext context) {
    return loading ? _buildShimmer() : child;
  }

  Widget _buildShimmer() {
    return ClipPath(
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[300]!,
        highlightColor: highlightColor ?? Colors.grey[100]!,
        enabled: isEnabled ?? true,
        period: period ?? const Duration(milliseconds: 1500),
        direction: direction ?? ShimmerDirection.ltr,
        loop: loop ?? 0,
        child: child,
      ),
    );
  }
}
