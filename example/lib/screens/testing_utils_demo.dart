import 'package:flutter/material.dart';
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

class TestingUtilsDemoScreen extends StatefulWidget {
  const TestingUtilsDemoScreen({super.key});

  @override
  State<TestingUtilsDemoScreen> createState() => _TestingUtilsDemoScreenState();
}

class _TestingUtilsDemoScreenState extends State<TestingUtilsDemoScreen> {
  bool isLoading = true;
  Map<String, int>? skeletonCounts;
  String? skeletonTree;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _analyzeSkeletons();
    });
  }

  void _analyzeSkeletons() {
    if (!mounted) return;
    // In a real test, you would use ShimmerTester methods here
    // For demo purposes, we show conceptual usage
    setState(() {
      skeletonCounts = {
        'SkeletonBox': 2,
        'SkeletonCircle': 2,
        'SkeletonLine': 6,
      };
      skeletonTree =
          'Skeleton tree structure:\n'
          '├── SkeletonBox (width: 100, height: 200)\n'
          '├── SkeletonCircle (radius: 40)\n'
          '├── SkeletonLine (width: 200, height: 12)\n'
          '└── SkeletonLine (width: 150, height: 12)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing Utilities'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Toggle Loading'),
                value: isLoading,
                onChanged: (value) {
                  setState(() => isLoading = value);
                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (mounted) _analyzeSkeletons();
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Sample Widget Tree with Skeletons',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SmartSkeleton(loading: isLoading, child: _buildSampleContent()),
              const SizedBox(height: 32),
              Text(
                'Skeleton Analysis',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (skeletonCounts != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Skeleton Count by Type:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...skeletonCounts!.entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${entry.value}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Skeleton Tree Structure:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        skeletonTree ?? '',
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ] else
                Center(
                  child: Text(
                    'Load content to analyze',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🧪 Testing Utilities',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Available in tests:\n'
                      '• ShimmerTester.findSkeletonWidgets()\n'
                      '• ShimmerTester.countSkeletonsByType()\n'
                      '• ShimmerTester.verifySkeletonCount()\n'
                      '• ShimmerTester.getSkeletonBoxSizes()\n'
                      '• MockShimmerController for state\n'
                      '• ShimmerTestHarness widget',
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

  Widget _buildSampleContent() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.image, size: 50),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 16,
                    color: Colors.deepPurple.withOpacity(0.2),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 12,
                    color: Colors.deepPurple.withOpacity(0.1),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 200,
                    height: 12,
                    color: Colors.deepPurple.withOpacity(0.1),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple.withOpacity(0.2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 14,
                    color: Colors.deepPurple.withOpacity(0.2),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 80,
                    height: 12,
                    color: Colors.deepPurple.withOpacity(0.1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
