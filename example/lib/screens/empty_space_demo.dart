import 'package:flutter/material.dart';
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

class EmptySpaceDemoScreen extends StatefulWidget {
  const EmptySpaceDemoScreen({super.key});

  @override
  State<EmptySpaceDemoScreen> createState() => _EmptySpaceDemoScreenState();
}

class _EmptySpaceDemoScreenState extends State<EmptySpaceDemoScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Empty Space Handling'), elevation: 0),
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
                },
              ),
              const SizedBox(height: 24),
              _DemoSection(
                title: 'Default Mode (ignores empty space)',
                isLoading: isLoading,
                config: SmartSkeletonConfig.defaultConfig,
              ),
              const SizedBox(height: 32),
              _DemoSection(
                title: 'Fill Mode (fills empty space & padding)',
                isLoading: isLoading,
                config: SmartSkeletonConfig.fillMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoSection extends StatelessWidget {
  final String title;
  final bool isLoading;
  final SmartSkeletonConfig config;

  const _DemoSection({
    required this.title,
    required this.isLoading,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SmartSkeleton(loading: isLoading, config: config, child: _SampleCard()),
      ],
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile header with spacing
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Empty space
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8), // Empty space
                          const Text(
                            'Software Developer',
                            style: TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // Large empty space
              // Description with padding
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12), // Empty space
                    const Text(
                      'Passionate about building amazing apps and solving complex problems with elegant solutions.',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Empty space
              // Empty SizedBox sections to demonstrate fillEmptySpace
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Connect'),
                      ),
                    ),
                    const SizedBox(width: 12), // Empty space between buttons
                    SizedBox(
                      width: 120,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Message'),
                      ),
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
