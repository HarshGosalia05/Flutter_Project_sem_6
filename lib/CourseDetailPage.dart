import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseName;

  CourseDetailPage({required this.courseName});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  List<PlatformFile> files = [];

  // 📂 PICK FILE
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        files.add(result.files.first);
      });
    }
  }

  // 📖 OPEN FILE
  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.courseName)),
      body: Column(
        children: [
          // 🔘 Upload Button
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: pickFile,
              child: Text("Upload File"),
            ),
          ),

          // 📄 File List
          Expanded(
            child: files.isEmpty
                ? Center(child: Text("No files uploaded"))
                : ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.insert_drive_file),
                          title: Text(files[index].name),

                          onTap: () {
                            openFile(files[index]);
                          },
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
