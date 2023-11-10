import 'package:flutter/material.dart';
import 'CoursesCreation.dart'; // Import the CoursesCreation class

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text('Courses'),
        // Remove the IconButton from the app bar
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the CoursesCreation screen when the text is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoursesCreation()),
                );
              },
              child: SizedBox(
                height: 74,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blue.shade800,
                  child: Center(
                    child: Text(
                      'Add Courses',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Add your other course-related content here
          ],
        ),
      ),
    );
  }
}

