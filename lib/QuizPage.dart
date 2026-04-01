import 'package:flutter/material.dart';
import 'data.dart';

class QuizPage extends StatefulWidget {
  final List questions;

  QuizPage({required this.questions});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map<int, String> selectedAnswers = {};
  int score = 0;

  // ✅ SUBMIT QUIZ
  void submitQuiz() {
    score = 0;

    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedAnswers[i] == widget.questions[i]["answer"]) {
        score++;
      }
    }

    // 🔥 SAVE RESULT
    results.add({
      "testName": "Test ${DateTime.now().toString()}",
      "score": score,
      "total": widget.questions.length,
    });

    // ✅ SHOW RESULT
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text("Score: $score / ${widget.questions.length}"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),

      // 🔥 MAIN BODY
      body: widget.questions.isEmpty
          ? Center(child: Text("No questions added"))
          : ListView.builder(
              itemCount: widget.questions.length,
              itemBuilder: (context, index) {
                var q = widget.questions[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Q${index + 1}. ${q["question"]}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // OPTIONS
                      ...q["options"].map<Widget>((option) {
                        return RadioListTile(
                          title: Text(option),
                          value: option,
                          groupValue: selectedAnswers[index],
                          onChanged: (value) {
                            setState(() {
                              selectedAnswers[index] = value.toString();
                            });
                          },
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            ),

      // 🔥 FIXED SUBMIT BUTTON (ALWAYS VISIBLE)
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: submitQuiz,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
          ),
          child: Text("Submit Test"),
        ),
      ),
    );
  }
}