import 'package:flutter/material.dart';
import 'package:whatspp/dashboard/profile_screen.dart';
import '../daraz_clone/ecommerce_home.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex=0;

  final List<Widget> _pages= [
    const EcommerceHome(),
    const Center(child: Text("🛒 Cart Page", style: TextStyle(fontSize: 30))),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // ১. ফ্লাটারকে বলে দিলাম এখন কত নম্বর পেজ সিলেক্ট হয়ে আছে
        currentIndex: selectedIndex,

        // ২. ক্লিক করার লজিক (জাদুটা এখানেই!)
        onTap: (int value) {
          setState(() {
            selectedIndex = value;
            print("tap $selectedIndex");// আমরা যেই বাটনে ক্লিক করেছি, তার নম্বরটা মেমোরিতে সেভ করলাম
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
