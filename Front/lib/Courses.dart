import 'dart:io';

import 'package:flutter/material.dart';
import 'CoursesCreation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  CoursesState createState() => CoursesState();
}

class CoursesState extends State<Courses> {
  List<CourseDetails> _courseList = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      var response = await http.get(Uri.parse('http://192.168.139.77:3000/product/getproduct/'));

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');

        var data = jsonDecode(response.body);

        if (data.containsKey('products') && data['products'] is List) {
          List<dynamic> coursesData = data['products'];
          setState(() {
            _courseList = coursesData.map((courseData) => CourseDetails.fromJson(courseData)).toList();
          });
        } else {
          print('Invalid response format. Expected a List under the key "products".');
        }
      } else {
        print('Failed to fetch courses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

   Future<void> deleteCourses(String productId) async {
  try {
    var response = await http.delete(Uri.parse('http://192.168.139.77:3000/product/deleteproduct/$productId'));

    if (response.statusCode == 200) {
      print('Product deleted successfully.');
      fetchCourses();
    } else {
      print('Failed to delete product. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}




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
                  showDeleteConfirmationDialog(course.productId!);
                },
              ),
            ],
          ),
          if (course.image != null)
            Image.file(
              course.image!,
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
          Text('Title: ${course.title ?? ''}', style: TextStyle(fontSize: 16)),
          Text('Description: ${course.description ?? ''}', style: TextStyle(fontSize: 16)),
          Text('Price: ${course.price ?? 0}', style: TextStyle(fontSize: 16)),
          Text('Estimated Course Time: ${course.time ?? 0} hours', style: TextStyle(fontSize: 16)),
          if (course.pdfFile?.path?.isNotEmpty == true)
            Text('Selected PDF: ${course.pdfFile!.path}', style: TextStyle(fontSize: 16)),
        ],
      ),
    ),
  );
}

void showDeleteConfirmationDialog(String productId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Course"),
        content: Text("Are you sure you want to delete this course?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              deleteCourses(productId);
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Delete"),
          ),
        ],
      );
    },
  );
}

}
class CourseDetails {
  final String? productId; // Add this property
  final String? title;
  final String? description;
  final double? price;
  final int? time;
  final File? image;
  final File? pdfFile;

  CourseDetails({
    this.productId, // Include this in the constructor
    this.title,
    this.description,
    this.price,
    this.time,
    this.image,
    this.pdfFile,
  });

    factory CourseDetails.fromJson(Map<String, dynamic> json) {
    return CourseDetails(
      productId: json['_id'], // Assuming your product ID key is '_id'
      title: json['title'],
      description: json['description'],
      price: json['pricing'] is int ? json['pricing'].toDouble() : double.tryParse(json['pricing']),
      time: json['duration'] is int ? json['duration'] : int.tryParse(json['duration']),
      image: json['image'] != null ? File(json['image']['contentType']) : null,
      pdfFile: json['pdfFile'] != null ? File(json['pdfFile']['contentType']) : null,
    );
  }
}

  

