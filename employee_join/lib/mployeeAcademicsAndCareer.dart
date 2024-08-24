import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employee_join/ReferenceAndFamilyEmploymentDetails.dart';

class EmployeeAcademicsAndCareerPage extends StatefulWidget {
  @override
  _EmployeeAcademicsAndCareerPageState createState() =>
      _EmployeeAcademicsAndCareerPageState();
}

class _EmployeeAcademicsAndCareerPageState
    extends State<EmployeeAcademicsAndCareerPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'SSCInstituteName': TextEditingController(),
    'SSCPlace': TextEditingController(),
    'SSCPercentage': TextEditingController(),
    'SSCYearOfPassing': TextEditingController(),
    'IntermediateInstituteName': TextEditingController(),
    'IntermediatePlace': TextEditingController(),
    'IntermediateSpecialization': TextEditingController(),
    'IntermediatePercentage': TextEditingController(),
    'IntermediateYearOfPassing': TextEditingController(),
    'DegreeInstituteName': TextEditingController(),
    'DegreePlace': TextEditingController(),
    'DegreeSpecialization': TextEditingController(),
    'DegreePercentage': TextEditingController(),
    'DegreeYearOfPassing': TextEditingController(),
    'PostGradInstituteName': TextEditingController(),
    'PostGradPlace': TextEditingController(),
    'PostGradSpecialization': TextEditingController(),
    'PostGradPercentage': TextEditingController(),
    'PostGradYearOfPassing': TextEditingController(),
    'OtherSpecializationInstituteName': TextEditingController(),
    'OtherSpecializationPlace': TextEditingController(),
    'OtherSpecialization': TextEditingController(),
    'OtherSpecializationPercentage': TextEditingController(),
    'OtherSpecializationYearOfPassing': TextEditingController(),
    'CompanyName': TextEditingController(),
    'Designation': TextEditingController(),
    'YearsOfExperience': TextEditingController(),
    'Skills': TextEditingController(),
    'PreviousCompanyName': TextEditingController(),
    'PreviousDesignation': TextEditingController(),
    'PreviousYearsOfExperience': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    _controllers.forEach((key, controller) {
      final value = prefs.getString(key) ?? '';
      controller.text = value;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    _controllers.forEach((key, controller) {
      prefs.setString(key, controller.text);
    });
  }

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
                Image.asset('logo.png', height: 40),
                SizedBox(width: 10),
                Text(
                  'Employee Academics and Career',
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(padding),
        color: Color.fromARGB(255, 228, 231, 175),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                _buildCard(
                  'Academic Qualification',
                  fontSize,
                  [
                    _buildEducationField(
                      'SSC',
                      [
                        'Institute Name',
                        'Place',
                        'Percentage',
                        'Year of Passing',
                      ],
                      validate: true,
                    ),
                    _buildEducationField(
                      'Intermediate / Equivalent',
                      [
                        'Institute Name',
                        'Place',
                        'Specialization',
                        'Percentage',
                        'Year of Passing',
                      ],
                      validate: true,
                    ),
                    _buildEducationField(
                      'Degree',
                      [
                        'Institute Name',
                        'Place',
                        'Specialization',
                        'Percentage',
                        'Year of Passing',
                      ],
                      validate: false,
                    ),
                    _buildEducationField(
                      'Post Graduation',
                      [
                        'Institute Name',
                        'Place',
                        'Specialization',
                        'Percentage',
                        'Year of Passing',
                      ],
                      validate: false,
                    ),
                    _buildEducationField(
                      'Other Specialization',
                      [
                        'Institute Name',
                        'Place',
                        'Specialization',
                        'Percentage',
                        'Year of Passing',
                      ],
                      validate: false,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildCard(
                  'Career Details',
                  fontSize,
                  [
                    _buildCareerField('Company Name', fontSize),
                    _buildCareerField('Designation', fontSize),
                    _buildCareerField('Years of Experience', fontSize),
                    _buildCareerField('Skills', fontSize),
                  ],
                ),
                SizedBox(height: 20),
                _buildCard(
                  'Previous Career Details',
                  fontSize,
                  [
                    _buildCareerField('Previous Company Name', fontSize),
                    _buildCareerField('Previous Designation', fontSize),
                    _buildCareerField('Previous Years of Experience', fontSize),
                  ],
                ),
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
                          await _saveData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReferenceAndFamilyEmploymentDetailsPage()),
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

  Widget _buildCard(String title, double fontSize, List<Widget> children) {
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
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildEducationField(String title, List<String> fields,
      {bool validate = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ...fields.map((field) {
            final controllerKey =
                '${title.replaceAll(' ', '')}${field.replaceAll(' ', '')}';
            final controller =
                _controllers[controllerKey] ?? TextEditingController();

            return _buildTextFormField(
              field,
              controller,
              isDateField: field.contains('Year of Passing'),
              validate: validate && field.contains('Year of Passing'),
            );
          }).toList(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildCareerField(String fieldName, double fontSize) {
    final controller =
        _controllers[fieldName.replaceAll(' ', '')] ?? TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: fieldName,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        ),
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget _buildTextFormField(String fieldName, TextEditingController controller,
      {bool isDateField = false, bool validate = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: fieldName,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        ),
        style: TextStyle(fontSize: 16),
        keyboardType: isDateField ? TextInputType.datetime : TextInputType.text,
        validator: (value) {
          if (validate && (value == null || value.isEmpty)) {
            return 'Please enter $fieldName';
          }
          return null;
        },
      ),
    );
  }
}
