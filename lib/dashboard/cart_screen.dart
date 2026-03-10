import 'package:flutter/material.dart';

import '../global_cart.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // একটু হালকা ব্যাকগ্রাউন্ড
      appBar: AppBar(
        title: const Text("My Cart 🛒", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // 🚀 ValueListenableBuilder: কার্টে কোনো চেঞ্জ হলেই স্ক্রিন আপডেট হবে
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: globalCartItems,
        builder: (context, cartItems, child) {

          // ---------------------------------------------------------
          // ১. যদি কার্ট একদম ফাঁকা থাকে (Empty Cart Design)
          // ---------------------------------------------------------
          if (cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 120, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  const Text(
                    "Your cart is empty! 😔",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Let's add some amazing products!",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // ---------------------------------------------------------
          // ২. টোটাল প্রাইস হিসাব করা (Calculation)
          // ---------------------------------------------------------
          double totalPrice = 0;
          for (var item in cartItems) {
            // দামের ভেতর থেকে '$' সাইন সরিয়ে শুধু নাম্বারটা নিচ্ছি
            String priceString = item["price"].toString().replaceAll('\$', '').trim();
            double price = double.tryParse(priceString) ?? 0.0;
            int quantity = item["quantity"] ?? 1;

            totalPrice += (price * quantity); // দাম এবং পরিমাণ গুণ করে টোটাল বের করছি
          }

          // ---------------------------------------------------------
          // ৩. কার্টের লিস্ট এবং নিচের টোটাল বিলের বার
          // ---------------------------------------------------------
          return Column(
            children: [
              // 📦 প্রোডাক্টের লিস্ট (Expanded না দিলে Column-এর ভেতর এরর খাবে)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // প্রোডাক্টের আইকন/ছবি
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(item["icon"], size: 50, color: Colors.deepOrange),
                            ),
                            const SizedBox(width: 15),

                            // প্রোডাক্টের নাম আর দাম
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"],
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item["price"],
                                    style: const TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

                            // 🚀 ম্যাজিক: প্লাস-মাইনাস বাটন
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  // ➖ মাইনাস বাটন
                                  IconButton(
                                    onPressed: () {
                                      final currentCart = List<Map<String, dynamic>>.from(globalCartItems.value);
                                      if (currentCart[index]["quantity"] > 1) {
                                        currentCart[index]["quantity"] -= 1;
                                      } else {
                                        currentCart.removeAt(index); // ১ থাকলে রিমুভ করে দাও
                                      }
                                      globalCartItems.value = currentCart;
                                    },
                                    icon: const Icon(Icons.remove, color: Colors.red),
                                    iconSize: 20,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(minWidth: 35, minHeight: 35),
                                  ),

                                  // 📦 Quantity
                                  Text(
                                    "${item["quantity"]}",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),

                                  // ➕ প্লাস বাটন
                                  IconButton(
                                    onPressed: () {
                                      final currentCart = List<Map<String, dynamic>>.from(globalCartItems.value);
                                      currentCart[index]["quantity"] += 1;
                                      globalCartItems.value = currentCart;
                                    },
                                    icon: const Icon(Icons.add, color: Colors.green),
                                    iconSize: 20,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(minWidth: 35, minHeight: 35),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 💵 নিচের টোটাল বিল এবং চেকআউট বার
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, -5))
                  ],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total Price Text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Price", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
                        Text(
                          "\$${totalPrice.toStringAsFixed(2)}", // 👈 ডাইনামিক টোটাল বিল
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                        ),
                      ],
                    ),

                    // Checkout Button
                    ElevatedButton(
                      onPressed: () {
                        // 🚀 চেকআউটের কাজ পরে করা যাবে
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Processing Checkout... 🚀"),
                            backgroundColor: Colors.deepOrange,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                      ),
                      child: const Text("Checkout", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}