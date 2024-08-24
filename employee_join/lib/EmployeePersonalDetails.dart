import 'dart:io';
import 'package:employee_join/Familydetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeePersonalDetailsPage extends StatefulWidget {
  @override
  _EmployeePersonalDetailsPageState createState() =>
      _EmployeePersonalDetailsPageState();
}

class _EmployeePersonalDetailsPageState
    extends State<EmployeePersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _pvcIssueDateController = TextEditingController();
  final TextEditingController _pvcValidityDateController =
      TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _gasBillController = TextEditingController();
  final TextEditingController _electricityBillController =
      TextEditingController();
  final TextEditingController _draCertificateController =
      TextEditingController();
  final TextEditingController _pvcCertificateController =
      TextEditingController();

  final Map<String, bool> _checkboxValues = {
    'Male': false,
    'Female': false,
    'Other': false,
    'Single': false,
    'Married': false,
    'Other Marital Status': false,
  };

  String? _selectedNationality;
  final List<String> _nationalities = [
    'Indian',
    'Others',
  ];

  XFile? _panImage;
  XFile? _aadharImage;
  XFile? _gasBillImage;
  XFile? _electricityBillImage;
  XFile? _draCertificateImage;
  XFile? _pvcCertificateImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    double fontSize = isLargeScreen ? 18 : 16;
    double padding = isLargeScreen ? 20 : 10;
    double labelFontSize = isLargeScreen ? 16 : 14;
    double appBarTitleFontSize = isLargeScreen ? 20 : 16;
    EdgeInsetsGeometry fieldPadding = EdgeInsets.symmetric(vertical: 10);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
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
              children: [
                Image.asset('logo.png',
                    height: 40), // Ensure the path is correct
                SizedBox(width: 10),
                Text(
                  'Personal Details of the Employee',
                  style: TextStyle(fontSize: appBarTitleFontSize),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 228, 231, 175),
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildDropdownField('Nationality', labelFontSize),
                _buildTextFormField('Religion/Caste', labelFontSize, true,
                    fieldPadding: fieldPadding),
                _buildDateField('Date of Birth', labelFontSize, _dobController,
                    fieldPadding: fieldPadding),
                _buildTextFormField(
                    'Father’s/Husband’s Name', labelFontSize, true,
                    fieldPadding: fieldPadding),
                _buildCheckBoxField(
                    'Gender', ['Male', 'Female', 'Other'], labelFontSize,
                    fieldPadding: fieldPadding),
                _buildCheckBoxField(
                    'Marital Status', ['Single', 'Married'], labelFontSize,
                    fieldPadding: fieldPadding),
                _buildTextFormField('PAN Number', labelFontSize, true,
                    controller: _panController,
                    validator: _validatePAN,
                    fieldPadding: fieldPadding),
                _buildFileUploadField('Upload PAN Image', _panImage, 'PAN',
                    fieldPadding: fieldPadding),
                _buildTextFormField('Aadhar Number', labelFontSize, true,
                    controller: _aadharController,
                    validator: _validateAadhar,
                    fieldPadding: fieldPadding),
                _buildFileUploadField(
                    'Upload Aadhar Image', _aadharImage, 'Aadhar',
                    fieldPadding: fieldPadding),
                _buildTextFormField('Voter ID Number', labelFontSize, true,
                    fieldPadding: fieldPadding),
                _buildTextFormField(
                    'Ration Card ID Number', labelFontSize, false,
                    fieldPadding: fieldPadding),
                _buildTextFormField('Blood Group', labelFontSize, false,
                    fieldPadding: fieldPadding),
                _buildTextFormField('Gas Bill Number', labelFontSize, true,
                    controller: _gasBillController, fieldPadding: fieldPadding),
                _buildFileUploadField(
                    'Upload Gas Bill Image', _gasBillImage, 'Gas Bill',
                    fieldPadding: fieldPadding),
                _buildTextFormField(
                    'Electricity Bill Number', labelFontSize, true,
                    controller: _electricityBillController,
                    fieldPadding: fieldPadding),
                _buildFileUploadField('Upload Electricity Bill Image',
                    _electricityBillImage, 'Electricity Bill',
                    fieldPadding: fieldPadding),
                _buildTextFormField(
                    'Driving License Number', labelFontSize, false,
                    fieldPadding: fieldPadding),
                _buildTextFormField(
                    'Driving License Validity', labelFontSize, false,
                    fieldPadding: fieldPadding),
                _buildTextFormField('Employee DRA Status', labelFontSize, false,
                    fieldPadding: fieldPadding),
                _buildTextFormField(
                    'DRA Certificate Number', labelFontSize, false,
                    controller: _draCertificateController,
                    fieldPadding: fieldPadding),
                _buildFileUploadField('Upload DRA Certificate Image',
                    _draCertificateImage, 'DRA Certificate',
                    fieldPadding: fieldPadding),
                _buildTextFormField(
                    'PVC Certificate Number', labelFontSize, true,
                    controller: _pvcCertificateController,
                    fieldPadding: fieldPadding),
                _buildFileUploadField('Upload PVC Certificate Image',
                    _pvcCertificateImage, 'PVC Certificate',
                    fieldPadding: fieldPadding),
                _buildDateField('PVC Challan Issued Date', labelFontSize,
                    _pvcIssueDateController,
                    fieldPadding: fieldPadding),
                _buildDateField('PVC Certification Validity Date',
                    labelFontSize, _pvcValidityDateController,
                    fieldPadding: fieldPadding),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back', style: TextStyle(fontSize: fontSize)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _saveFormData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FamilyDetailsPage(), // Ensure this page is defined
                            ),
                          );
                        }
                      },
                      child: Text('Save and Next',
                          style: TextStyle(fontSize: fontSize)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        value: _selectedNationality,
        items: _nationalities
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: TextStyle(fontSize: fontSize)),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedNationality = value;
          });
        },
      ),
    );
  }

  Widget _buildTextFormField(String label, double fontSize, bool required,
      {TextEditingController? controller,
      FormFieldValidator<String>? validator,
      EdgeInsetsGeometry fieldPadding = const EdgeInsets.all(0)}) {
    return Padding(
      padding: fieldPadding,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '$label is required';
                }
                return validator?.call(value);
              }
            : validator,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget _buildDateField(
      String label, double fontSize, TextEditingController controller,
      {EdgeInsetsGeometry fieldPadding = const EdgeInsets.all(0)}) {
    return Padding(
      padding: fieldPadding,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              final DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (selectedDate != null) {
                setState(() {
                  controller.text =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                });
              }
            },
          ),
        ),
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget _buildCheckBoxField(
      String label, List<String> options, double fontSize,
      {EdgeInsetsGeometry fieldPadding = const EdgeInsets.all(0)}) {
    return Padding(
      padding: fieldPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: options.map((option) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _checkboxValues[option] ?? false,
                    onChanged: (value) {
                      setState(() {
                        _checkboxValues[option] = value ?? false;
                      });
                    },
                  ),
                  Text(option, style: TextStyle(fontSize: fontSize)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFileUploadField(String label, XFile? imageFile, String fileType,
      {EdgeInsetsGeometry fieldPadding = const EdgeInsets.all(0)}) {
    return Padding(
      padding: fieldPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  switch (fileType) {
                    case 'PAN':
                      _panImage = pickedFile;
                      break;
                    case 'Aadhar':
                      _aadharImage = pickedFile;
                      break;
                    case 'Gas Bill':
                      _gasBillImage = pickedFile;
                      break;
                    case 'Electricity Bill':
                      _electricityBillImage = pickedFile;
                      break;
                    case 'DRA Certificate':
                      _draCertificateImage = pickedFile;
                      break;
                    case 'PVC Certificate':
                      _pvcCertificateImage = pickedFile;
                      break;
                  }
                });
              }
            },
            child: Text('Upload $fileType Image'),
          ),
          if (imageFile != null) ...[
            SizedBox(height: 10),
            Image.file(
              File(imageFile.path),
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ],
      ),
    );
  }

  void _saveFormData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('dob', _dobController.text);
    prefs.setString('pvcIssueDate', _pvcIssueDateController.text);
    prefs.setString('pvcValidityDate', _pvcValidityDateController.text);
    prefs.setString('pan', _panController.text);
    prefs.setString('aadhar', _aadharController.text);
    prefs.setString('gasBill', _gasBillController.text);
    prefs.setString('electricityBill', _electricityBillController.text);
    prefs.setString('draCertificate', _draCertificateController.text);
    prefs.setString('pvcCertificate', _pvcCertificateController.text);

    // Save file paths or handle file uploads here
  }

  void _loadFormData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _dobController.text = prefs.getString('dob') ?? '';
      _pvcIssueDateController.text = prefs.getString('pvcIssueDate') ?? '';
      _pvcValidityDateController.text =
          prefs.getString('pvcValidityDate') ?? '';
      _panController.text = prefs.getString('pan') ?? '';
      _aadharController.text = prefs.getString('aadhar') ?? '';
      _gasBillController.text = prefs.getString('gasBill') ?? '';
      _electricityBillController.text =
          prefs.getString('electricityBill') ?? '';
      _draCertificateController.text = prefs.getString('draCertificate') ?? '';
      _pvcCertificateController.text = prefs.getString('pvcCertificate') ?? '';
    });
  }

  String? _validatePAN(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN Number is required';
    }
    // Implement your PAN number validation logic here
    return null;
  }

  String? _validateAadhar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Aadhar Number is required';
    }
    // Implement your Aadhar number validation logic here
    return null;
  }
}
