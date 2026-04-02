import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<String> events = [
    "Quiz Tomorrow",
    "Assignment Submission",
    "Lecture at 10 AM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC),

      appBar: AppBar(title: Text("Events"), backgroundColor: Color(0xFF4DA3FF)),

      body: events.isEmpty
          ? Center(child: Text("No events available"))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange[50],
                      child: Icon(Icons.event, color: Colors.orange),
                    ),

                    title: Text(
                      events[index],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    subtitle: Text("Upcoming Event"),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 👁 VIEW
                        IconButton(
                          icon: Icon(Icons.visibility, color: Colors.green),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Viewing ${events[index]}"),
                              ),
                            );
                          },
                        ),

                        // ❌ DELETE
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              events.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // ➕ ADD EVENT BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4DA3FF),
        child: Icon(Icons.add),
        onPressed: () {
          addEventDialog();
        },
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  // ➕ ADD EVENT DIALOG
  ////////////////////////////////////////////////////////////

  void addEventDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Event"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter event name"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  events.add(controller.text);
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
