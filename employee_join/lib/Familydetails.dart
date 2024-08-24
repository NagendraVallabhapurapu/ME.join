import 'package:employee_join/mployeeAcademicsAndCareer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Adjust the import path as needed

class FamilyDetailsPage extends StatefulWidget {
  @override
  _FamilyDetailsPageState createState() => _FamilyDetailsPageState();
}

class _FamilyDetailsPageState extends State<FamilyDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'fatherName': TextEditingController(),
    'fatherDOB': TextEditingController(),
    'fatherEducation': TextEditingController(),
    'fatherOccupation': TextEditingController(),
    'fatherContact': TextEditingController(),
    'motherName': TextEditingController(),
    'motherDOB': TextEditingController(),
    'motherEducation': TextEditingController(),
    'motherOccupation': TextEditingController(),
    'motherContact': TextEditingController(),
    'spouseName': TextEditingController(),
    'spouseDOB': TextEditingController(),
    'spouseEducation': TextEditingController(),
    'spouseOccupation': TextEditingController(),
    'spouseContact': TextEditingController(),
    'brotherName': TextEditingController(),
    'brotherDOB': TextEditingController(),
    'brotherEducation': TextEditingController(),
    'brotherOccupation': TextEditingController(),
    'brotherContact': TextEditingController(),
    'sisterName': TextEditingController(),
    'sisterDOB': TextEditingController(),
    'sisterEducation': TextEditingController(),
    'sisterOccupation': TextEditingController(),
    'sisterContact': TextEditingController(),
    'childName1': TextEditingController(),
    'childDOB1': TextEditingController(),
    'childEducation1': TextEditingController(),
    'childName2': TextEditingController(),
    'childDOB2': TextEditingController(),
    'childEducation2': TextEditingController(),
  };

  bool _isBrotherMarried = false;
  bool _isSisterMarried = false;

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth > 600 ? 18.0 : 16.0;
    final padding = screenWidth > 600 ? 20.0 : 10.0;

    return Scaffold(
      appBar: _buildAppBar(fontSize),
      body: _buildBody(fontSize, padding),
    );
  }

  PreferredSizeWidget _buildAppBar(double fontSize) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 221, 223, 118),
              Color.fromARGB(255, 178, 23, 2),
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
              Image.asset('logo.png', height: 40),
              SizedBox(width: 10),
              Text(
                'Family Details of the Employee',
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(double fontSize, double padding) {
    return Container(
      padding: EdgeInsets.all(padding),
      color: Color.fromARGB(255, 228, 231, 175),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Family Information',
                style: TextStyle(
                  fontSize: fontSize + 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ...['Father', 'Mother', 'Spouse', 'Brother', 'Sister'].map(
                (role) {
                  return _buildFamilyMemberSection(
                    role,
                    [
                      'Name',
                      'Date of Birth',
                      'Education',
                      'Occupation',
                      'Contact No'
                    ],
                    fontSize,
                  );
                },
              ).toList(),
              _buildChildrenDetailsSection(fontSize),
              SizedBox(height: 20),
              _buildButtonRow(fontSize),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyMemberSection(
      String memberRole, List<String> fields, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$memberRole Details',
            style: TextStyle(
              fontSize: fontSize + 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ...fields.map((field) {
            final controllerKey =
                '${memberRole.toLowerCase()}${field.replaceAll(' ', '')}';
            final controller = _controllers[controllerKey];

            return _buildTextFormField(
              '$memberRole $field',
              fontSize,
              controller: controller,
              isDateField: field == 'Date of Birth',
            );
          }).toList(),
          if (memberRole == 'Brother' || memberRole == 'Sister') ...[
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: memberRole == 'Brother'
                      ? _isBrotherMarried
                      : _isSisterMarried,
                  onChanged: (value) {
                    setState(() {
                      if (memberRole == 'Brother') {
                        _isBrotherMarried = value ?? false;
                      } else {
                        _isSisterMarried = value ?? false;
                      }
                    });
                  },
                ),
                Text(
                  'Married',
                  style: TextStyle(fontSize: fontSize),
                ),
                SizedBox(width: 20),
                Checkbox(
                  value: memberRole == 'Brother'
                      ? !_isBrotherMarried
                      : !_isSisterMarried,
                  onChanged: (value) {
                    setState(() {
                      if (memberRole == 'Brother') {
                        _isBrotherMarried = !(value ?? false);
                      } else {
                        _isSisterMarried = !(value ?? false);
                      }
                    });
                  },
                ),
                Text(
                  'Unmarried',
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
          ],
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildChildrenDetailsSection(double fontSize) {
    return Column(
      children: [
        _buildChildCard(
          'Child 1 Details',
          fontSize,
          _controllers['childName1'],
          _controllers['childDOB1'],
          _controllers['childEducation1'],
        ),
        SizedBox(height: 10),
        _buildChildCard(
          'Child 2 Details',
          fontSize,
          _controllers['childName2'],
          _controllers['childDOB2'],
          _controllers['childEducation2'],
        ),
      ],
    );
  }

  Widget _buildChildCard(
    String title,
    double fontSize,
    TextEditingController? nameController,
    TextEditingController? dobController,
    TextEditingController? educationController,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      color: Color.fromARGB(255, 255, 236, 179),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize + 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildTextFormField(
              'Child Name',
              fontSize,
              controller: nameController,
            ),
            _buildTextFormField(
              'Child Date of Birth',
              fontSize,
              controller: dobController,
              isDateField: true,
            ),
            _buildTextFormField(
              'Child Education',
              fontSize,
              controller: educationController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    String labelText,
    double fontSize, {
    required TextEditingController? controller,
    bool isDateField = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: fontSize),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        ),
        onTap: isDateField
            ? () async {
                FocusScope.of(context).unfocus();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  final formattedDate =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                  controller?.text = formattedDate;
                }
              }
            : null,
      ),
    );
  }

  Widget _buildButtonRow(double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Navigate to the previous page
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(
            'Back',
            style: TextStyle(
                fontSize: fontSize,
                color: const Color.fromARGB(255, 120, 110, 163)),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              // Save the data
              final prefs = await SharedPreferences.getInstance();
              _controllers.forEach((key, controller) {
                prefs.setString(key, controller.text);
              });
              prefs.setBool('brotherMarried', _isBrotherMarried);
              prefs.setBool('sisterMarried', _isSisterMarried);

              // Navigate to the next page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmployeeAcademicsAndCareerPage()),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(
            'Save and Next',
            style: TextStyle(
                fontSize: fontSize,
                color: const Color.fromARGB(255, 120, 110, 163)),
          ),
        ),
      ],
    );
  }
}
