import 'package:e_learning/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'Courses.dart';

class CoursesCreationDocks extends StatefulWidget {
  @override
  _CoursesCreationDocksState createState() => _CoursesCreationDocksState();
}

class _CoursesCreationDocksState extends State<CoursesCreationDocks> {
  late String _pdfPath = ''; // Initialize _pdfPath

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfPath = result.files.single.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text('Courses Creation Docks'),
        automaticallyImplyLeading: false, // Disable the back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickPDF,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: Colors.blue.shade800,
              ),
              child: Text(
                'Select PDF for Course',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            if (_pdfPath.isNotEmpty)
              Text(
                'Selected PDF Path: $_pdfPath',
                style: TextStyle(fontSize: 16),
              ),
            // Add other UI elements or content as needed
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to the previous screen when Cancel is pressed
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
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to the Courses screen when Finish is pressed
                  Navigator.popUntil(context, ModalRoute.withName('/')); // Pop until reaching the root route
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: Colors.blue.shade800,
                ),
                child: Text(
                  'Finish',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
