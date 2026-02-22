import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  //const ChatTile({super.key});
  final String name;
  final String message;

  const ChatTile({
    super.key,
    required this.name,
    required this.message
});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(15.0), // 👈 একটু বেশি প্যাডিং দিলাম সুন্দর দেখার জন্য
          child: Row(
            children: [
              const CircleAvatar(
                radius: 27,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 15),

              Column(
                mainAxisSize: MainAxisSize.min, // 👈 ২. ম্যাজিক লাইন! কলামকে আর লম্বা হতে দেবে না
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  SizedBox(height: 5),
                  Text(message),
                ],
              ),

              const Spacer(), // 👈 ৩. মাঝখানের ফাঁকা জায়গা দখল করে সময়টাকে ডানে ঠেলে দেবে

              const Text("10:30 AM", style: TextStyle(color: Colors.black)), // 👈 একদম ডানে বসবে
            ],
          ),
    );
  }
}