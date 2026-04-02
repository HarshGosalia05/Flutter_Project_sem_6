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
      backgroundColor: Color(0xFFF6F7FB),

      appBar: AppBar(
        title: Text("Tests"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 58, 139, 183),
        icon: Icon(Icons.add),
        label: Text("Create Test"),
        onPressed: addTestDialog,
      ),

      body: Column(
        children: [
          SizedBox(height: 10),

          // 📊 HEADER
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 58, 114, 183).withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(Icons.quiz, color: const Color.fromARGB(255, 58, 85, 183)),
                SizedBox(width: 10),
                Text(
                  "Your Tests",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // 📋 TEST LIST
          Expanded(
            child: tests.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.quiz_outlined, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("No tests created"),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: tests.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          // 🔥 LEFT ICON
                          leading: CircleAvatar(
                            backgroundColor: const Color.fromARGB(
                              255,
                              80,
                              171,
                              223,
                            ).withOpacity(0.15),
                            child: Icon(
                              Icons.quiz,
                              color: const Color.fromARGB(255, 58, 139, 183),
                            ),
                          ),

                          // 📝 TITLE
                          title: Text(
                            tests[index]["name"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          subtitle: Text(
                            "${tests[index]["questions"].length} Questions",
                          ),

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

                          // 👉 ACTION BUTTONS
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ➕ ADD MCQ
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  addQuestionDialog(index);
                                },
                              ),

                              // ❌ DELETE
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
