import 'package:flutter/material.dart';
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

/// Custom widget for demo
class CustomCard extends StatelessWidget {
  final String title;
  final String description;

  const CustomCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          Text(description, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}

class CustomTransformersDemoScreen extends StatefulWidget {
  const CustomTransformersDemoScreen({super.key});

  @override
  State<CustomTransformersDemoScreen> createState() =>
      _CustomTransformersDemoScreenState();
}

class _CustomTransformersDemoScreenState
    extends State<CustomTransformersDemoScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Transformers'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Toggle Loading'),
                value: isLoading,
                onChanged: (value) => setState(() => isLoading = value),
              ),
              const SizedBox(height: 24),
              Text(
                'With Custom Transformer for CustomCard',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SmartSkeleton(
                loading: isLoading,
                config: SmartSkeletonConfig(
                  replacementStrategy: SkeletonReplacementStrategy.textAndImages,
                  customTransformers: [
                    // Custom transformer for CustomCard
                    SkeletonTransformer(
                      predicate: (widget) => widget is CustomCard,
                      transformer: (widget) => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurple.withOpacity(0.2),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonLine(width: 150, height: 16),
                            const SizedBox(height: 8),
                            SkeletonLine(width: double.infinity, height: 12),
                            const SizedBox(height: 4),
                            SkeletonLine(width: 200, height: 12),
                          ],
                        ),
                      ),
                      priority: 10,
                      name: 'CustomCard',
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CustomCard(
                      title: 'Feature One',
                      description: 'This is a custom card with special styling',
                    ),
                    const SizedBox(height: 12),
                    CustomCard(
                      title: 'Feature Two',
                      description:
                          'Custom transformers let you handle any widget',
                    ),
                    const SizedBox(height: 12),
                    CustomCard(
                      title: 'Feature Three',
                      description: 'Priority system ensures correct order',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Cache Statistics',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildCacheStats(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCacheStats() {
    final stats = SmartSkeleton.getCacheStats();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cache Size: ${stats.size}/${stats.maxSize}'),
          Text('Utilization: ${stats.utilization}%'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              SmartSkeleton.clearCache();
              setState(() {});
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Cache cleared')));
            },
            child: const Text('Clear Cache'),
          ),
        ],
      ),
    );
  }
}
