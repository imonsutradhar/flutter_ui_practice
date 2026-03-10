import 'package:flutter/material.dart';
import 'product_details.dart'; // 👈 ১. নতুন পেজটা ইমপোর্ট করলাম

class EcommerceHome extends StatelessWidget {
  const EcommerceHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daraz Clone", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 🚀 ক্লিক করলেই প্রোডাক্ট ডিটেইলস পেজে আসল নাম আর দাম নিয়ে যাবে!
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(
                    productName: "Smart Watches $index",
                    productPrice: "\$99",
                    productIcon: Icons.watch,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        "https://picsum.photos/200",
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Smart Watches $index",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "\$99.00",
                          style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 14),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ); // <- GridView শেষ
  } // <- build ফাংশন শেষ
} // <- EcommerceHome ক্লাস শেষ