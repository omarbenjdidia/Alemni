import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

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

  Future<void> _getImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
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
      } else if (_pdfFile == null) {
        // Show error message if PDF is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a course PDF.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Pass the entered values back to the previous screen
        Navigator.pop(
          context,
          CourseDetails(
            title: _titleController.text,
            description: _descriptionController.text,
            price: _priceController.text,
            time: _timeController.text,
            image: _image!,
            pdfFile: _pdfFile,
          ),
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
