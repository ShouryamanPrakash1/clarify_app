import 'package:flutter/material.dart';
import 'package:cartify_app/model/api_service.dart'; // Adjust path based on your project
import 'package:cartify_app/model/items.dart'; // Ensure this points to your Catalogue/Product models

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>?> _productsFuture;
  final List<Product> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService().fetchProducts();
  }

  void addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Catalogue',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Show cart items (optional: navigate to cart page)
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>?>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          List<Product> products = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                childAspectRatio: 0.7, // Adjusted aspect ratio for better image fit
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                double exchangeRate = 85.78; // USD to INR conversion
                double priceInRupees = (product.price ?? 0) * exchangeRate;
                double discountPercentage = product.discountPercentage ?? 0;
                double finalPrice = priceInRupees * (1 - discountPercentage / 100);

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.network(
                                product.thumbnail ?? '',
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported, size: 50),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  product.title ?? 'No title',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹${finalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₹${priceInRupees.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 12, color: Colors.red, decoration: TextDecoration.lineThrough),
                                ),
                                Text(
                                  '-${discountPercentage.toStringAsFixed(1)}% OFF',
                                  style: const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: InkWell(
                          onTap: () => addToCart(product),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5), // Semi-transparent background
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Add',
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
