import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final int itemIndex;

  const ProductDetails({super.key, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white), // Back বাটনের কালার সাদা করার জন্য
      ),

      // ওপর থেকে নিচে সাজানোর জন্য Column
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ১. প্রোডাক্টের বড় ছবি
          Image.network(
            "https://picsum.photos/400?random=$itemIndex", // $itemIndex দেওয়ার কারণে প্রতিবার আলাদা ছবি আসবে!
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),

          // ২. নাম, দাম এবং ডেসক্রিপশন
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Smart Watch $itemIndex - Premium Edition",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "\$99.00",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Description:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "This is a premium smart watch with all the latest features including heart rate monitoring, GPS, and a beautiful AMOLED display. Perfect for your daily use.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Spacer দিয়ে বাকি ফাঁকা জায়গাটা দখল করে বাটনটাকে একদম নিচে পাঠিয়ে দিলাম!
          const Spacer(),

          // ৩. Add to Cart বাটন
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity, // বাটনটা পুরো স্ক্রিন জুড়ে লম্বা হবে
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // এখানে ক্লিক করলে পরে আমরা Cart এ অ্যাড করার লজিক লিখব!
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Item $itemIndex Added to Cart!")),
                  );
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}