import 'package:flutter/material.dart';

import '../global_cart.dart';


class ProductDetails extends StatefulWidget {
  final String productName;
  final String productPrice;
  final IconData productIcon;

  const ProductDetails({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productIcon,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // হালকা গ্রে ব্যাকগ্রাউন্ড
      appBar: AppBar(
        title: const Text("Product Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // বডি স্ক্রল করার জন্য SingleChildScrollView
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ১. প্রোডাক্টের বড় ছবি
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.white,
              child: Image.network(
                "https://picsum.photos/400", // হোম পেজের মতই ছবি আনলাম
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(widget.productIcon, size: 100, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 10),

            // ২. প্রোডাক্টের নাম, দাম এবং রেটিং
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.productPrice,
                    style: const TextStyle(fontSize: 26, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // নকল রেটিং (দেখতে সুন্দর লাগার জন্য)
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                      const Icon(Icons.star_half, color: Colors.orange, size: 20),
                      const SizedBox(width: 8),
                      Text("(124 Reviews)", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ৩. প্রোডাক্ট ডেসক্রিপশন (বিস্তারিত)
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "This is a premium quality ${widget.productName}. It features a sleek design and outstanding durability. Perfect for your daily needs. Order now and get it delivered within 3-5 business days!",
                    style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),

      // ৪. একদম নিচে ফিক্সড Add to Cart বাটন (দারাজের মত)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.white,
        child: Row(
          children: [
            // Chat বাটন (অতিরিক্ত ডিজাইন)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.storefront, color: Colors.deepOrange),
                ),
                const Text("Store", style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(width: 15),

            // আসল Add to Cart বাটন
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // 🚀 আমাদের সেই স্মার্ট লজিক
                  final currentCart = List<Map<String, dynamic>>.from(globalCartItems.value);
                  int existingIndex = currentCart.indexWhere((item) => item["name"] == widget.productName);

                  if (existingIndex != -1) {
                    currentCart[existingIndex]["quantity"] = (currentCart[existingIndex]["quantity"] ?? 1) + 1;
                  } else {
                    currentCart.add({
                      "name": widget.productName,
                      "price": widget.productPrice,
                      "icon": widget.productIcon,
                      "quantity": 1,
                    });
                  }

                  globalCartItems.value = currentCart;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${widget.productName} added to cart! 🛒"),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}