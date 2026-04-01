import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'data.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int totalTests = results.length;

    int totalScore = 0;
    int totalQuestions = 0;

    for (var r in results) {
      totalScore += (r["score"] ?? 0) as int;
      totalQuestions += (r["total"] ?? 0) as int;
    }

    double percentage =
        totalQuestions == 0 ? 0 : (totalScore / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(title: Text("Progress")),
      body: results.isEmpty
          ? Center(child: Text("No progress yet"))
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [

                  // 📊 BAR GRAPH
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: results.asMap().entries.map((entry) {
                          int index = entry.key;
                          var r = entry.value;

                          double percent =
                              (r["score"] / r["total"]) * 100;

                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: percent,
                                width: 15,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // 📋 TEXT INFO
                  Text("Tests Given: $totalTests",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),

                  Text("Total Score: $totalScore / $totalQuestions",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),

                  Text("Overall: ${percentage.toStringAsFixed(2)}%",
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
    );
  }
}