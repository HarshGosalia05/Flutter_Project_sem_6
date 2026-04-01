import 'package:flutter/material.dart';
import 'package:gls_students/CoursesPage.dart';
import 'package:gls_students/CourseDetailPage.dart';
import 'package:gls_students/TestsPage.dart';
import 'package:gls_students/Resultpage.dart';
import 'package:gls_students/ProgressPage.dart';
import 'package:gls_students/ProfilePage.dart';

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
      ResultsPage(),
      ProgressPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FF), // 🔥 light background

      appBar: AppBar(
        title: Text("Gls Students Dashboard"),
        centerTitle: true,
        elevation: 3,
        backgroundColor: Color(0xFF4DA3FF), // 🔥 light blue
        foregroundColor: Colors.white,

        actions: _currentIndex == 0
            ? [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ]
            : null,
      ),

      // 🔥 Smooth Animation
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: _pages[_currentIndex],
      ),

      endDrawer: _currentIndex == 0
          ? Drawer(
              width: MediaQuery.of(context).size.width * 0.78,
              child: SafeArea(child: DashboardSidebar()),
            )
          : null,

      // 🔥 LIGHT BLUE BOTTOM BAR
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,

          selectedItemColor: Color(0xFF4DA3FF), // 🔥 blue highlight
          unselectedItemColor: Colors.grey,

          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,

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
    return Container(
      color: Color(0xFFF7F9FC), // soft background
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 PINNED
            sectionTitle("📌 Pinned Subjects"),

            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  courseCard(context, "MAD", Colors.deepPurple),
                  courseCard(context, "ML", Colors.teal),
                  courseCard(context, "CC", Colors.orange),
                ],
              ),
            ),

            // 🕒 RECENT
            sectionTitle("🕒 Recently Accessed"),

            listTile(context, "Blockchain"),
            listTile(context, "Cloud"),
            listTile(context, "Machine Learning"),

            // 📚 ALL COURSES
            sectionTitle("📚 All Courses"),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                courseCard(context, "MAD", Colors.deepPurple),
                courseCard(context, "ML", Colors.teal),
                courseCard(context, "CC", Colors.orange),
                courseCard(context, "Blockchain", Colors.blueGrey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  // 🔥 SECTION TITLE
  ////////////////////////////////////////////////////////////

  Widget sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  // 🔥 COURSE CARD (COLORFUL BUT BALANCED)
  ////////////////////////////////////////////////////////////

  Widget courseCard(BuildContext context, String title, Color color) {
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
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  // 🔥 LIST TILE (CLEAN LOOK)
  ////////////////////////////////////////////////////////////

  Widget listTile(BuildContext context, String title) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.book, color: Colors.black54),
        ),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
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
}

//////////////////////////////////////////////////////////////
// SIDEBAR
//////////////////////////////////////////////////////////////

// class DashboardSidebar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[200],
//       child: ListView(
//         padding: EdgeInsets.only(bottom: 12),
//         children: [
//           sidebarCard("📅 Timeline", ["Assignment Due", "Lecture Today"]),
//           sidebarCard("📁 Private Files", ["Notes.pdf", "Lab.doc"]),
//           sidebarCard("⏰ Events", ["Quiz Tomorrow", "Submission"]),
//         ],
//       ),
//     );
//   }

//   Widget sidebarCard(String title, List<String> items) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ...items.map((e) {
//             return ListTile(
//               dense: true,
//               title: Text(e, maxLines: 1, overflow: TextOverflow.ellipsis),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }
// }
class DashboardSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF7F9FC),
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          // 👤 PROFILE
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text("Harsh"),
              subtitle: Text("Student"),
            ),
          ),

          SizedBox(height: 10),

          // 📊 QUICK STATS
          Card(
            child: Column(
              children: [
                ListTile(title: Text("📊 Your Stats")),
                ListTile(title: Text("Courses: 5")),
                ListTile(title: Text("Tests Given: 3")),
                ListTile(title: Text("Avg Score: 80%")),
              ],
            ),
          ),

          SizedBox(height: 10),

          // ⚡ QUICK ACTIONS
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProfilePage()),
                    );
                  },
                ),

                ListTile(
                  leading: Icon(Icons.folder),
                  title: Text("My Files"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FilesPage()),
                    );
                  },
                ),

                ListTile(
                  leading: Icon(Icons.event),
                  title: Text("Events"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EventsPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilesPage extends StatefulWidget {
  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  List<String> files = ["Notes.pdf", "Assignment.doc"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Files")),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text(files[index]),
          );
        },
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  final List<String> events = [
    "Quiz Tomorrow",
    "Assignment Submission",
    "Lecture at 10 AM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Events")),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.event),
              title: Text(events[index]),
            ),
          );
        },
      ),
    );
  }
}
