import 'package:flutter/material.dart';
import '../widgets/skeleton_widgets.dart';

/// Testing utilities for adaptive_shimmer
class ShimmerTester {
  /// Find all skeleton widgets in the widget tree
  static List<Widget> findSkeletonWidgets(BuildContext context) {
    final skeletons = <Widget>[];
    void visitor(Element element) {
      if (element.widget is SkeletonBox ||
          element.widget is SkeletonCircle ||
          element.widget is SkeletonLine ||
          element.widget is SkeletonParagraph) {
        skeletons.add(element.widget);
      }
      element.visitChildren(visitor);
    }

    context.visitChildElements(visitor);
    return skeletons;
  }

  /// Check if loading state is active
  static bool isLoadingActive(BuildContext context) {
    return findSkeletonWidgets(context).isNotEmpty;
  }

  /// Count skeleton widgets by type
  static Map<String, int> countSkeletonsByType(BuildContext context) {
    final counts = <String, int>{};
    final skeletons = findSkeletonWidgets(context);

    for (final skeleton in skeletons) {
      final type = skeleton.runtimeType.toString();
      counts[type] = (counts[type] ?? 0) + 1;
    }

    return counts;
  }

  /// Print skeleton widget tree (debug only)
  static void printSkeletonTree(BuildContext context) {
    final counts = countSkeletonsByType(context);
    debugPrint('=== Skeleton Widget Tree ===');
    for (final entry in counts.entries) {
      debugPrint('${entry.key}: ${entry.value}');
    }
    debugPrint('Total: ${counts.values.fold<int>(0, (a, b) => a + b)}');
  }

  /// Verify expected skeleton count
  static bool verifySkeletonCount(BuildContext context, int expected) {
    final count = findSkeletonWidgets(context).length;
    if (count != expected) {
      debugPrint(
        'Expected $expected skeletons, but found $count',
      );
      return false;
    }
    return true;
  }

  /// Get all skeleton box dimensions
  static List<Size> getSkeletonBoxSizes(BuildContext context) {
    final skeletons = findSkeletonWidgets(context);
    final sizes = <Size>[];

    for (final skeleton in skeletons) {
      if (skeleton is SkeletonBox) {
        sizes.add(Size(skeleton.width, skeleton.height));
      }
    }

    return sizes;
  }
}

/// Mock shimmer controller for testing
class MockShimmerController extends ChangeNotifier {
  late MockShimmerState _state = MockShimmerState.playing;

  MockShimmerState get state => _state;

  bool get isPlaying => _state == MockShimmerState.playing;
  bool get isPaused => _state == MockShimmerState.paused;
  bool get isStopped => _state == MockShimmerState.stopped;

  void pause() {
    _state = MockShimmerState.paused;
    notifyListeners();
  }

  void resume() {
    _state = MockShimmerState.playing;
    notifyListeners();
  }

  void stop() {
    _state = MockShimmerState.stopped;
    notifyListeners();
  }

  void reset() {
    _state = MockShimmerState.playing;
    notifyListeners();
  }
}

enum MockShimmerState { playing, paused, stopped }

/// Test widget for skeleton rendering
class SkeletonTestWidget extends StatelessWidget {
  final bool loading;
  final Widget child;

  const SkeletonTestWidget({
    super.key,
    required this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SkeletonBox(
        width: 100,
        height: 100,
        borderRadius: 8,
      );
    }
    return child;
  }
}

/// Test harness for skeleton and shimmer testing
class ShimmerTestHarness extends StatefulWidget {
  final bool initialLoading;
  final Widget child;
  final Duration transitionDuration;

  const ShimmerTestHarness({
    super.key,
    required this.child,
    this.initialLoading = true,
    this.transitionDuration = const Duration(milliseconds: 500),
  });

  @override
  State<ShimmerTestHarness> createState() => ShimmerTestHarnessState();
}

class ShimmerTestHarnessState extends State<ShimmerTestHarness> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = widget.initialLoading;
  }

  /// Toggle loading state for testing
  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  /// Set loading state directly
  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
