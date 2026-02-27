import 'package:flutter/material.dart';
// 👇 তোমার গ্লোবাল ফাইলটা এখানে ইমপোর্ট করা হলো (ফোল্ডার অনুযায়ী ../ লাগতে পারে)
import '../global_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  // 👇 আগের সেই হার্ডকোড করা cartItems লিস্টটা এখান থেকে চিরতরে মুছে দিয়েছি!

  int calculateTotal() {
    int total = 0;
    // 👇 এখন সে গ্লোবাল লিস্ট থেকে দাম হিসাব করবে
    for (var item in globalCartItems) {
      String priceString = item["price"].replaceAll('\$', '');
      total += int.parse(priceString);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),

      // 👇 সব জায়গায় globalCartItems বসিয়ে দিয়েছি
      body: globalCartItems.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.remove_shopping_cart_outlined, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              "Your Cart is Empty!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: globalCartItems.length, // 👈 গ্লোবাল লিস্ট
        itemBuilder: (context, index) {
          final item = globalCartItems[index]; // 👈 গ্লোবাল লিস্ট

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item["icon"], color: Colors.blueAccent),
              ),
              title: Text(item["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item["price"], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  setState(() {
                    globalCartItems.removeAt(index); // 👈 গ্লোবাল লিস্ট থেকে ডিলিট হবে
                  });
                },
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: globalCartItems.isEmpty
          ? const SizedBox()
          : Container(
        padding: const EdgeInsets.all(16),
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, -5))
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "Total: \$${calculateTotal()}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
              child: const Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
              ),
            )
          ],
        ),
      ),
    );
  }
}