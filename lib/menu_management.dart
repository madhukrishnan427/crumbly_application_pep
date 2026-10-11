import 'package:flutter/material.dart';

class MenuManagementPage extends StatefulWidget {
  const MenuManagementPage({super.key});

  @override
  State<MenuManagementPage> createState() => _MenuManagementPageState();
}

class _MenuManagementPageState extends State<MenuManagementPage> {
  static const Color coral = Color(0xFFF7636B);
  static const Color cream = Color(0xFFFFF8F3);
  static const Color ink = Color(0xFF3D3030);

  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'All';

  final List<String> categories = const [
    'All',
    'Cakes',
    'Cupcakes',
    'Brownies',
    'Cookies',
    'Desserts',
  ];

  // Product images already referenced in your project.
  final Map<String, List<String>> imageOptions = const {
    'Cakes': [
      'assets/images/chocolate_cake.jpeg',
      'assets/images/red_velvet2.jpeg',
      'assets/images/blueberry_cake.jpeg',
    ],
    'Cupcakes': [
      'assets/images/cup_cake.jpeg',
    ],
    'Brownies': [
      'assets/images/brownie_cake.jpeg',
    ],
    'Cookies': [
      'assets/images/cookie_bis.png',
    ],
    'Desserts': [
      'assets/images/choco_truffle.jpeg',
    ],
  };

  late final List<Map<String, dynamic>> products = [
    {
      'name': 'Chocolate Cake',
      'price': 650.0,
      'category': 'Cakes',
      'image': 'assets/images/chocolate_cake.jpeg',
      'description': 'Rich chocolate cake with creamy frosting.',
      'available': true,
    },
    {
      'name': 'Red Velvet Cake',
      'price': 750.0,
      'category': 'Cakes',
      'image': 'assets/images/red_velvet2.jpeg',
      'description': 'Soft red velvet cake with cream cheese frosting.',
      'available': true,
    },
    {
      'name': 'Blueberry Cake',
      'price': 600.0,
      'category': 'Cakes',
      'image': 'assets/images/blueberry_cake.jpeg',
      'description': 'Fresh blueberry cake for every occasion.',
      'available': true,
    },
    {
      'name': 'Chocolate Cupcake',
      'price': 120.0,
      'category': 'Cupcakes',
      'image': 'assets/images/cup_cake.jpeg',
      'description': 'Chocolate cupcake with a soft centre.',
      'available': true,
    },
    {
      'name': 'Chocolate Brownie',
      'price': 150.0,
      'category': 'Brownies',
      'image': 'assets/images/brownie_cake.jpeg',
      'description': 'Fudgy chocolate brownie.',
      'available': true,
    },
    {
      'name': 'Butter Cookies',
      'price': 90.0,
      'category': 'Cookies',
      'image': 'assets/images/cookie_bis.png',
      'description': 'Crunchy, buttery cookies.',
      'available': true,
    },
    {
      'name': 'Chocolate Truffle',
      'price': 180.0,
      'category': 'Desserts',
      'image': 'assets/images/choco_truffle.jpeg',
      'description': 'Smooth and delicious chocolate truffle.',
      'available': true,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    final query = searchController.text.trim().toLowerCase();

    return products.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          product['category'] == selectedCategory;

      final matchesSearch =
      (product['name'] as String).toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedProducts = filteredProducts;

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: cream,
        foregroundColor: ink,
        elevation: 0,
        title: const Text(
          'Menu Management',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Add product',
            onPressed: () => _showProductDialog(),
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header without the cake logo.
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE5DF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Bakery Menu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ink,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${products.length} products in your menu',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () => _showProductDialog(),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add Product'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: coral,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: coral,
                    ),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close_rounded),
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Horizontally scrollable category filters
              SizedBox(
                height: 42,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;

                    return ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: coral,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : ink,
                        fontWeight: FontWeight.w500,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? coral
                            : const Color(0xFFEBDDD7),
                      ),
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${displayedProducts.length} products found',
                  style: const TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              if (displayedProducts.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 48,
                    horizontal: 24,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 56,
                          color: Colors.black26,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No products found',
                          style: TextStyle(
                            color: ink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Try another search or category.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                )
              else
              // The outer page scrolls; this list does not scroll separately.
                ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                  itemCount: displayedProducts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _productCard(displayedProducts[index]);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productCard(Map<String, dynamic> product) {
    final bool available = product['available'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1E5DF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Image.asset(
              product['image'] as String,
              width: 92,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 92,
                  height: 100,
                  color: const Color(0xFFFFE5DF),
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    size: 38,
                    color: coral,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'] as String,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product['category'] as String,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product['description'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '₹${(product['price'] as num).toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: coral,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Available',
                      style: TextStyle(fontSize: 11),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: available,
                        activeTrackColor: coral,
                        onChanged: (value) {
                          setState(() {
                            product['available'] = value;
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Edit product',
                      visualDensity: VisualDensity.compact,
                      onPressed: () =>
                          _showProductDialog(product: product),
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: coral,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Delete product',
                      visualDensity: VisualDensity.compact,
                      onPressed: () => _confirmDelete(product),
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showProductDialog({
    Map<String, dynamic>? product,
  }) async {
    final bool isEditing = product != null;

    final nameController = TextEditingController(
      text: isEditing ? product['name'] as String : '',
    );

    final priceController = TextEditingController(
      text: isEditing ? (product['price'] as num).toString() : '',
    );

    final descriptionController = TextEditingController(
      text: isEditing ? product['description'] as String : '',
    );

    String category =
    isEditing ? product['category'] as String : 'Cakes';

    String imagePath = isEditing
        ? product['image'] as String
        : imageOptions['Cakes']!.first;

    final formKey = GlobalKey<FormState>();

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            final options =
                imageOptions[category] ?? imageOptions['Cakes']!;

            if (!options.contains(imagePath)) {
              imagePath = options.first;
            }

            return AlertDialog(
              backgroundColor: cream,
              title: Text(
                isEditing ? 'Edit Product' : 'Add Product',
                style: const TextStyle(
                  color: ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nameController,
                          textCapitalization:
                          TextCapitalization.words,
                          decoration:
                          _fieldDecoration('Product name'),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Enter a product name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        TextFormField(
                          controller: priceController,
                          keyboardType:
                          const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: _fieldDecoration('Price (₹)'),
                          validator: (value) {
                            final price = double.tryParse(
                              value?.trim() ?? '',
                            );

                            if (price == null ||
                                !price.isFinite ||
                                price <= 0) {
                              return 'Enter a valid price';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        DropdownButtonFormField<String>(
                          key: ValueKey('category-$category'),
                          initialValue: category,
                          isExpanded: true,
                          decoration: _fieldDecoration('Category'),
                          items: categories
                              .where((item) => item != 'All')
                              .map(
                                (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;

                            setDialogState(() {
                              category = value;
                              imagePath =
                                  imageOptions[category]!.first;
                            });
                          },
                        ),

                        const SizedBox(height: 12),

                        DropdownButtonFormField<String>(
                          key: ValueKey('image-$category-$imagePath'),
                          initialValue: imagePath,
                          isExpanded: true,
                          decoration:
                          _fieldDecoration('Product image'),
                          items: options
                              .map(
                                (path) => DropdownMenuItem<String>(
                              value: path,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(6),
                                    child: Image.asset(
                                      path,
                                      width: 38,
                                      height: 38,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, __, ___) {
                                        return const Icon(
                                          Icons
                                              .image_not_supported_outlined,
                                          size: 30,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      path.split('/').last,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              .toList(),
                          selectedItemBuilder: (context) {
                            return options.map((path) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  path.split('/').last,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList();
                          },
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() {
                                imagePath = value;
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 12),

                        TextFormField(
                          controller: descriptionController,
                          maxLines: 3,
                          textCapitalization:
                          TextCapitalization.sentences,
                          decoration:
                          _fieldDecoration('Description'),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Enter a description';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: ink),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: coral,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (!(formKey.currentState?.validate() ??
                        false)) {
                      return;
                    }

                    final price = double.tryParse(
                      priceController.text.trim(),
                    );

                    if (price == null ||
                        !price.isFinite ||
                        price <= 0) {
                      return;
                    }

                    // Return the values to the calling function.
                    // The product list is updated after the dialog closes.
                    Navigator.pop(dialogContext, {
                      'name': nameController.text.trim(),
                      'price': price,
                      'category': category,
                      'image': imagePath,
                      'description':
                      descriptionController.text.trim(),
                      'available': isEditing
                          ? product['available'] as bool
                          : true,
                    });
                  },
                  child: Text(
                    isEditing ? 'Save Changes' : 'Add Product',
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();

    if (!mounted || result == null) return;

    // Update the product list after the dialog has closed.
    setState(() {
      if (isEditing) {
        product
          ..['name'] = result['name']
          ..['price'] = result['price']
          ..['category'] = result['category']
          ..['image'] = result['image']
          ..['description'] = result['description'];
      } else {
        products.insert(0, result);
        selectedCategory = 'All';
        searchController.clear();
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEditing
              ? 'Product updated successfully'
              : 'Product added successfully',
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void _confirmDelete(Map<String, dynamic> product) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: cream,
          title: const Text('Delete Product?'),
          content: Text(
            'Are you sure you want to delete '
                '"${product['name']}" from your menu?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  products.remove(product);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product deleted'),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}