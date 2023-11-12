import 'package:flutter/material.dart';
import 'CoursesCreation.dart'; // Import the CoursesCreation class

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
      body: Container(
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Package(_courseList)),
                );
              },
              child: Text(
                'Make Package',
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
            SizedBox(height: 20),
            if (_courseList.isNotEmpty)
              Column(
                children: _courseList.map((course) {
                  return buildCourseCard(course);
                }).toList(),
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

class Package extends StatefulWidget {
  final List<CourseDetails> courseList;

  Package(this.courseList);

  @override
  _PackageState createState() => _PackageState();
}

class _PackageState extends State<Package> {
  late List<bool> selectedCourses;

  @override
  void initState() {
    super.initState();
    // Initialize the selectedCourses list with false values for each course
    selectedCourses = List<bool>.filled(widget.courseList.length, false);
  }

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
            if (widget.courseList.isNotEmpty)
              Column(
                children: List.generate(widget.courseList.length, (index) {
                  return buildCourseCard(widget.courseList[index], index);
                }),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement your logic for making a package with selected courses
                List<CourseDetails> selectedCoursesList = [];

                for (int i = 0; i < widget.courseList.length; i++) {
                  if (selectedCourses[i]) {
                    selectedCoursesList.add(widget.courseList[i]);
                  }
                }

                // Now selectedCoursesList contains the selected courses
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

  Widget buildCourseCard(CourseDetails course, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCourses[index] = !selectedCourses[index];
        });
      },
      child: Card(
        margin: EdgeInsets.only(top: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: selectedCourses[index] ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
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
      ),
    );
  }
}
