import 'package:adaptive_shimmer/adaptive_shimmer.dart';
import 'package:flutter/material.dart';

class AnimationTypeDemoScreen extends StatefulWidget {
  const AnimationTypeDemoScreen({Key? key}) : super(key: key);

  @override
  State<AnimationTypeDemoScreen> createState() =>
      _AnimationTypeDemoScreenState();
}

class _AnimationTypeDemoScreenState extends State<AnimationTypeDemoScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Types'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Shimmer
              _buildAnimationDemo(
                title: 'Shimmer',
                description: 'Classic wave effect',
                type: AnimationType.shimmer,
              ),
              const SizedBox(height: 24),

              // Pulse
              _buildAnimationDemo(
                title: 'Pulse',
                description: 'Fade in/out effect',
                type: AnimationType.pulse,
              ),
              const SizedBox(height: 24),

              // Combined
              _buildAnimationDemo(
                title: 'Combined',
                description: 'Shimmer + Pulse',
                type: AnimationType.combined,
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

  Widget _buildAnimationDemo({
    required String title,
    required String description,
    required AnimationType type,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 12),
        AdaptiveShimmer(
          loading: _isLoading,
          animationType: type,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child:
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
        ),
      ],
    );
  }
}
