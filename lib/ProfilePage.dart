import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gls_students/EditProfilePage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 🔥 DYNAMIC DATA
  String name = "Harsh";
  String course = "B.Tech AIML";
  String email = "harsh@gmail.com";
  String university = "GLS University";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // 🔥 LOAD USER DATA
  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "Harsh";
      email = prefs.getString('email') ?? "harsh@gmail.com";
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

                if (!context.mounted) return;

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
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF4DA3FF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔥 TOP HEADER
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 25),
              decoration: BoxDecoration(
                color: Color(0xFF4DA3FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 45, color: Colors.blue),
                  ),

                  SizedBox(height: 10),

                  Text(
                    name.isEmpty ? "User" : name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Text(course, style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            SizedBox(height: 15),

            // 🔥 INFO CARD
            Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.blue),
                    title: Text(email.isEmpty ? "No email found" : email),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.school, color: Colors.orange),
                    title: Text(university),
                  ),
                ],
              ),
            ),

            // 🔥 STATS
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  statCard("Courses", "5"),
                  statCard("Tests", "3"),
                  statCard("Score", "80%"),
                ],
              ),
            ),

            // 🔥 BUTTONS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  // ✅ EDIT PROFILE
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4DA3FF),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.edit),
                    label: Text("Edit Profile"),

                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditProfilePage()),
                      );

                      if (result != null) {
                        setState(() {
                          name = result["name"] ?? name;
                          course = result["course"] ?? course;
                          email = result["email"] ?? email;
                          university = result["university"] ?? university;
                        });
                      }
                    },
                  ),

                  SizedBox(height: 10),

                  // LOGOUT
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.logout, color: Colors.red),
                    label: Text("Logout", style: TextStyle(color: Colors.red)),
                    onPressed: logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  ////////////////////////////////////////////////////////////
  // 🔥 STAT CARD
  ////////////////////////////////////////////////////////////

  Widget statCard(String title, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(title, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
