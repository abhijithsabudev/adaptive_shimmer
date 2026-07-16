import 'package:adaptive_shimmer/adaptive_shimmer.dart';
import 'package:flutter/material.dart';

class IntensityDemoScreen extends StatefulWidget {
  const IntensityDemoScreen({Key? key}) : super(key: key);

  @override
  State<IntensityDemoScreen> createState() => _IntensityDemoScreenState();
}

class _IntensityDemoScreenState extends State<IntensityDemoScreen> {
  double _intensity = 0.7;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intensity Control'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Intensity Demo Boxes
              ...List.generate(3, (index) {
                final intensity = (index + 1) * 0.3;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Intensity: ${intensity.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    AdaptiveShimmer(
                      loading: _isLoading,
                      intensity: intensity,
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }),

              const SizedBox(height: 24),

              // Intensity Slider
              Text(
                'Custom Intensity:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Slider(
                value: _intensity,
                onChanged: (value) => setState(() => _intensity = value),
                divisions: 10,
                label: _intensity.toStringAsFixed(1),
              ),
              const SizedBox(height: 12),

              // Custom Intensity Demo
              AdaptiveShimmer(
                loading: _isLoading,
                intensity: _intensity,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('Intensity: ${_intensity.toStringAsFixed(2)}'),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Toggle
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _isLoading = !_isLoading),
                  icon: Icon(_isLoading ? Icons.stop : Icons.play_arrow),
                  label: Text(_isLoading ? 'Stop' : 'Start'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
