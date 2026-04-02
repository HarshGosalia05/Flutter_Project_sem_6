import 'package:flutter/material.dart';
import 'data.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC),

      appBar: AppBar(
        title: Text("Results"),
        centerTitle: true,
        backgroundColor: Color(0xFF4DA3FF),

        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {
              setState(() {
                results.clear();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("All results cleared")),
              );
            },
          ),
        ],
      ),

      body: results.isEmpty
          ? Center(
              child: Text(
                "No results yet",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var r = results[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      child: Icon(Icons.bar_chart, color: Colors.blue),
                    ),

                    title: Text(
                      "Score: ${r["score"]}/${r["total"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(r["testName"]),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // 👁 VIEW
                        IconButton(
                          icon: Icon(Icons.visibility, color: Colors.green),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Result"),
                                content: Text(
                                  "You scored ${r["score"]} out of ${r["total"]}",
                                ),
                              ),
                            );
                          },
                        ),

                        // ❌ DELETE
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              results.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}