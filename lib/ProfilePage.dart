import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFF4DA3FF),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.person, size: 45, color: Colors.blue),
          ),

          SizedBox(height: 10),

          Text(
            "Harsh",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Text("B.Tech AIML", style: TextStyle(color: Colors.grey)),

          SizedBox(height: 20),

          Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text("harsh@gmail.com"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text("GLS University"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
