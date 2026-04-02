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
      backgroundColor: Color(0xFFF6F7FB),

      appBar: AppBar(
        title: Text("Progress"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      body: results.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No progress yet"),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  // 📊 STATS
                  Row(
                    children: [
                      statCard("Tests", "$totalTests"),
                      statCard("Score", "$totalScore/$totalQuestions"),
                      statCard("Overall", "${percentage.toStringAsFixed(1)}%"),
                    ],
                  ),

                  SizedBox(height: 20),

                  // 📈 GRAPH
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Performance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        SizedBox(
                          height: 250,
                          child: LineChart(
                            LineChartData(
                              minY: 0,
                              maxY: 100,

                              gridData: FlGridData(show: true),

                              borderData: FlBorderData(show: false),

                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true),
                                ),
                              ),

                              lineBarsData: [
                                LineChartBarData(
                                  spots: spots,
                                  isCurved: true,
                                  color: Colors.teal, // 🔥 soft color
                                  barWidth: 3,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.teal.withOpacity(0.15),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
  // 🔥 CLEAN STAT CARD
  ////////////////////////////////////////////////////////////

  Widget statCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(title, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
