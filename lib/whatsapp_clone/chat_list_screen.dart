import 'package:flutter/material.dart';
import 'chat_tile.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp",
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context,index) {
          return  ChatTile(
            name: "user number $index",
            message: "New message from  user $index",
          );
        },
      ),
    );
  }
}
