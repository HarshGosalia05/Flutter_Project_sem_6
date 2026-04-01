import 'package:flutter/material.dart';
import 'QuizPage.dart';

class TestsPage extends StatefulWidget {
  @override
  _TestsPageState createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  // List<String> tests = [];
  List<Map<String, dynamic>> tests = [];
  // ➕ ADD TEST DIALOG
  void addQuestionDialog(int testIndex) {
    TextEditingController questionController = TextEditingController();
    TextEditingController op1 = TextEditingController();
    TextEditingController op2 = TextEditingController();
    TextEditingController op3 = TextEditingController();

    String correctAnswer = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add MCQ"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: questionController,
                  decoration: InputDecoration(hintText: "Enter Question"),
                ),

                TextField(
                  controller: op1,
                  decoration: InputDecoration(hintText: "Option 1"),
                ),

                TextField(
                  controller: op2,
                  decoration: InputDecoration(hintText: "Option 2"),
                ),

                TextField(
                  controller: op3,
                  decoration: InputDecoration(hintText: "Option 3"),
                ),

                SizedBox(height: 10),

                // ✅ FIXED DROPDOWN
                DropdownButtonFormField<String>(
                  hint: Text("Select Correct Answer"),
                  items: [
                    DropdownMenuItem(value: "1", child: Text("Option 1")),
                    DropdownMenuItem(value: "2", child: Text("Option 2")),
                    DropdownMenuItem(value: "3", child: Text("Option 3")),
                  ],
                  onChanged: (value) {
                    if (value == "1") correctAnswer = op1.text;
                    if (value == "2") correctAnswer = op2.text;
                    if (value == "3") correctAnswer = op3.text;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tests[testIndex]["questions"].add({
                    "question": questionController.text,
                    "options": [op1.text, op2.text, op3.text],
                    "answer": correctAnswer,
                  });
                });

                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void addTestDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create Test"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter test name"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tests.add({"name": controller.text, "questions": []});
                });
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // ❌ DELETE TEST
  void deleteTest(int index) {
    setState(() {
      tests.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tests")),

      body: Column(
        children: [
          // ➕ GENERATE TEST BUTTON
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: addTestDialog,
              child: Text("Generate Test"),
            ),
          ),

          // 📋 TEST LIST
          Expanded(
            child: tests.isEmpty
                ? Center(child: Text("No tests created"))
                : ListView.builder(
                    itemCount: tests.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(tests[index]["name"]),

                          // 👉 OPEN QUIZ
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizPage(
                                  questions: tests[index]["questions"],
                                ),
                              ),
                            );
                          },

                          // 👉 RIGHT SIDE BUTTONS
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ➕ ADD MCQ
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.green),
                                onPressed: () {
                                  addQuestionDialog(index);
                                },
                              ),

                              // ❌ DELETE TEST
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    tests.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
