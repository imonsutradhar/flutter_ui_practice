import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 ম্যাজিক শুরু: Center এর বদলে Scaffold নিয়ে আসলাম
    return Scaffold(

      // প্রোফাইল পেজের নিজস্ব ছাদ বা AppBar
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent, // তোমার পছন্দমতো কালার দিতে পারো
        centerTitle: true,
        elevation: 0, // AppBar এর নিচের শ্যাডো সরানোর জন্য
      ),

      // তোমার বানানো সেই আগের ডিজাইনটা এখন Scaffold এর body-র ভেতরে!
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage("https://picsum.photos/200"),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 24),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              "Flutter Ninjaaaaa",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            const Text(
              "ninja@email.com",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
              ),
              child: const Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}