import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'CoursesCreationDocks.dart';

class CoursesCreation extends StatefulWidget {
  @override
  _CoursesCreationState createState() => _CoursesCreationState();
}

class _CoursesCreationState extends State<CoursesCreation> {
  double fontSize = 16.0;

  late TextEditingController _titleController;
  late TextEditingController _timeController;

  late ImagePicker _imagePicker;
  File? _image;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _timeController = TextEditingController();
    _imagePicker = ImagePicker();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _getImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _validateAndProceed() {
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
        // Proceed to the next interface (CoursesCreationDocks)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoursesCreationDocks()),
        );
      }
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the course title';
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
                  // Navigate back to the Courses screen when Cancel is pressed
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
