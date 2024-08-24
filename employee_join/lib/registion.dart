import 'package:employee_join/EmployeePersonalDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class ResponsivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Image.asset('logo.png', height: 40), // Update path if needed
                SizedBox(width: 10),
                Text('Employee Registration'),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 228, 231, 175),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 600;

            return Padding(
              padding: EdgeInsets.all(20),
              child: isDesktop
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 214, 230, 74),
                                  Color.fromARGB(255, 175, 131, 64),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('logo.png',
                                    height: 100), // Update path if needed
                                SizedBox(height: 20),
                                Text(
                                  'Moukthika Enterprises Pvt Ltd.,',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 82, 23, 2),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: EmployeeRegistrationForm(),
                        ),
                      ],
                    )
                  : EmployeeRegistrationForm(),
            );
          },
        ),
      ),
    );
  }
}

class EmployeeRegistrationForm extends StatefulWidget {
  @override
  _EmployeeRegistrationFormState createState() =>
      _EmployeeRegistrationFormState();
}

class _EmployeeRegistrationFormState extends State<EmployeeRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _imageBytes;
  String _currentAddressType = 'Own';
  String _permanentAddressType = 'Own';
  bool _isSameAddress = false;

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _currentAddressController = TextEditingController();
  final _permanentAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _currentAddressController.dispose();
    _permanentAddressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.single;
        setState(() {
          _imageBytes = file.bytes;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<void> _saveFormData() async {
    if (_formKey.currentState!.validate()) {
      if (_imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please upload a photo')),
        );
        return;
      }

      final prefs = await SharedPreferences.getInstance();

      // Save form data
      await prefs.setString('firstName', _firstNameController.text);
      await prefs.setString('middleName', _middleNameController.text);
      await prefs.setString('surname', _surnameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('mobileNumber', _mobileNumberController.text);
      await prefs.setString('currentAddress', _currentAddressController.text);
      await prefs.setString('currentAddressType', _currentAddressType);
      await prefs.setString('permanentAddressType', _permanentAddressType);
      await prefs.setBool('isSameAddress', _isSameAddress);

      if (!_isSameAddress) {
        await prefs.setString(
            'permanentAddress', _permanentAddressController.text);
      }

      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeePersonalDetailsPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please complete the form correctly'),
        ),
      );
    }
  }

  Future<void> _loadFormData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _firstNameController.text = prefs.getString('firstName') ?? '';
      _middleNameController.text = prefs.getString('middleName') ?? '';
      _surnameController.text = prefs.getString('surname') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _mobileNumberController.text = prefs.getString('mobileNumber') ?? '';
      _currentAddressController.text = prefs.getString('currentAddress') ?? '';
      _currentAddressType = prefs.getString('currentAddressType') ?? 'Own';
      _permanentAddressType = prefs.getString('permanentAddressType') ?? 'Own';
      _isSameAddress = prefs.getBool('isSameAddress') ?? false;

      if (!_isSameAddress) {
        _permanentAddressController.text =
            prefs.getString('permanentAddress') ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double fontSize = screenWidth > 600 ? 18 : 16;
    double padding = screenWidth > 600 ? 16 : 8;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  if (_imageBytes != null)
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          _imageBytes!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'No Image',
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Upload Photo',
                        style: TextStyle(fontSize: fontSize)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ..._buildTextFormFields(fontSize),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveFormData,
                child:
                    Text('Save and Next', style: TextStyle(fontSize: fontSize)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTextFormFields(double fontSize) {
    return [
      _buildTextFormField(
        'First Name',
        fontSize,
        controller: _firstNameController,
        validator: (value) =>
            value!.isEmpty ? 'Please enter the first name' : null,
      ),
      SizedBox(height: 16),
      _buildTextFormField(
        'Middle Name',
        fontSize,
        controller: _middleNameController,
      ),
      SizedBox(height: 16),
      _buildTextFormField(
        'Surname',
        fontSize,
        controller: _surnameController,
        validator: (value) =>
            value!.isEmpty ? 'Please enter the surname' : null,
      ),
      SizedBox(height: 16),
      _buildTextFormField(
        'Email',
        fontSize,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value!.isEmpty || !value.contains('@')
            ? 'Please enter a valid email'
            : null,
      ),
      SizedBox(height: 16),
      _buildTextFormField(
        'Mobile Number',
        fontSize,
        controller: _mobileNumberController,
        keyboardType: TextInputType.phone,
        validator: (value) => value!.isEmpty || value.length != 10
            ? 'Please enter a valid mobile number'
            : null,
      ),
      SizedBox(height: 16),
      _buildTextFormField(
        'Current Address',
        fontSize,
        controller: _currentAddressController,
        validator: (value) =>
            value!.isEmpty ? 'Please enter the current address' : null,
      ),
      SizedBox(height: 16),
      _buildDropdownFormField(
        'Current Address Type',
        fontSize,
        value: _currentAddressType,
        items: ['Own', 'Rent', 'Others'],
        onChanged: (newValue) {
          setState(() {
            _currentAddressType = newValue!;
          });
        },
      ),
      SizedBox(height: 16),
      _buildCheckboxField(
        'Is Same As Current Address',
        fontSize,
        value: _isSameAddress,
        onChanged: (newValue) {
          setState(() {
            _isSameAddress = newValue!;
            if (_isSameAddress) {
              _permanentAddressController.text = _currentAddressController.text;
            }
          });
        },
      ),
      SizedBox(height: 16),
      if (!_isSameAddress)
        Column(
          children: [
            _buildTextFormField(
              'Permanent Address',
              fontSize,
              controller: _permanentAddressController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the permanent address' : null,
            ),
            SizedBox(height: 16),
            _buildDropdownFormField(
              'Permanent Address Type',
              fontSize,
              value: _permanentAddressType,
              items: ['Own', 'Rent', 'Others'],
              onChanged: (newValue) {
                setState(() {
                  _permanentAddressType = newValue!;
                });
              },
            ),
          ],
        ),
    ];
  }

  Widget _buildTextFormField(
    String label,
    double fontSize, {
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize),
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownFormField(
    String label,
    double fontSize, {
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize),
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          isExpanded: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: fontSize)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildCheckboxField(
    String label,
    double fontSize, {
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return CheckboxListTile(
      title: Text(label, style: TextStyle(fontSize: fontSize)),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
