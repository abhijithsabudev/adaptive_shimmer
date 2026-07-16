import 'package:adaptive_shimmer/adaptive_shimmer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Shimmer Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Adaptive Shimmer Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggle loading state
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = !isLoading;
                  });
                },
                child: Text(isLoading ? 'Stop Loading' : 'Start Loading'),
              ),
              const SizedBox(height: 24),

              // 1. Basic Shimmer with custom widget
              _buildSection(
                title: '1. Basic Shimmer',
                child: AdaptiveShimmer(
                  loading: isLoading,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('Custom Widget')),
                  ),
                ),
              ),

              // 2. Pulse Animation
              _buildSection(
                title: '2. Pulse Animation',
                child: AdaptiveShimmer(
                  loading: isLoading,
                  animationType: AnimationType.pulse,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('Pulse Effect')),
                  ),
                ),
              ),

              // 3. Combined Shimmer + Pulse
              _buildSection(
                title: '3. Combined Animation',
                child: AdaptiveShimmer(
                  loading: isLoading,
                  animationType: AnimationType.combined,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('Combined Effect')),
                  ),
                ),
              ),

              // 4. Skeleton Box
              _buildSection(
                title: '4. Skeleton Box',
                child: SkeletonBox(
                  width: double.infinity,
                  height: 100,
                  borderRadius: 8,
                ),
              ),

              // 5. Skeleton Circle
              _buildSection(
                title: '5. Skeleton Circle',
                child: Center(
                  child: SkeletonCircle(
                    radius: 40,
                  ),
                ),
              ),

              // 6. Skeleton Paragraph (Text placeholder)
              _buildSection(
                title: '6. Skeleton Paragraph',
                child: SkeletonParagraph(
                  width: double.infinity,
                  lineCount: 4,
                  spacing: 10,
                ),
              ),

              // 7. Product Card Example
              _buildSection(
                title: '7. Product Card',
                child: _buildProductCard(),
              ),

              // 8. Custom Colors
              _buildSection(
                title: '8. Custom Colors',
                child: AdaptiveShimmer(
                  loading: isLoading,
                  baseColor: const Color(0xFFFFE0B2),
                  highlightColor: const Color(0xFFFFF8E1),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0B2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('Custom Colors')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Product Image
          SkeletonCircle(
            radius: 40,
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  width: 150,
                  height: 12,
                ),
                const SizedBox(height: 8),
                SkeletonParagraph(
                  width: double.infinity,
                  lineCount: 2,
                  lineHeight: 10,
                  spacing: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
