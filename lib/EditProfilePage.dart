import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController(text: "Harsh");
  TextEditingController courseController = TextEditingController(
    text: "B.Tech AIML",
  );
  TextEditingController emailController = TextEditingController(
    text: "harsh@gmail.com",
  );
  TextEditingController universityController = TextEditingController(
    text: "GLS University",
  );

  void saveProfile() {
    Navigator.pop(context, {
      "name": nameController.text,
      "course": courseController.text,
      "email": emailController.text,
      "university": universityController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Color(0xFF4DA3FF),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: courseController,
              decoration: InputDecoration(labelText: "Course"),
            ),

            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: universityController,
              decoration: InputDecoration(labelText: "University"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4DA3FF),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: saveProfile,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
