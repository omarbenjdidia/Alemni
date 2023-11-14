import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CoursesCreation.dart';

class Package extends StatefulWidget {
  const Package({Key? key}) : super(key: key);

  @override
  PackageState createState() => PackageState();
}

class PackageState extends State<Package> {
  List<CourseDetails> _courseList = [];
  Set<int> selectedIndices = Set<int>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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

  bool isButtonBlue() {
    return selectedIndices.isNotEmpty;
  }

  bool isButtonClickable() {
    return isButtonBlue();
  }

  Future<void> addPackages() async {
    try {
      List<String> selectedProductIds = [];
      for (int index in selectedIndices) {
        selectedProductIds.add(_courseList[index].productId!);
      }

      Map<String, dynamic> requestBody = {
        "title": titleController.text,
        "description": descriptionController.text,
        "products": selectedProductIds,
      };

      var response = await http.post(
        Uri.parse('http://192.168.139.77:3000/package/addpackage'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Package added successfully.');
        // Clear the text fields and selected indices after adding the package
        titleController.clear();
        descriptionController.clear();
        selectedIndices.clear();
        fetchCourses(); // Refresh the course list
      } else {
        print('Failed to add package. Status code: ${response.statusCode}');
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
        title: Text('Packages'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isButtonClickable() ? addPackages : null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Add Packages',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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
                  return buildCourseCard(_courseList[index], index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCourseCard(CourseDetails course, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedIndices.contains(index)) {
            selectedIndices.remove(index);
          } else {
            selectedIndices.add(index);
          }
        });
      },
      child: Card(
        margin: EdgeInsets.only(top: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: selectedIndices.contains(index) ? 10 : 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (course.image != null)
                Image.file(
                  course.image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Course Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selectedIndices.contains(index)
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      : SizedBox(),
                ],
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
