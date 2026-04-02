import 'package:flutter/material.dart';
import 'CourseDetailPage.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  List<String> allCourses = [
    "Mobile App Development",
    "Machine Learning",
    "Cloud Computing",
    "Blockchain Technology",
    "Data Science",
    "Artificial Intelligence",
  ];

  List<String> filteredCourses = [];

  @override
  void initState() {
    super.initState();
    filteredCourses = allCourses;
  }

  // 🔍 SEARCH
  void searchCourses(String query) {
    setState(() {
      filteredCourses = allCourses
          .where((course) => course.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC),

      appBar: AppBar(
        title: Text("Courses"),
        centerTitle: true,
        backgroundColor: Color(0xFF4DA3FF),
      ),

      body: Column(
        children: [
          // 🔍 SEARCH BAR (UPGRADED)
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: searchCourses,
              decoration: InputDecoration(
                hintText: "Search Courses...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📚 GRID
          Expanded(
            child: filteredCourses.isEmpty
                ? Center(child: Text("No courses found"))
                : GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: filteredCourses.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      return courseCard(context, filteredCourses[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  // 🔥 PREMIUM CARD
  ////////////////////////////////////////////////////////////

  Widget courseCard(BuildContext context, String title, int index) {
    List<Color> colors = [
      Colors.deepPurple,
      Colors.teal,
      Colors.orange,
      Colors.blueGrey,
      Colors.indigo,
      Colors.green,
    ];

    Color color = colors[index % colors.length];

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CourseDetailPage(courseName: title, color: color),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.15), Colors.white],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu_book, color: color, size: 35),

              SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
