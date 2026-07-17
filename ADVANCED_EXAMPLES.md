# Adaptive Shimmer - Advanced Examples

## Table of Contents

1. [Building Realistic UI Skeletons](#building-realistic-ui-skeletons)
2. [State Management Integration](#state-management-integration)
3. [Custom Animations](#custom-animations)
4. [Performance Optimization](#performance-optimization)
5. [Accessibility Integration](#accessibility-integration)

---

## Building Realistic UI Skeletons

### Social Media Feed

```dart
class SocialFeedSkeleton extends StatelessWidget {
  final bool isLoading;

  const SocialFeedSkeleton({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return AdaptiveShimmer(
          loading: isLoading,
          theme: ShimmerTheme.dark,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonTemplates.cardSkeleton(),
                SizedBox(height: 16),
                SkeletonLine(width: double.infinity, height: 12),
                SizedBox(height: 8),
                SkeletonLine(width: double.infinity, height: 12),
                SizedBox(height: 8),
                SkeletonLine(width: 200, height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

### E-commerce Product Page

```dart
class ProductPageSkeleton extends StatelessWidget {
  final bool isLoading;

  const ProductPageSkeleton({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AdaptiveShimmer(
        loading: isLoading,
        child: Column(
          children: [
            // Product image
            SkeletonBox(
              width: double.infinity,
              height: 300,
              borderRadius: 12,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  SkeletonLine(width: 200, height: 20),
                  SizedBox(height: 12),
                  // Rating
                  SkeletonLine(width: 150, height: 14),
                  SizedBox(height: 16),
                  // Price
                  SkeletonLine(width: 120, height: 24),
                  SizedBox(height: 20),
                  // Description
                  ...List.generate(3, (_) => Column(
                    children: [
                      SkeletonLine(width: double.infinity, height: 12),
                      SizedBox(height: 8),
                    ],
                  )),
                  SizedBox(height: 20),
                  // Add to cart button
                  SkeletonBox(
                    width: double.infinity,
                    height: 48,
                    borderRadius: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Grid Gallery Skeleton

```dart
class GallerySkeleton extends StatelessWidget {
  final bool isLoading;

  const GallerySkeleton({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return AdaptiveShimmer(
          loading: isLoading,
          child: SkeletonTemplates.gridItemSkeleton(),
        );
      },
    );
  }
}
```

---

## State Management Integration

### With Riverpod

```dart
class UserListProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(usersProvider);

    return userAsyncValue.when(
      loading: () => ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => AdaptiveShimmer(
          loading: true,
          child: SkeletonTemplates.listItemSkeleton(),
        ),
      ),
      error: (err, stack) => Text('Error: $err'),
      data: (users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => UserTile(user: users[index]),
      ),
    );
  }
}
```

### With BLoC Pattern

```dart
class DataListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        if (state is DataLoading) {
          return ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) => AdaptiveShimmer(
              loading: true,
              theme: ShimmerTheme.dark,
              child: SkeletonTemplates.listItemSkeleton(),
            ),
          );
        }

        if (state is DataLoaded) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) => DataTile(
              item: state.items[index],
            ),
          );
        }

        return ErrorWidget();
      },
    );
  }
}
```

### With Provider

```dart
class DataWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(dataProvider);

    return dataAsync.when(
      loading: () => AdaptiveShimmer(
        loading: true,
        controller: ShimmerController(),  // Can be managed by provider
        child: SkeletonTemplates.postSkeleton(),
      ),
      error: (err, stack) => ErrorWidget(error: err),
      data: (data) => DataDisplay(data: data),
    );
  }
}
```

---

## Custom Animations

### Staggered List with Custom Delays

```dart
class CustomStaggeredList extends StatelessWidget {
  final int itemCount;
  final Duration baseDelay;

  const CustomStaggeredList({
    this.itemCount = 10,
    this.baseDelay = const Duration(milliseconds: 100),
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Future.delayed(
          baseDelay * index,
          () => AdaptiveShimmer(
            loading: true,
            animationType: AnimationType.combined,
            child: SkeletonTemplates.listItemSkeleton(),
          ),
        );
      },
    );
  }
}
```

### Pause/Resume Control

```dart
class ControlledShimmerList extends StatefulWidget {
  @override
  State<ControlledShimmerList> createState() =>
      _ControlledShimmerListState();
}

class _ControlledShimmerListState extends State<ControlledShimmerList> {
  late final ShimmerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = ShimmerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _isPlaying
                  ? () {
                      _controller.pause();
                      setState(() => _isPlaying = false);
                    }
                  : () {
                      _controller.resume();
                      setState(() => _isPlaying = true);
                    },
              child: Text(_isPlaying ? 'Pause' : 'Resume'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.stop();
                setState(() => _isPlaying = false);
              },
              child: Text('Stop'),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => AdaptiveShimmer(
              loading: true,
              controller: _controller,
              child: SkeletonTemplates.listItemSkeleton(),
            ),
          ),
        ),
      ],
    );
  }
}
```

### Different Directions Per Item

```dart
class DirectionalShimmerGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const directions = [
      ShimmerDirection.ltr,
      ShimmerDirection.rtl,
      ShimmerDirection.ttb,
      ShimmerDirection.btt,
      ShimmerDirection.diagonalLTR,
      ShimmerDirection.diagonalRTL,
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: directions.length,
      itemBuilder: (context, index) => AdaptiveShimmer(
        loading: true,
        direction: directions[index],
        child: Card(
          child: Center(
            child: Text(directions[index].toString().split('.').last),
          ),
        ),
      ),
    );
  }
}
```

---

## Performance Optimization

### Lazy Loading Strategy

```dart
class OptimizedListView extends StatefulWidget {
  @override
  State<OptimizedListView> createState() =>
      _OptimizedListViewState();
}

class _OptimizedListViewState extends State<OptimizedListView> {
  late final ShimmerController _controller;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _controller = ShimmerController();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          _loadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: 20 + (_isLoadingMore ? 5 : 0),
        itemBuilder: (context, index) {
          // Show skeleton only for newly loading items
          bool isLoading = index >= 20 && _isLoadingMore;

          return AdaptiveShimmer(
            loading: isLoading,
            child: ListTile(
              title: Text(isLoading ? 'Loading...' : 'Item $index'),
            ),
          );
        },
      ),
    );
  }

  void _loadMore() {
    setState(() => _isLoadingMore = true);
    Future.delayed(Duration(seconds: 2), () {
      setState(() => _isLoadingMore = false);
    });
  }
}
```

### Reusing Controllers

```dart
class MultiShimmerScreen extends StatefulWidget {
  @override
  State<MultiShimmerScreen> createState() =>
      _MultiShimmerScreenState();
}

class _MultiShimmerScreenState extends State<MultiShimmerScreen> {
  late final ShimmerController _sharedController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _sharedController = ShimmerController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // All these use the same controller for synchronized animations
        AdaptiveShimmer(
          loading: _isLoading,
          controller: _sharedController,
          child: SkeletonTemplates.profileSkeleton(),
        ),
        SizedBox(height: 20),
        AdaptiveShimmer(
          loading: _isLoading,
          controller: _sharedController,
          child: SkeletonTemplates.postSkeleton(),
        ),
        SizedBox(height: 20),
        AdaptiveShimmer(
          loading: _isLoading,
          controller: _sharedController,
          child: SkeletonTemplates.listItemSkeleton(),
        ),
      ],
    );
  }
}
```

---

## Accessibility Integration

### Respecting User Preferences

```dart
class AccessibleLoadingWidget extends StatelessWidget {
  final bool isLoading;

  const AccessibleLoadingWidget({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final shouldReduceMotion =
        ShimmerAccessibility.shouldReduceMotion(context);

    return AdaptiveShimmer(
      loading: isLoading,
      // Use subtle theme for reduced motion users
      theme: shouldReduceMotion ? ShimmerTheme.subtle : ShimmerTheme.light,
      duration: ShimmerAccessibility.getSafeDuration(
        Duration(milliseconds: 1500),
        context,
      ),
      child: SkeletonTemplates.cardSkeleton(),
    );
  }
}
```

### Combining with Semantics

```dart
class SemanticLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      enabled: true,
      label: 'Loading content',
      button: true,
      child: AdaptiveShimmer(
        loading: true,
        child: Semantics(
          label: 'Content placeholder',
          child: SkeletonTemplates.postSkeleton(),
        ),
      ),
    );
  }
}
```

---

## Complete App Example

```dart
import 'package:flutter/material.dart';
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

class ProductListApp extends StatefulWidget {
  @override
  State<ProductListApp> createState() => _ProductListAppState();
}

class _ProductListAppState extends State<ProductListApp> {
  late final ShimmerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = ShimmerController();
    _simulateDataFetch();
  }

  void _simulateDataFetch() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          actions: [
            if (_isLoading)
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () => _controller.pause(),
              ),
          ],
        ),
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) => AdaptiveShimmer(
            loading: _isLoading,
            theme: ShimmerTheme.materialDark,
            controller: _controller,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SkeletonTemplates.listItemSkeleton(),
            ),
          ),
        ),
      ),
    );
  }
}
```
