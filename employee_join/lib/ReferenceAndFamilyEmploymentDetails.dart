import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employee_join/bank_esi_epf.dart';

class ReferenceAndFamilyEmploymentDetailsPage extends StatefulWidget {
  @override
  _ReferenceAndFamilyEmploymentDetailsPageState createState() =>
      _ReferenceAndFamilyEmploymentDetailsPageState();
}

class _ReferenceAndFamilyEmploymentDetailsPageState
    extends State<ReferenceAndFamilyEmploymentDetailsPage> {
  bool _isRelatedToEmployee = false;
  final _referenceNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactNoController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _relationshipSinceController = TextEditingController();
  final _employmentDetailsController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _fatherCompanyNameController = TextEditingController();
  final _fatherLocationController = TextEditingController();
  final _fatherDesignationController = TextEditingController();
  final _fatherContactNoController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _motherCompanyNameController = TextEditingController();
  final _motherLocationController = TextEditingController();
  final _motherDesignationController = TextEditingController();
  final _motherContactNoController = TextEditingController();
  final _brotherNameController = TextEditingController();
  final _brotherCompanyNameController = TextEditingController();
  final _brotherLocationController = TextEditingController();
  final _brotherDesignationController = TextEditingController();
  final _brotherContactNoController = TextEditingController();
  final _sisterNameController = TextEditingController();
  final _sisterCompanyNameController = TextEditingController();
  final _sisterLocationController = TextEditingController();
  final _sisterDesignationController = TextEditingController();
  final _sisterContactNoController = TextEditingController();
  final _employeeNameController = TextEditingController();
  final _employeeDesignationController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _employeeRelationshipController = TextEditingController();
  final _employeeContactNoController = TextEditingController();

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
                Expanded(
                  child: Text(
                    'Reference and Family Employment Details',
                    style: TextStyle(fontSize: fontSize),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 204), // Pale yellow background
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCard(
                      'Employee Reference Details',
                      fontSize,
                      [
                        _buildTextFormField('Reference Name', fontSize,
                            _referenceNameController),
                        _buildTextFormField(
                            'Address', fontSize, _addressController),
                        _buildTextFormField(
                            'Contact No.', fontSize, _contactNoController),
                        _buildTextFormField(
                            'Relationship', fontSize, _relationshipController),
                        _buildTextFormField('Relationship Since', fontSize,
                            _relationshipSinceController),
                        _buildTextFormField('Employment Details', fontSize,
                            _employmentDetailsController),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildCard(
                      'Family Employment Details',
                      fontSize,
                      [
                        _buildFamilyDetailsSection('Father'),
                        _buildFamilyDetailsSection('Mother'),
                        _buildFamilyDetailsSection('Brother'),
                        _buildFamilyDetailsSection('Sister'),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildCard(
                      'Employee Relationship with Moukthika Enterprises Pvt Ltd',
                      fontSize,
                      [
                        _buildRelationshipCheckbox(),
                        if (_isRelatedToEmployee) ...[
                          _buildTextFormField('Name of the Employee', fontSize,
                              _employeeNameController),
                          _buildTextFormField('Designation', fontSize,
                              _employeeDesignationController),
                          _buildTextFormField(
                              'Employee ID', fontSize, _employeeIdController),
                          _buildTextFormField('Relationship', fontSize,
                              _employeeRelationshipController),
                          _buildTextFormField('Contact No.', fontSize,
                              _employeeContactNoController),
                        ],
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); // Navigate back to the previous page
                            },
                            child: Text('Back',
                                style: TextStyle(fontSize: fontSize)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // Button color
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Save the data
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('referenceName',
                                  _referenceNameController.text);
                              await prefs.setString(
                                  'address', _addressController.text);
                              await prefs.setString(
                                  'contactNo', _contactNoController.text);
                              await prefs.setString(
                                  'relationship', _relationshipController.text);
                              await prefs.setString('relationshipSince',
                                  _relationshipSinceController.text);
                              await prefs.setString('employmentDetails',
                                  _employmentDetailsController.text);
                              await prefs.setString(
                                  'fatherName', _fatherNameController.text);
                              await prefs.setString('fatherCompanyName',
                                  _fatherCompanyNameController.text);
                              await prefs.setString('fatherLocation',
                                  _fatherLocationController.text);
                              await prefs.setString('fatherDesignation',
                                  _fatherDesignationController.text);
                              await prefs.setString('fatherContactNo',
                                  _fatherContactNoController.text);
                              await prefs.setString(
                                  'motherName', _motherNameController.text);
                              await prefs.setString('motherCompanyName',
                                  _motherCompanyNameController.text);
                              await prefs.setString('motherLocation',
                                  _motherLocationController.text);
                              await prefs.setString('motherDesignation',
                                  _motherDesignationController.text);
                              await prefs.setString('motherContactNo',
                                  _motherContactNoController.text);
                              await prefs.setString(
                                  'brotherName', _brotherNameController.text);
                              await prefs.setString('brotherCompanyName',
                                  _brotherCompanyNameController.text);
                              await prefs.setString('brotherLocation',
                                  _brotherLocationController.text);
                              await prefs.setString('brotherDesignation',
                                  _brotherDesignationController.text);
                              await prefs.setString('brotherContactNo',
                                  _brotherContactNoController.text);
                              await prefs.setString(
                                  'sisterName', _sisterNameController.text);
                              await prefs.setString('sisterCompanyName',
                                  _sisterCompanyNameController.text);
                              await prefs.setString('sisterLocation',
                                  _sisterLocationController.text);
                              await prefs.setString('sisterDesignation',
                                  _sisterDesignationController.text);
                              await prefs.setString('sisterContactNo',
                                  _sisterContactNoController.text);
                              await prefs.setString(
                                  'employeeName', _employeeNameController.text);
                              await prefs.setString('employeeDesignation',
                                  _employeeDesignationController.text);
                              await prefs.setString(
                                  'employeeId', _employeeIdController.text);
                              await prefs.setString('employeeRelationship',
                                  _employeeRelationshipController.text);
                              await prefs.setString('employeeContactNo',
                                  _employeeContactNoController.text);

                              // Navigate to the next page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BankEsiEpfPage(),
                                ),
                              );
                            },
                            child: Text('Save and Next',
                                style: TextStyle(fontSize: fontSize)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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

  Widget _buildTextFormField(
      String labelText, double fontSize, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget _buildFamilyDetailsSection(String relation) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$relation Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildTextFormField(
              '$relation Name', 16, _getControllerByRelation(relation, 'Name')),
          _buildTextFormField('Company Name', 16,
              _getControllerByRelation(relation, 'CompanyName')),
          _buildTextFormField(
              'Location', 16, _getControllerByRelation(relation, 'Location')),
          _buildTextFormField('Designation', 16,
              _getControllerByRelation(relation, 'Designation')),
          _buildTextFormField('Company Contact No.', 16,
              _getControllerByRelation(relation, 'ContactNo')),
        ],
      ),
    );
  }

  Widget _buildRelationshipCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isRelatedToEmployee,
          onChanged: (bool? newValue) {
            setState(() {
              _isRelatedToEmployee = newValue ?? false;
            });
          },
        ),
        Expanded(
          child: Text(
            'Are you related to any of the present/previous employees of Moukthika Enterprises Pvt Ltd?',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  TextEditingController _getControllerByRelation(
      String relation, String field) {
    switch (relation) {
      case 'Father':
        switch (field) {
          case 'Name':
            return _fatherNameController;
          case 'CompanyName':
            return _fatherCompanyNameController;
          case 'Location':
            return _fatherLocationController;
          case 'Designation':
            return _fatherDesignationController;
          case 'ContactNo':
            return _fatherContactNoController;
        }
        break;
      case 'Mother':
        switch (field) {
          case 'Name':
            return _motherNameController;
          case 'CompanyName':
            return _motherCompanyNameController;
          case 'Location':
            return _motherLocationController;
          case 'Designation':
            return _motherDesignationController;
          case 'ContactNo':
            return _motherContactNoController;
        }
        break;
      case 'Brother':
        switch (field) {
          case 'Name':
            return _brotherNameController;
          case 'CompanyName':
            return _brotherCompanyNameController;
          case 'Location':
            return _brotherLocationController;
          case 'Designation':
            return _brotherDesignationController;
          case 'ContactNo':
            return _brotherContactNoController;
        }
        break;
      case 'Sister':
        switch (field) {
          case 'Name':
            return _sisterNameController;
          case 'CompanyName':
            return _sisterCompanyNameController;
          case 'Location':
            return _sisterLocationController;
          case 'Designation':
            return _sisterDesignationController;
          case 'ContactNo':
            return _sisterContactNoController;
        }
        break;
    }
    return TextEditingController();
  }
}
