import 'package:adaptive_shimmer/adaptive_shimmer.dart';
import 'package:flutter/material.dart';
import 'screens/direction_demo.dart';
import 'screens/intensity_demo.dart';
import 'screens/animation_type_demo.dart';
import 'screens/templates_demo.dart';
import 'screens/staggered_demo.dart';
import 'screens/empty_space_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Shimmer Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Adaptive Shimmer'),
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
  final List<DemoItem> demos = [
    DemoItem(
      title: 'Animation Types',
      description: 'Shimmer, Pulse, Combined',
      icon: Icons.animation,
      screen: const AnimationTypeDemoScreen(),
    ),
    DemoItem(
      title: 'Direction Control',
      description: '8 Different directions',
      icon: Icons.trending_up,
      screen: const DirectionDemoScreen(),
    ),
    DemoItem(
      title: 'Intensity Control',
      description: 'Adjust shimmer brightness',
      icon: Icons.brightness_6,
      screen: const IntensityDemoScreen(),
    ),
    DemoItem(
      title: 'Staggered Shimmer',
      description: 'Cascade loading effect',
      icon: Icons.view_agenda,
      screen: const StaggeredDemoScreen(),
    ),
    DemoItem(
      title: 'Templates',
      description: 'Product, Profile, Feed',
      icon: Icons.inventory_2,
      screen: const TemplatesDemoScreen(),
    ),
    DemoItem(
      title: 'Empty Space Handling',
      description: 'Fill padding and SizedBox',
      icon: Icons.space_bar,
      screen: const EmptySpaceDemoScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adaptive Shimmer',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Zero-dependency skeleton loader with shimmer animations',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Demo Grid
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Features',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: demos.length,
                    itemBuilder: (_, index) {
                      final demo = demos[index];
                      return DemoCard(
                        demo: demo,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => demo.screen),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Quick Examples
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Examples',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ..._buildQuickExamples(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildQuickExamples(BuildContext context) {
    return [
      // Example 1: Basic Shimmer
      _buildExampleCard(
        context,
        title: 'Basic Shimmer',
        child: AdaptiveShimmer(
          loading: true,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      const SizedBox(height: 12),

      // Example 2: Multiple Directions
      _buildExampleCard(
        context,
        title: 'Multiple Directions',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AdaptiveShimmer(
              loading: true,
              direction: ShimmerDirection.ltr,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            AdaptiveShimmer(
              loading: true,
              direction: ShimmerDirection.ttb,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            AdaptiveShimmer(
              loading: true,
              direction: ShimmerDirection.diagonalLTR,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),

      // Example 3: Skeleton Widgets
      _buildExampleCard(
        context,
        title: 'Skeleton Widgets',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SkeletonCircle(radius: 15),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLine(width: 100, height: 10),
                      const SizedBox(height: 6),
                      SkeletonLine(width: 150, height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ],
    );
  }
}

class DemoItem {
  final String title;
  final String description;
  final IconData icon;
  final Widget screen;

  DemoItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.screen,
  });
}

class DemoCard extends StatelessWidget {
  final DemoItem demo;
  final VoidCallback onTap;

  const DemoCard({Key? key, required this.demo, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.withOpacity(0.05),
                      Colors.deepPurple.withOpacity(0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(demo.icon, size: 28, color: Colors.deepPurple),
                    const SizedBox(height: 12),
                    Text(
                      demo.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      demo.description,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
