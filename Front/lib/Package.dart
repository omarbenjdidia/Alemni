import 'package:flutter/material.dart';

import 'CoursesCreation.dart';

class Package extends StatelessWidget {
  final List<CourseDetails> courseList;

  Package(this.courseList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text('Package'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Courses in the Package:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            if (courseList.isNotEmpty)
              Column(
                children: courseList.map((course) {
                  return buildCourseCard(course);
                }).toList(),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement your logic for making a package with selected courses
              },
              child: Text(
                'Create Package',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade800,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseCard(CourseDetails course) {
    return Card(
      margin: EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (course.image != null)
              Image.file(
                course.image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 10),
            Text(
              'Course Details:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Title: ${course.title}', style: TextStyle(fontSize: 16)),
            Text('Description: ${course.description}', style: TextStyle(fontSize: 16)),
            Text('Price: ${course.price}', style: TextStyle(fontSize: 16)),
            Text('Estimated Course Time: ${course.time} hours', style: TextStyle(fontSize: 16)),
            if (course.pdfFile.path.isNotEmpty)
              Text('Selected PDF: ${course.pdfFile.path}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
