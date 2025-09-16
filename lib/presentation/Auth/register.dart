// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lang/data/firebase/auth_service..dart';
import 'package:lang/presentation/Auth/login.dart';
import 'package:lang/presentation/dashboard/dashboard.dart';
import 'package:lang/presentation/dashboard/pages/home_dashboar_page.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();

  String username = "";

  String email = "";

  String password = "";

  String errorMessage = "";

  void registerUser() async {
    try {
      await authService.value.CreateAccount(email: email, password: password);
      print("you have login ");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DashboardScreen();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 56, bottom: 24, left: 24, right: 24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///Log,Title
              ///
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 200),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: 24),
                  Form(
                    key: formkey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            // labelText: "Email",k
                            hintText: "Enter your name",
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            hintStyle: const TextStyle(color: Colors.black26),

                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 94, 93, 95),
                            ),

                            // 🔹 Filled background
                            filled: true,
                            fillColor: Colors.grey.shade100,

                            // 🔹 Normal border
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(46, 148, 148, 148),
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
                          onSaved: (value) {
                            setState(() {
                              username = value ?? '';
                            });
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
                              Icons.lock,
                              color: Color.fromARGB(255, 94, 93, 95),
                            ),

                            // 🔹 Filled background
                            filled: true,
                            fillColor: Colors.grey.shade100,

                            // 🔹 Normal border
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(46, 148, 148, 148),
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

                          onSaved: (value) {
                            setState(() {
                              email = value ?? '';
                            });
                          },
                        ),
                        SizedBox(height: 24),
                        TextFormField(
                          decoration: InputDecoration(
                            // labelText: "Email",k
                            hintText: "Second Your password ",
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
                                color: const Color.fromARGB(46, 148, 148, 148),
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
                              return "Please enter your password";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              password = value ?? '';
                            });
                          },
                        ),
                        SizedBox(height: 18),

                        GestureDetector(
                          onTap: () {
                            final isValid = formkey.currentState!.validate();
                            // FocusScope.of(context).unfocus();

                            if (isValid) {
                              formkey.currentState!.save();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return maindashboard();
                                  },
                                ),
                              );
                              // registerUser();
                              // final message =
                              //     'username : $username and password: $password email: $email ';

                              // final snackBar = SnackBar(
                              //   content: Text(
                              //     message,
                              //     style: TextStyle(fontSize: 23),
                              //   ),
                              //   backgroundColor: Colors.green,
                              // );

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return LoginScreen();
                              //     },
                              //   ),
                              // );

                              // ScaffoldMessenger.of(
                              //   context,
                              // ).showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 55,

                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 36, 29, 45),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 183, 58, 58),
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 34),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Divider(
                          color: Colors.black,
                          thickness: 0.5,
                          indent: 60,
                          endIndent: 5,
                        ),
                      ),
                      Text('Or Sign in with', textAlign: TextAlign.center),
                      Flexible(
                        child: Divider(
                          color: Colors.black,
                          thickness: 0.5,
                          indent: 5,
                          endIndent: 60,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 34),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image(
                            width: 30,
                            height: 30,
                            image: AssetImage('assets/images/google.png'),
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image(
                            width: 30,
                            height: 30,
                            image: AssetImage('assets/images/apple.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(width: 100, height: 1, color: Colors.amberAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
