import 'package:flutter/material.dart';
import 'CoursesCreation.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<CourseDetails> _courseList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text('Courses'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () async {
                  CourseDetails? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoursesCreation()),
                  );

                  if (result != null) {
                    setState(() {
                      _courseList.add(result);
                    });
                  }
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
              
              
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _courseList.length,
                itemBuilder: (context, index) {
                  return buildCourseCard(_courseList[index]);
                },
              ),
            ],
          ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _courseList.remove(course);
                    });
                  },
                ),
              ],
            ),
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

