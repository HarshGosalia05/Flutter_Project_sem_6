import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'data.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int totalTests = results.length;

    int totalScore = 0;
    int totalQuestions = 0;

    List<FlSpot> spots = [];

    for (int i = 0; i < results.length; i++) {
      var r = results[i];

      int score = (r["score"] ?? 0);
      int total = (r["total"] ?? 1);

      double percent = (score / total) * 100;

      spots.add(FlSpot(i.toDouble(), percent));

      totalScore += score;
      totalQuestions += total;
    }

    double percentage = totalQuestions == 0
        ? 0
        : (totalScore / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(title: Text("Progress")),
      body: results.isEmpty
          ? Center(child: Text("No progress yet"))
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // 📈 LINE GRAPH
                  SizedBox(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        minY: 0,
                        maxY: 100,

                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                        ),

                        borderData: FlBorderData(show: true),

                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // 📋 TEXT INFO
                  Text(
                    "Tests Given: $totalTests",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Total Score: $totalScore / $totalQuestions",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Overall: ${percentage.toStringAsFixed(2)}%",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
    );
  }
}
