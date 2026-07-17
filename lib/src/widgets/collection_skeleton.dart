import 'package:flutter/material.dart';
import '../widgets/skeleton_widgets.dart';

/// Collection type for skeleton generation
enum CollectionType {
  /// List-based collection (ListView)
  list,

  /// Grid-based collection (GridView)
  grid,
}

/// Extension methods for easier skeleton integration
extension ListViewBuilderSkeletonExtension on ListView {
  /// Generate skeleton items for ListView.builder
  /// Useful when wrapping with SmartSkeleton or for loading states
  static ListView skeletonBuilder({
    required BuildContext context,
    required int itemCount,
    int crossAxisCount = 1,
    double itemHeight = 100,
    double spacing = 8,
    Axis scrollDirection = Axis.vertical,
  }) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(spacing / 2),
          child: SkeletonBox(
            width: double.infinity,
            height: itemHeight,
            borderRadius: 8,
          ),
        );
      },
    );
  }
}

/// SmartSkeleton configuration for collections (ListView, GridView, etc)
class CollectionSkeletonConfig {
  /// Number of skeleton items to show
  final int itemCount;

  /// Height of each skeleton item
  final double itemHeight;

  /// Spacing between items
  final double spacing;

  /// Border radius for skeleton items
  final double borderRadius;

  /// Color for skeleton placeholders
  final Color skeletonColor;

  const CollectionSkeletonConfig({
    this.itemCount = 6,
    this.itemHeight = 100,
    this.spacing = 8,
    this.borderRadius = 8,
    this.skeletonColor = const Color(0xFFE0E0E0),
  });
}

/// Helper to build skeleton ListView
class SkeletonListView extends StatelessWidget {
  final CollectionSkeletonConfig config;
  final Axis scrollDirection;

  const SkeletonListView({
    super.key,
    required this.config,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      itemCount: config.itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(config.spacing / 2),
          child: SkeletonBox(
            width: double.infinity,
            height: config.itemHeight,
            borderRadius: config.borderRadius,
            baseColor: config.skeletonColor,
          ),
        );
      },
    );
  }
}

/// Helper to build skeleton GridView
class SkeletonGridView extends StatelessWidget {
  final CollectionSkeletonConfig config;
  final int crossAxisCount;

  const SkeletonGridView({
    super.key,
    required this.config,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: config.spacing,
        crossAxisSpacing: config.spacing,
      ),
      itemCount: config.itemCount,
      itemBuilder: (context, index) {
        return SkeletonBox(
          width: double.infinity,
          height: config.itemHeight,
          borderRadius: config.borderRadius,
          baseColor: config.skeletonColor,
        );
      },
    );
  }
}

/// SmartSkeleton with collection support for ListViewBuilder
class SmartCollectionSkeleton extends StatelessWidget {
  final bool loading;
  final Widget child;
  final CollectionSkeletonConfig skeletonConfig;

  /// Type of collection (list or grid)
  final CollectionType type;

  /// Grid cross axis count (only used when type is grid)
  final int gridCrossAxisCount;

  const SmartCollectionSkeleton({
    super.key,
    required this.loading,
    required this.child,
    this.skeletonConfig = const CollectionSkeletonConfig(),
    this.type = CollectionType.list,
    this.gridCrossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return child;
    }

    if (type == CollectionType.list) {
      return SkeletonListView(config: skeletonConfig);
    } else {
      return SkeletonGridView(
        config: skeletonConfig,
        crossAxisCount: gridCrossAxisCount,
      );
    }
  }
}
