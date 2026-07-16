import 'package:adaptive_shimmer/adaptive_shimmer.dart';
import 'package:flutter/material.dart';

class DirectionDemoScreen extends StatefulWidget {
  const DirectionDemoScreen({Key? key}) : super(key: key);

  @override
  State<DirectionDemoScreen> createState() => _DirectionDemoScreenState();
}

class _DirectionDemoScreenState extends State<DirectionDemoScreen> {
  ShimmerDirection _selectedDirection = ShimmerDirection.ltr;
  bool _isLoading = true;

  final List<(ShimmerDirection, String)> directions = [
    (ShimmerDirection.ltr, 'Left to Right'),
    (ShimmerDirection.rtl, 'Right to Left'),
    (ShimmerDirection.ttb, 'Top to Bottom'),
    (ShimmerDirection.btt, 'Bottom to Top'),
    (ShimmerDirection.diagonalLTR, 'Diagonal LTR'),
    (ShimmerDirection.diagonalRTL, 'Diagonal RTL'),
    (ShimmerDirection.diagonalBLTR, 'Diagonal BLTR'),
    (ShimmerDirection.wave, 'Wave Pattern'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direction Control'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer Demo Box
              AdaptiveShimmer(
                loading: _isLoading,
                direction: _selectedDirection,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Shimmer ${_selectedDirection.toString().split('.').last}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Direction Selector
              Text(
                'Select Direction:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: directions.map((direction) {
                  return FilterChip(
                    label: Text(direction.$2),
                    selected: _selectedDirection == direction.$1,
                    onSelected: (_) {
                      setState(() => _selectedDirection = direction.$1);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Toggle Loading
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
