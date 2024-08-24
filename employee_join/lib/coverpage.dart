import 'package:flutter/material.dart';
import 'package:employee_join/registion.dart'; // Ensure this import matches your file structure

class CoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 600;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 235, 59), // Gradient yellow
                  Color.fromARGB(255, 121, 85, 72), // Gradient brown
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 40 : 20),
                child: Container(
                  padding: EdgeInsets.all(isDesktop ? 30 : 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  width:
                      isDesktop ? 600 : MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: isDesktop ? 20 : 10),
                      Image.asset(
                        'logo.png',
                        height: isDesktop ? 150 : 100,
                        width: isDesktop ? 150 : 100,
                      ),
                      SizedBox(height: isDesktop ? 20 : 10),
                      Text(
                        'Moukthika Enterprises Pvt Ltd.,',
                        style: TextStyle(
                          fontSize: isDesktop
                              ? 28
                              : 18, // Adjusted font size for mobile view
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 63, 2, 2),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isDesktop ? 20 : 15),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResponsivePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 88, 6, 13), // Background color
                          foregroundColor: Colors.white, // Text color
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          textStyle: TextStyle(
                            fontSize: isDesktop
                                ? 24
                                : 16, // Adjusted font size for mobile view
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text('Employee Registration'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
