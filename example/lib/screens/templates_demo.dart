import 'package:adaptive_shimmer/adaptive_shimmer.dart';
import 'package:flutter/material.dart';
import '../skeleton_templates.dart';

class TemplatesDemoScreen extends StatefulWidget {
  const TemplatesDemoScreen({Key? key}) : super(key: key);

  @override
  State<TemplatesDemoScreen> createState() => _TemplatesDemoScreenState();
}

class _TemplatesDemoScreenState extends State<TemplatesDemoScreen> {
  bool _isLoadingProduct = true;
  bool _isLoadingProfile = true;
  bool _isLoadingFeed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template Examples'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Template
            _buildTemplateSection(
              title: 'Product Page',
              isLoading: _isLoadingProduct,
              onToggle: () =>
                  setState(() => _isLoadingProduct = !_isLoadingProduct),
              child: ScreenShimmer(
                loading: _isLoadingProduct,
                child: _isLoadingProduct
                    ? const SkeletonProductPage()
                    : _buildActualProductPage(),
              ),
            ),

            // Profile Template
            _buildTemplateSection(
              title: 'Profile Page',
              isLoading: _isLoadingProfile,
              onToggle: () =>
                  setState(() => _isLoadingProfile = !_isLoadingProfile),
              child: ScreenShimmer(
                loading: _isLoadingProfile,
                child: _isLoadingProfile
                    ? const SkeletonProfilePage()
                    : _buildActualProfilePage(),
              ),
            ),

            // Feed Template
            _buildTemplateSection(
              title: 'Feed List',
              isLoading: _isLoadingFeed,
              onToggle: () => setState(() => _isLoadingFeed = !_isLoadingFeed),
              child: ScreenShimmer(
                loading: _isLoadingFeed,
                child: _isLoadingFeed
                    ? const SkeletonFeedPage(itemCount: 2)
                    : _buildActualFeedPage(),
              ),
              maxHeight: 400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateSection({
    required String title,
    required bool isLoading,
    required VoidCallback onToggle,
    required Widget child,
    double? maxHeight,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              ElevatedButton.icon(
                onPressed: onToggle,
                icon: Icon(isLoading ? Icons.stop : Icons.play_arrow),
                label: Text(isLoading ? 'Stop' : 'Load'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            constraints:
                maxHeight != null ? BoxConstraints(maxHeight: maxHeight) : null,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActualProductPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: Text('Product Image')),
            ),
            const SizedBox(height: 16),
            Text('Premium Wireless Headphones',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('\$199.99', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text('Amazing product with great features',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildActualProfilePage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue[200],
            child: const Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          Text('John Doe', style: Theme.of(context).textTheme.headlineSmall),
          Text('@johndoe', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildActualFeedPage() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue[200],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User ${index + 1}',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('2 hours ago',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('This is a sample post in the feed.',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
