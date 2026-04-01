
import 'package:flutter/material.dart';
import 'data.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: results.isEmpty
          ? Center(child: Text("No results yet"))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var r = results[index];

                return Card(
                  child: ListTile(
                    title: Text("Score: ${r["score"]}/${r["total"]}"),
                    subtitle: Text(r["testName"]),
                  ),
                );
              },
            ),
    );
  }
}