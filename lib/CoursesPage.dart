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

  // 🔍 SEARCH FUNCTION
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
      appBar: AppBar(title: Text("Courses")),
      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: searchCourses, // 👈 IMPORTANT
              decoration: InputDecoration(
                hintText: "Search Courses...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // 📚 GRID
          Expanded(
            child: GridView.builder(
              itemCount: filteredCourses.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                return courseCard(context, filteredCourses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  Widget courseCard(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(courseName: title),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Center(child: Text(title)),
      ),
    );
  }
}
