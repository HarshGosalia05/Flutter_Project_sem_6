import 'package:flutter/material.dart';
import 'database_helper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void register() async {
    if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Fill all fields")));
      return;
    }

    await DatabaseHelper.instance.registerUser({
      "name": name.text,
      "email": email.text,
      "password": password.text,
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Registered Successfully")));

    Navigator.pop(context); // back to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: register,
              child: Text("Register"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Already have account? Login"),
            )
          ],
        ),
      ),
    );
  }
}