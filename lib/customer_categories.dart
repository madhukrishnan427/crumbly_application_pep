import 'package:flutter/material.dart';

class CustomerCategories extends StatelessWidget {
  const CustomerCategories({super.key});

  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);

  final List<Map<String, String>> categories = const [
    {
      'name': 'Cakes',
      'image': 'assets/images/chocolate_cake.jpeg',
      'description': 'Celebration cakes and classic favourites',
    },
    {
      'name': 'Cupcakes',
      'image': 'assets/images/cup_cake.jpeg',
      'description': 'Little treats for every occasion',
    },
    {
      'name': 'Brownies',
      'image': 'assets/images/brownie_1.jpeg',
      'description': 'Rich, fudgy chocolate brownies',
    },
    {
      'name': 'Cookies',
      'image': 'assets/images/cookie_bis.png',
      'description': 'Freshly baked crunchy cookies',
    },
    {
      'name': 'Cheesecakes',
      'image': 'assets/images/cheese_cake.jpeg',
      'description': 'Creamy and delicious cheesecakes',
    },
    {
      'name': 'Special Desserts',
      'image': 'assets/images/tiramisu_cake.jpeg',
      'description': 'Sweet treats for a special day',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        title: const Text('Explore Treats'),
        backgroundColor: cream,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 950),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 700
                  ? 3
                  : constraints.maxWidth >= 450
                  ? 2
                  : 1;

              return GridView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: columns == 1 ? 1.7 : 0.9,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        showDragHandle: true,
                        backgroundColor: cream,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category['name']!,
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(category['description']!),
                                const SizedBox(height: 18),
                                const Text(
                                  'Product browsing is a demo. Connect your product data to display available items here.',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: coral,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: const Text('Close'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color(0xFFF3E4DE),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Image.asset(
                                category['image']!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Center(
                                  child: Icon(
                                    Icons.cake_outlined,
                                    size: 45,
                                    color: coral,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category['name']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  category['description']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}