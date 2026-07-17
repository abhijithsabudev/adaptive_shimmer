import 'package:flutter/material.dart';
import '../models/animation_type.dart';
import '../models/shimmer_direction.dart';
import 'skeleton_widgets.dart';

/// Smart skeleton configuration for auto-detecting and replacing widgets
class SmartSkeletonConfig {
  /// Replace Text widgets with skeleton lines
  final bool replaceText;

  /// Replace Image widgets with skeleton boxes
  final bool replaceImages;

  /// Replace Container widgets with skeleton boxes
  final bool replaceContainers;

  /// Fill empty SizedBox areas with skeleton color
  final bool fillEmptySpace;

  /// Fill padding areas with skeleton background
  final bool fillPadding;

  /// Color for skeleton placeholders
  final Color skeletonColor;

  /// Highlight color for shimmer
  final Color highlightColor;

  /// Animation type for skeletons
  final AnimationType animationType;

  /// Shimmer direction
  final ShimmerDirection direction;

  /// Shimmer intensity (0.0 - 1.0)
  final double intensity;

  const SmartSkeletonConfig({
    this.replaceText = true,
    this.replaceImages = true,
    this.replaceContainers = false,
    this.fillEmptySpace = false,
    this.fillPadding = false,
    this.skeletonColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.animationType = AnimationType.shimmer,
    this.direction = ShimmerDirection.ltr,
    this.intensity = 0.7,
  });

  /// Default configuration - replaces text and images
  static const SmartSkeletonConfig defaultConfig = SmartSkeletonConfig();

  /// Aggressive mode - replaces all replaceable widgets
  static const SmartSkeletonConfig aggressive = SmartSkeletonConfig(
    replaceText: true,
    replaceImages: true,
    replaceContainers: true,
    fillEmptySpace: false,
    fillPadding: false,
  );

  /// Fill mode - fills empty space and padding
  static const SmartSkeletonConfig fillMode = SmartSkeletonConfig(
    replaceText: true,
    replaceImages: true,
    replaceContainers: false,
    fillEmptySpace: true,
    fillPadding: true,
  );

  /// Conservative mode - only replaces text
  static const SmartSkeletonConfig conservative = SmartSkeletonConfig(
    replaceText: true,
    replaceImages: false,
    replaceContainers: false,
    fillEmptySpace: false,
    fillPadding: false,
  );
}

/// Smart skeleton widget that auto-detects and replaces child widgets with skeletons
class SmartSkeleton extends StatelessWidget {
  final Widget child;
  final bool loading;
  final SmartSkeletonConfig config;

  const SmartSkeleton({
    super.key,
    required this.loading,
    this.config = SmartSkeletonConfig.defaultConfig,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return child;
    }

    return _SmartSkeletonBuilder(
      child: child,
      config: config,
    );
  }
}

/// Builder that traverses and transforms child widgets
class _SmartSkeletonBuilder extends StatelessWidget {
  final Widget child;
  final SmartSkeletonConfig config;

  const _SmartSkeletonBuilder({
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _transformWidget(child);
  }

  Widget _transformWidget(Widget widget) {
    // Handle Text widgets
    if (config.replaceText && widget is Text) {
      return _buildTextSkeleton(widget);
    }

    // Handle Image widgets
    if (config.replaceImages && widget is Image) {
      return _buildImageSkeleton(widget);
    }

    // Handle Container widgets
    if (config.replaceContainers && widget is Container) {
      return _buildContainerSkeleton(widget);
    }

    // Handle SizedBox - optionally fill with skeleton color
    if (widget is SizedBox) {
      if (config.fillEmptySpace) {
        return SkeletonBox(
          width: widget.width ?? 0,
          height: widget.height ?? 0,
          borderRadius: 0,
          baseColor: config.skeletonColor,
          highlightColor: config.highlightColor,
          animationType: config.animationType,
        );
      }
      return widget;
    }

    // Handle ClipRRect - check if child is Image for shape detection
    if (widget is ClipRRect) {
      final child = widget.child ?? const SizedBox.shrink();
      if (config.replaceImages && child is Image) {
        // Use ClipRRect's borderRadius for skeleton shape
        final borderRadius = widget.borderRadius as BorderRadius?;
        return ClipRRect(
          borderRadius: widget.borderRadius,
          child: _buildImageSkeletonWithRadius(child, borderRadius),
        );
      }
      return ClipRRect(
        borderRadius: widget.borderRadius,
        child: _transformWidget(child),
      );
    }

    // Handle ClipOval - check if child is Image for circular shape
    if (widget is ClipOval) {
      final child = widget.child ?? const SizedBox.shrink();
      if (config.replaceImages && child is Image) {
        // Create circular skeleton for ClipOval + Image
        return ClipOval(
          child: _buildCircularImageSkeleton(child),
        );
      }
      return ClipOval(
        child: _transformWidget(child),
      );
    }

    // Handle Column
    if (widget is Column) {
      return Column(
        mainAxisSize: widget.mainAxisSize,
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: widget.children.map(_transformWidget).toList(),
      );
    }

    // Handle Row
    if (widget is Row) {
      return Row(
        mainAxisSize: widget.mainAxisSize,
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: widget.children.map(_transformWidget).toList(),
      );
    }

    // Handle Padding
    if (widget is Padding) {
      if (config.fillPadding) {
        // Wrap padding area with skeleton background
        return Container(
          decoration: BoxDecoration(
            color: config.skeletonColor,
          ),
          child: Padding(
            padding: widget.padding,
            child: _transformWidget(widget.child ?? const SizedBox.shrink()),
          ),
        );
      }
      return Padding(
        padding: widget.padding,
        child: _transformWidget(widget.child ?? const SizedBox.shrink()),
      );
    }

    // Handle Center
    if (widget is Center) {
      return Center(
        child: _transformWidget(widget.child ?? const SizedBox.shrink()),
      );
    }

    // Handle Align
    if (widget is Align) {
      return Align(
        alignment: widget.alignment,
        child: _transformWidget(widget.child ?? const SizedBox.shrink()),
      );
    }

    // Handle SingleChildScrollView
    if (widget is SingleChildScrollView) {
      return SingleChildScrollView(
        child: _transformWidget(widget.child ?? const SizedBox.shrink()),
      );
    }

    // Handle Expanded
    if (widget is Expanded) {
      return Expanded(
        flex: widget.flex,
        child: _transformWidget(widget.child),
      );
    }

    // Default: return widget as-is if no transformation applies
    return widget;
  }

  Widget _buildTextSkeleton(Text widget) {
    // Estimate line height based on text style
    final fontSize = widget.style?.fontSize ?? 14.0;
    final height = fontSize * 1.2;

    // For single line, estimate width
    double width = 100;
    if (widget.maxLines != null && widget.maxLines! > 1) {
      width = double.infinity;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SkeletonLine(
        width: width,
        height: height,
        borderRadius: height / 2,
        baseColor: config.skeletonColor,
        highlightColor: config.highlightColor,
        animationType: config.animationType,
      ),
    );
  }

  Widget _buildImageSkeleton(Image widget) {
    // Get image dimensions
    final width = (widget.width ?? 100.0);
    final height = (widget.height ?? 100.0);

    return SkeletonBox(
      width: width,
      height: height,
      borderRadius: 8,
      baseColor: config.skeletonColor,
      highlightColor: config.highlightColor,
      animationType: config.animationType,
    );
  }

  /// Build skeleton respecting ClipRRect border radius
  Widget _buildImageSkeletonWithRadius(
      Image widget, BorderRadius? borderRadius) {
    final width = (widget.width ?? 100.0);
    final height = (widget.height ?? 100.0);

    // Extract the first corner radius value
    double radius = 8;
    if (borderRadius != null && borderRadius != BorderRadius.zero) {
      radius = borderRadius.topLeft.x;
    }

    return SkeletonBox(
      width: width,
      height: height,
      borderRadius: radius,
      baseColor: config.skeletonColor,
      highlightColor: config.highlightColor,
      animationType: config.animationType,
    );
  }

  /// Build circular skeleton for ClipOval + Image
  Widget _buildCircularImageSkeleton(Image widget) {
    // For circular, use the smallest dimension as diameter
    final size = (widget.width ?? widget.height ?? 100.0);

    return SkeletonCircle(
      radius: size / 2,
      baseColor: config.skeletonColor,
      highlightColor: config.highlightColor,
      animationType: config.animationType,
    );
  }

  Widget _buildContainerSkeleton(Container widget) {
    const width = 100.0;
    const height = 100.0;
    const borderRadiusZero = BorderRadius.zero;
    final borderRadius =
        (widget.decoration as BoxDecoration?)?.borderRadius as BorderRadius? ??
            borderRadiusZero;

    // Try to extract border radius value
    double radius = 8;
    if (borderRadius != borderRadiusZero) {
      // Get first corner radius
      radius = borderRadius.topLeft.x;
    }

    return SkeletonBox(
      width: width,
      height: height,
      borderRadius: radius,
      baseColor: config.skeletonColor,
      highlightColor: config.highlightColor,
      animationType: config.animationType,
    );
  }
}
