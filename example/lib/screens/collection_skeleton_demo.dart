import 'package:flutter/material.dart';
import 'package:adaptive_shimmer/adaptive_shimmer.dart';

class CollectionSkeletonDemoScreen extends StatefulWidget {
  const CollectionSkeletonDemoScreen({super.key});

  @override
  State<CollectionSkeletonDemoScreen> createState() =>
      _CollectionSkeletonDemoScreenState();
}

class _CollectionSkeletonDemoScreenState
    extends State<CollectionSkeletonDemoScreen> {
  bool isLoading = true;
  CollectionType collectionType = CollectionType.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collection Skeletons'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls
            SwitchListTile(
              title: const Text('Toggle Loading'),
              value: isLoading,
              onChanged: (value) => setState(() => isLoading = value),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        setState(() => collectionType = CollectionType.list),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: collectionType == CollectionType.list
                          ? Colors.deepPurple
                          : Colors.grey,
                    ),
                    child: const Text('ListView'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        setState(() => collectionType = CollectionType.grid),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: collectionType == CollectionType.grid
                          ? Colors.deepPurple
                          : Colors.grey,
                    ),
                    child: const Text('GridView'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Demo
            Expanded(
              child: SmartCollectionSkeleton(
                loading: isLoading,
                type: collectionType,
                gridCrossAxisCount: 2,
                skeletonConfig: CollectionSkeletonConfig(
                  itemCount: collectionType == CollectionType.list ? 5 : 6,
                  itemHeight: 120,
                  spacing: 8,
                  borderRadius: 12,
                ),
                child: collectionType == CollectionType.list
                    ? _buildListView()
                    : _buildGridView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This is a sample list item with some content',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag, size: 40, color: Colors.deepPurple),
              const SizedBox(height: 8),
              Text(
                'Item ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
