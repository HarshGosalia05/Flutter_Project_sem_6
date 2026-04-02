import 'package:flutter/material.dart';

class FilesPage extends StatefulWidget {
  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  List<String> files = ["Notes.pdf", "Assignment.doc"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC),

      appBar: AppBar(
        title: Text("My Files"),
        backgroundColor: Color(0xFF4DA3FF),
      ),

      body: files.isEmpty
          ? Center(child: Text("No files available"))
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      child: Icon(Icons.insert_drive_file, color: Colors.blue),
                    ),

                    title: Text(
                      files[index],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    subtitle: Text("Tap to open"),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 👁 OPEN
                        IconButton(
                          icon: Icon(Icons.open_in_new, color: Colors.green),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Opening ${files[index]}"),
                              ),
                            );
                          },
                        ),

                        // ❌ DELETE
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

      // ➕ ADD FILE BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4DA3FF),
        child: Icon(Icons.add),
        onPressed: () {
          addFileDialog();
        },
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  // ➕ ADD FILE DIALOG
  ////////////////////////////////////////////////////////////

  void addFileDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add File"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter file name"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  files.add(controller.text);
                });
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
