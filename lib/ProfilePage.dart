import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // 🔥 LOAD USER DATA
  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "";
      email = prefs.getString('email') ?? "";
    });
  }

  // 🔥 LOGOUT WITH CONFIRMATION
  void logout() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

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

          // 🔥 SAFE NAME (no blank issue)
          Text(
            name.isEmpty ? "User" : name,
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

                  // 🔥 SAFE EMAIL
                  title: Text(
                    email.isEmpty ? "No email found" : email,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text("GLS University"),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // 🔥 LOGOUT BUTTON (same UI)
          ElevatedButton(
            onPressed: logout,
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}