import 'package:adaptive_shimmer/adaptive_shimmer.dart';
import 'package:flutter/material.dart';

class StaggeredDemoScreen extends StatefulWidget {
  const StaggeredDemoScreen({Key? key}) : super(key: key);

  @override
  State<StaggeredDemoScreen> createState() => _StaggeredDemoScreenState();
}

class _StaggeredDemoScreenState extends State<StaggeredDemoScreen> {
  bool _isLoading = true;
  double _staggerDuration = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Shimmer'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Staggered Demo
              Text(
                'Cascade Loading Effect',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              StaggeredShimmer(
                staggerDuration:
                    Duration(milliseconds: _staggerDuration.toInt()),
                children: [
                  SkeletonBox(width: double.infinity, height: 150),
                  const SizedBox(height: 16),
                  SkeletonLine(width: 200, height: 18),
                  const SizedBox(height: 8),
                  SkeletonLine(width: 300, height: 16),
                  const SizedBox(height: 16),
                  SkeletonBox(width: double.infinity, height: 100),
                ],
              ),

              const SizedBox(height: 32),

              // Stagger Duration Slider
              Text(
                'Stagger Duration: ${_staggerDuration.toInt()}ms',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Slider(
                value: _staggerDuration,
                onChanged: (value) => setState(() => _staggerDuration = value),
                min: 50,
                max: 500,
                divisions: 9,
              ),

              const SizedBox(height: 32),

              // Staggered with Direction
              Text(
                'Different Direction',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              StaggeredShimmer(
                direction: ShimmerDirection.rtl,
                staggerDuration:
                    Duration(milliseconds: _staggerDuration.toInt()),
                children: [
                  SkeletonCircle(radius: 25),
                  const SizedBox(height: 12),
                  SkeletonLine(width: double.infinity),
                  const SizedBox(height: 8),
                  SkeletonLine(width: double.infinity),
                ],
              ),

              const SizedBox(height: 32),

              // Toggle
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _isLoading = !_isLoading),
                  icon: Icon(_isLoading ? Icons.stop : Icons.play_arrow),
                  label: Text(_isLoading ? 'Stop Loading' : 'Start Loading'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
