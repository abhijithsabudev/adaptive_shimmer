import 'package:flutter/material.dart';
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

class MemoizationDemoScreen extends StatefulWidget {
  const MemoizationDemoScreen({super.key});

  @override
  State<MemoizationDemoScreen> createState() => _MemoizationDemoScreenState();
}

class _MemoizationDemoScreenState extends State<MemoizationDemoScreen> {
  bool isLoading = true;
  bool useMemoization = true;
  int rebuildCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memoization Performance'),
        elevation: 0,
      ),
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
              SwitchListTile(
                title: const Text('Use Memoization'),
                value: useMemoization,
                onChanged: (value) {
                  setState(() {
                    useMemoization = value;
                    rebuildCount++;
                  });
                  SmartSkeleton.clearCache();
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => setState(() => rebuildCount++),
                icon: const Icon(Icons.refresh),
                label: const Text('Force Rebuild'),
              ),
              const SizedBox(height: 24),
              // Performance metrics
              _buildMetricsCard(),
              const SizedBox(height: 24),
              Text(
                'Demo Content (Rebuild ${rebuildCount + 1})',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SmartSkeleton(
                loading: isLoading,
                config: SmartSkeletonConfig(
                  cacheStrategy: useMemoization
                      ? CacheStrategy.enabled
                      : CacheStrategy.disabled,
                  debugMode: true, // Shows cache messages
                ),
                child: Column(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.shopping_bag,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Item ${index + 1}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'These widgets are cached after first transformation',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⚡ Memoization Benefits',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'With memoization enabled:\n'
                      '• Repeated widgets use cached skeleton\n'
                      '• No re-transformation on rebuilds\n'
                      '• Better performance for large lists\n'
                      '• Default cache size: 1000 items\n\n'
                      'Check console logs for cache hits (debug mode)',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsCard() {
    final stats = SmartSkeleton.getCacheStats();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cache Metrics',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              TextButton.icon(
                onPressed: () {
                  SmartSkeleton.clearCache();
                  setState(() {});
                },
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cache Size',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    '${stats.size} / ${stats.maxSize}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Utilization',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    '${stats.utilization}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Memoization',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    useMemoization ? 'Enabled' : 'Disabled',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: useMemoization ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
