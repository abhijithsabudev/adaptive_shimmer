import 'package:flutter/material.dart';
import 'shimmer_widget.dart';
import '../models/animation_type.dart';

/// Skeleton box widget - rectangular placeholder
class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;
  final Duration animationDuration;
  final AnimationType animationType;

  const SkeletonBox({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: animationDuration,
      animationType: animationType,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Skeleton circle widget - circular placeholder
class SkeletonCircle extends StatelessWidget {
  final double radius;
  final Color baseColor;
  final Color highlightColor;
  final Duration animationDuration;
  final AnimationType animationType;

  const SkeletonCircle({
    Key? key,
    required this.radius,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: animationDuration,
      animationType: animationType,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: baseColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// Skeleton line widget - line placeholder for text
class SkeletonLine extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;
  final Duration animationDuration;
  final AnimationType animationType;

  const SkeletonLine({
    Key? key,
    required this.width,
    this.height = 8.0,
    this.borderRadius = 4.0,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: animationDuration,
      animationType: animationType,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Skeleton paragraph - multiple lines with decreasing width
class SkeletonParagraph extends StatelessWidget {
  final int lineCount;
  final double width;
  final double lineHeight;
  final double spacing;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;
  final Duration animationDuration;
  final AnimationType animationType;

  const SkeletonParagraph({
    Key? key,
    this.lineCount = 3,
    required this.width,
    this.lineHeight = 10.0,
    this.spacing = 8.0,
    this.borderRadius = 5.0,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.shimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lineCount, (index) {
        final isLastLine = index == lineCount - 1;
        final lineWidth = isLastLine ? width * 0.7 : width;

        return Padding(
          padding: EdgeInsets.only(bottom: index < lineCount - 1 ? spacing : 0),
          child: SkeletonLine(
            width: lineWidth,
            height: lineHeight,
            borderRadius: borderRadius,
            baseColor: baseColor,
            highlightColor: highlightColor,
            animationDuration: animationDuration,
            animationType: animationType,
          ),
        );
      }),
    );
  }
}
