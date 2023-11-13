import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class CoursesCreation extends StatefulWidget {
  @override
  _CoursesCreationState createState() => _CoursesCreationState();
}

class _CoursesCreationState extends State<CoursesCreation> {
  double fontSize = 16.0;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _timeController;

  late ImagePicker _imagePicker;
  File? _image;

  late File _pdfFile;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _timeController = TextEditingController();
    _imagePicker = ImagePicker();
    _formKey = GlobalKey<FormState>();
    _pdfFile = File(''); // Initialize with an empty file
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _timeController.dispose();
    super.dispose();
  }

void _getImage() async {
  final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    setState(() {
      _image = File(image.path);
    });
  }
}


  Future<void> _getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

void _validateAndProceed() async {
  try {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        // Show error message if image is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a course thumbnail.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Prepare data to be sent to the server
        Map<String, String?> reqBody = {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'pricing': _priceController.text,
          'duration': _timeController.text,
        };

        // Create a FormData object
        var formData = http.MultipartRequest(
          'POST',
          Uri.parse('http://192.168.1.16:3000/product/addproduct'),
        );

        // Add fields to the FormData
        reqBody.forEach((key, value) {
          formData.fields[key] = value!;
        });

       // Add image to the FormData
if (_image != null) {
  formData.files.add(await http.MultipartFile.fromPath(
    'image',
    _image!.path,
    filename: 'image.jpg',
     contentType: MediaType('image', 'jpeg'),
  ));
}

// Add PDF to the request if available
if (_pdfFile != null) {
  formData.files.add(await http.MultipartFile.fromPath(
    'pdf',
    _pdfFile!.path,
    filename: 'course.pdf',
    contentType: MediaType('application', 'pdf'),
  ));

}

       

        // Send the request
        var response = await formData.send();

        print('Server Response Code: ${response.statusCode}');
        print('Server Response Body: ${await response.stream.bytesToString()}');

        // Handle the response accordingly
        // ...

        // Ensure that the server response is successful before proceeding
        if (response.statusCode == 200) {
          // Success
          print('Request successful');
        } else {
          // Handle the error based on the server response
          print('Request failed');
        }
      }
    }
  } catch (e, stackTrace) {
    print('Error in _validateAndProceed: $e');
    print('StackTrace: $stackTrace');
    // Handle the error as needed
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text('Courses Creation'),
        automaticallyImplyLeading: false, // Disable the back arrow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                // Course Title
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Course Title',
                    hintText: 'Enter the course title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the course title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Course Description
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter the course description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the course description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Course Price
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Enter the course price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the course price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Estimated Course Time
                TextFormField(
                  controller: _timeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Estimated Course Time (hours)',
                    hintText: 'Enter estimated time for the course',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the estimated course time';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Course Thumbnail
                ElevatedButton(
                  onPressed: _getImage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    primary: Colors.blue.shade800,
                  ),
                  child: Text(
                    'Select Course Thumbnail',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                if (_image != null)
                  Image.file(
                    _image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 16),
                // Course PDF
                ElevatedButton(
                  onPressed: _getPdf,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    primary: Colors.blue.shade800,
                  ),
                  child: Text(
                    'Select Course PDF',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                if (_pdfFile.path.isNotEmpty)
                  Text(
                    'Selected PDF: ${_pdfFile.path}',
                    style: TextStyle(fontSize: fontSize),
                  ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to the previous screen
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: Colors.grey.shade400,
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: Colors.blue.shade800,
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseDetails {
  final String title;
  final String description;
  final String price;
  final String time;
  final File image;
  final File pdfFile;

  CourseDetails({
    required this.title,
    required this.description,
    required this.price,
    required this.time,
    required this.image,
    required this.pdfFile,
  });
}