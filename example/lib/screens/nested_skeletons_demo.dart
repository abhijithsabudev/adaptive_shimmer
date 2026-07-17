import 'package:flutter/material.dart';
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

class NestedSkeletonsDemoScreen extends StatefulWidget {
  const NestedSkeletonsDemoScreen({super.key});

  @override
  State<NestedSkeletonsDemoScreen> createState() =>
      _NestedSkeletonsDemoScreenState();
}

class _NestedSkeletonsDemoScreenState extends State<NestedSkeletonsDemoScreen> {
  bool outerLoading = true;
  bool innerLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nested Skeletons'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Outer Skeleton',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Outer Loading'),
                value: outerLoading,
                onChanged: (value) => setState(() => outerLoading = value),
              ),
              const SizedBox(height: 8),
              Text(
                'Inner Skeleton',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: const Text('Inner Loading'),
                value: innerLoading,
                onChanged: (value) => setState(() => innerLoading = value),
              ),
              const SizedBox(height: 24),
              // Outer skeleton wrapping inner skeleton
              SmartSkeleton(
                loading: outerLoading,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Outer Container',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Inner skeleton (nested inside outer)
                      SmartSkeleton(
                        loading: innerLoading,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nested Inner Container',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'This content can load independently of the outer skeleton',
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.check_circle),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Nested Content',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Independent loading state',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '💡 Nesting Levels',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Each nested SmartSkeleton increases nesting level. Default max: 5 levels.\n'
                      'Outer Skeleton → Level 1\n'
                      'Inner Skeleton → Level 2\n'
                      'Both can be configured independently!',
                      style: TextStyle(color: Colors.grey[700]),
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
}
