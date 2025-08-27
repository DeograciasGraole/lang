import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 56, bottom: 24, left: 24, right: 24),

          child: Column(
            children: [
              ///Log,Title
              ///
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GraoLang',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Welcome back',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Discover limitless Choices of languages to Learn',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 24),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            // labelText: "Email",k
                            hintText: "Enter your email",
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            hintStyle: const TextStyle(color: Colors.black26),

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color.fromARGB(255, 94, 93, 95),
                            ),

                            // 🔹 Filled background
                            filled: true,
                            fillColor: Colors.grey.shade100,

                            // 🔹 Normal border
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(49, 0, 0, 0),
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),

                            // 🔹 Focused border
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(39, 32, 32, 32),
                                width: 1.8,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),

                            // 🔹 Error border (for validation)
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.8,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),

                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 18),
                        TextFormField(
                          decoration: InputDecoration(
                            // labelText: "Email",k
                            hintText: "Enter your password",
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            hintStyle: const TextStyle(color: Colors.black26),

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color.fromARGB(255, 94, 93, 95),
                            ),

                            // 🔹 Filled background
                            filled: true,
                            fillColor: Colors.grey.shade100,

                            // 🔹 Normal border
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(49, 0, 0, 0),
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),

                            // 🔹 Focused border
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(39, 32, 32, 32),
                                width: 1.8,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),

                            // 🔹 Error border (for validation)
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.4,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.8,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),

                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
