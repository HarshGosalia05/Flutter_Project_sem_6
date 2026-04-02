import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseName;
  final Color color;

  CourseDetailPage({required this.courseName, required this.color});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  List<PlatformFile> files = [];

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
    );

    if (result != null) {
      setState(() {
        files.add(result.files.first);
      });
    }
  }

  void openFile(PlatformFile file) {
    if (file.path != null) {
      OpenFile.open(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FB),

      appBar: AppBar(
        title: Text(widget.courseName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      // 🔥 COLOR BASED BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.color,
        child: Icon(Icons.upload),
        onPressed: pickFile,
      ),

      body: Column(
        children: [
          // 🔥 HEADER (COLOR BASED)
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: widget.color.withOpacity(0.2),
                  child: Icon(Icons.menu_book, color: widget.color),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.courseName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.color,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 📄 TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your Files",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SizedBox(height: 8),

          Expanded(
            child: files.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "No files uploaded",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: widget.color.withOpacity(0.15),
                            child: Icon(
                              Icons.insert_drive_file,
                              color: widget.color,
                            ),
                          ),

                          title: Text(files[index].name),

                          subtitle: Text("Tap to open"),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.open_in_new,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  openFile(files[index]);
                                },
                              ),

                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    files.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
