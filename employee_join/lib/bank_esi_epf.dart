import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BankEsiEpfPage extends StatefulWidget {
  const BankEsiEpfPage({Key? key}) : super(key: key);

  @override
  State<BankEsiEpfPage> createState() => _BankEsiEpfPageState();
}

class _BankEsiEpfPageState extends State<BankEsiEpfPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _bankFile;
  XFile? _nomineePhoto;
  XFile? _nomineeBankFile;
  XFile? _nomineeAadharFile;

  final ImagePicker _picker = ImagePicker();
  bool _isChecked = false; // To track the state of the checkbox

  Future<void> _pickFile(String fileType) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (fileType == 'bank') {
        _bankFile = pickedFile;
      } else if (fileType == 'nomineePhoto') {
        _nomineePhoto = pickedFile;
      } else if (fileType == 'nomineeBank') {
        _nomineeBankFile = pickedFile;
      } else if (fileType == 'nomineeAadhar') {
        _nomineeAadharFile = pickedFile;
      }
    });
  }

  void _showDeclarationDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth > 600 ? 18.0 : 16.0;
    final dialogWidth = screenWidth > 600 ? 400.0 : screenWidth * 0.8;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Declaration',
            style: TextStyle(fontSize: fontSize),
          ),
          content: Container(
            width: dialogWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'I hereby declare that the facts mentioned above are correct to the best of my knowledge.',
                  style: TextStyle(fontSize: fontSize),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                        Navigator.of(context).pop(); // Close the dialog
                        _showDeclarationDialog(
                            context); // Reopen the dialog with the updated state
                      },
                    ),
                    Text(
                      'I agree',
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_isChecked) {
                  Navigator.of(context).pop(); // Close the dialog
                  if (_formKey.currentState!.validate() &&
                      _bankFile != null &&
                      _nomineePhoto != null &&
                      _nomineeBankFile != null &&
                      _nomineeAadharFile != null) {
                    _showCustomDialog(
                      context,
                      'Form submitted successfully!',
                      Icons.check_circle,
                      Colors.green,
                    );
                  } else {
                    _showCustomDialog(
                      context,
                      'Form submission failed. Please complete all required fields.',
                      Icons.error,
                      Colors.red,
                    );
                  }
                } else {
                  Navigator.of(context).pop(); // Close the dialog
                  _showCustomDialog(
                    context,
                    'You must agree to the declaration to submit the form.',
                    Icons.error,
                    Colors.red,
                  );
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without submission
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: fontSize),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCustomDialog(
      BuildContext context, String message, IconData icon, Color color) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth > 600 ? 18.0 : 16.0;
    final dialogWidth = screenWidth > 600 ? 400.0 : screenWidth * 0.8;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(icon, color: color, size: 30),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          content: Container(
            width: dialogWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: fontSize),
                  ),
                  style: ElevatedButton.styleFrom(
                      // Use the same color as the icon
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth > 600 ? 18.0 : 16.0;
    final padding = screenWidth > 600 ? 20.0 : 10.0;
    final appBarTitleSize = screenWidth > 600 ? 20.0 : 16.0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(60.0), // Adjusted height for better spacing
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 221, 223, 118),
                Color.fromARGB(255, 152, 23, 2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('logo.png', height: 40),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Employee Bank / ESIC & EPFO Details',
                    style: TextStyle(fontSize: appBarTitleSize),
                    overflow:
                        TextOverflow.ellipsis, // Ensure text does not overflow
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 204),
        padding: EdgeInsets.all(padding),
        child: Form(
          key: _formKey, // Add the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCard(
                        'Bank Details',
                        fontSize,
                        [
                          _buildTextFormField('Employee Bank Name', fontSize),
                          _buildTextFormField('Bank A/c No.', fontSize),
                          _buildTextFormField('IFSC Code', fontSize),
                          _buildTextFormField('Branch Code & Name', fontSize),
                          _buildTextFormField('PF UAN No.', fontSize),
                          _buildTextFormField('ESIC No.', fontSize),
                          _buildFileUploader('bank', fontSize),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildCard(
                        'Nominee Details',
                        fontSize,
                        [
                          _buildTextFormField('Nominee Name', fontSize),
                          _buildTextFormField('Relationship', fontSize),
                          _buildTextFormField('Contact No.', fontSize),
                          _buildTextFormField('Address', fontSize),
                          _buildTextFormField('PAN No.', fontSize),
                          _buildTextFormField('Nominee Bank Name', fontSize),
                          _buildTextFormField('Nominee Bank A/c No.', fontSize),
                          _buildTextFormField('IFSC Code', fontSize),
                          _buildTextFormField('Branch Code', fontSize),
                          _buildTextFormField('Nominee Aadhar No.', fontSize),
                          _buildFileUploader('nomineePhoto', fontSize),
                          _buildFileUploader('nomineeBank', fontSize),
                          _buildFileUploader('nomineeAadhar', fontSize),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Navigate back to the previous screen or section
                              Navigator.of(context).pop();
                              if (_formKey.currentState!.validate() &&
                                  _bankFile != null &&
                                  _nomineePhoto != null &&
                                  _nomineeBankFile != null &&
                                  _nomineeAadharFile != null) {}
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _bankFile != null &&
                                  _nomineePhoto != null &&
                                  _nomineeBankFile != null &&
                                  _nomineeAadharFile != null) {
                                _showCustomDialog(
                                  context,
                                  'Data saved successfully!',
                                  Icons.check_circle,
                                  Colors.green,
                                );
                              } else {
                                _showCustomDialog(
                                  context,
                                  'Please complete all required fields and upload all necessary files.',
                                  Icons.error,
                                  Colors.red,
                                );
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showDeclarationDialog(context);
                            },
                            child: Text(
                              'Proceed to Declaration',
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, double fontSize, List<Widget> children) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      color: Color.fromARGB(255, 255, 236, 179),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: fontSize),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildFileUploader(String fileType, double fontSize) {
    final String fileLabel;
    if (fileType == 'bank') {
      fileLabel = 'Upload Bank Document';
    } else if (fileType == 'nomineePhoto') {
      fileLabel = 'Upload Nominee Photo';
    } else if (fileType == 'nomineeBank') {
      fileLabel = 'Upload Nominee Bank Document';
    } else {
      fileLabel = 'Upload Nominee Aadhar Document';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fileLabel,
            style: TextStyle(fontSize: fontSize),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () => _pickFile(fileType),
            child: Text(
              'Choose File',
              style: TextStyle(fontSize: fontSize),
            ),
          ),
          if (fileType == 'bank' && _bankFile != null)
            _buildFileInfo(_bankFile!),
          if (fileType == 'nomineePhoto' && _nomineePhoto != null)
            _buildFileInfo(_nomineePhoto!),
          if (fileType == 'nomineeBank' && _nomineeBankFile != null)
            _buildFileInfo(_nomineeBankFile!),
          if (fileType == 'nomineeAadhar' && _nomineeAadharFile != null)
            _buildFileInfo(_nomineeAadharFile!),
        ],
      ),
    );
  }

  Widget _buildFileInfo(XFile file) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        file.name,
        style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
      ),
    );
  }
}
