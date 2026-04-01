import 'package:flutter/material.dart';
import 'package:gls_students/CoursesPage.dart';
import 'package:gls_students/CourseDetailPage.dart';
// import 'package:gls_students/QuizPage.dart';
import 'package:gls_students/TestsPage.dart';
import 'package:gls_students/Resultpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardPage(),
      CoursesPage(),
      TestsPage(),
      // ResultsPage(),
      Center(child: Text("Progress Page")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gls Students Dashboard")),
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Courses",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "Tests"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Results",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Progress",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// DASHBOARD PAGE
//////////////////////////////////////////////////////////////

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // LEFT SIDE
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PINNED SUBJECTS
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "📌 Pinned Subjects",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      courseCard(context, "MAD"),
                      courseCard(context, "ML"),
                      courseCard(context, "CC"),
                    ],
                  ),
                ),

                // RECENTLY ACCESSED
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "🕒 Recently Accessed",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    listTile(context, "Blockchain"),
                    listTile(context, "Cloud"),
                    listTile(context, "Machine Learning"),
                  ],
                ),

                // ALL COURSES
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "📚 All Courses",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    courseCard(context, "MAD"),
                    courseCard(context, "ML"),
                    courseCard(context, "CC"),
                    courseCard(context, "Blockchain"),
                  ],
                ),
              ],
            ),
          ),
        ),

        // RIGHT SIDEBAR
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                sidebarCard("📅 Timeline", ["Assignment Due", "Lecture Today"]),
                sidebarCard("📁 Private Files", ["Notes.pdf", "Lab.doc"]),
                sidebarCard("⏰ Events", ["Quiz Tomorrow", "Submission"]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ////////////////////////////////////////////////////////////
  // WIDGETS
  ////////////////////////////////////////////////////////////

  Widget courseCard(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(courseName: title),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.all(8),
        child: Card(child: Center(child: Text(title))),
      ),
    );
  }

  Widget listTile(BuildContext context, String title) {
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailPage(courseName: title),
            ),
          );
        },
      ),
    );
  }

  Widget sidebarCard(String title, List<String> items) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ...items.map((e) => ListTile(title: Text(e))).toList(),
        ],
      ),
    );
  }
}
