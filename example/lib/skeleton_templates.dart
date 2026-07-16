import 'package:adaptive_shimmer/adaptive_shimmer.dart';
import 'package:flutter/material.dart';

/// Skeleton loading template for product page
class SkeletonProductPage extends StatelessWidget {
  const SkeletonProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          SkeletonBox(
            width: double.infinity,
            height: 300,
            borderRadius: 8,
          ),
          const SizedBox(height: 24),

          // Product Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(width: 200, height: 20),
                const SizedBox(height: 16),

                // Price
                Row(
                  children: [
                    SkeletonLine(width: 100, height: 24),
                    const SizedBox(width: 16),
                    SkeletonLine(width: 80, height: 16),
                  ],
                ),
                const SizedBox(height: 16),

                // Rating
                Row(
                  children: [
                    SkeletonCircle(radius: 8),
                    const SizedBox(width: 8),
                    SkeletonLine(width: 150, height: 16),
                  ],
                ),
                const SizedBox(height: 24),

                // Description
                SkeletonParagraph(
                  width: double.infinity,
                  lineCount: 4,
                  spacing: 10,
                ),
                const SizedBox(height: 24),

                // Add to Cart Button
                SkeletonBox(
                  width: double.infinity,
                  height: 50,
                  borderRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton loading template for profile page
class SkeletonProfilePage extends StatelessWidget {
  const SkeletonProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Avatar
          Center(
            child: SkeletonCircle(radius: 50),
          ),
          const SizedBox(height: 16),

          // Name
          Center(
            child: SkeletonLine(width: 200, height: 20),
          ),
          const SizedBox(height: 8),

          // Username
          Center(
            child: SkeletonLine(width: 150, height: 14),
          ),
          const SizedBox(height: 24),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (_) => Column(
                  children: [
                    SkeletonLine(width: 50, height: 20),
                    const SizedBox(height: 8),
                    SkeletonLine(width: 60, height: 12),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Bio
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SkeletonParagraph(
              width: double.infinity,
              lineCount: 2,
              spacing: 8,
            ),
          ),
          const SizedBox(height: 24),

          // Follow Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SkeletonBox(
              width: double.infinity,
              height: 45,
              borderRadius: 8,
            ),
          ),
          const SizedBox(height: 24),

          // Gallery Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(width: 80, height: 18),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 6,
                  itemBuilder: (_, __) => SkeletonBox(
                    width: double.infinity,
                    height: 120,
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton loading template for feed list
class SkeletonFeedPage extends StatelessWidget {
  final int itemCount;

  const SkeletonFeedPage({
    Key? key,
    this.itemCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (avatar + name + time)
            Row(
              children: [
                SkeletonCircle(radius: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLine(width: 120, height: 14),
                      const SizedBox(height: 6),
                      SkeletonLine(width: 80, height: 12),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Post Image
            SkeletonBox(
              width: double.infinity,
              height: 250,
              borderRadius: 8,
            ),
            const SizedBox(height: 12),

            // Post Text
            SkeletonParagraph(
              width: double.infinity,
              lineCount: 2,
              spacing: 8,
            ),
            const SizedBox(height: 12),

            // Engagement (likes, comments, shares)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (_) => SkeletonLine(width: 60, height: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton loading template for e-commerce product list
class SkeletonProductList extends StatelessWidget {
  final int itemCount;

  const SkeletonProductList({
    Key? key,
    this.itemCount = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (_, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          SkeletonBox(
            width: double.infinity,
            height: 150,
            borderRadius: 8,
          ),
          const SizedBox(height: 12),

          // Product Name
          SkeletonLine(width: double.infinity, height: 14),
          const SizedBox(height: 8),

          // Price
          SkeletonLine(width: 80, height: 16),
          const SizedBox(height: 8),

          // Rating
          Row(
            children: [
              SkeletonLine(width: 60, height: 12),
              const SizedBox(width: 8),
              SkeletonLine(width: 40, height: 12),
            ],
          ),
        ],
      ),
    );
  }
}
