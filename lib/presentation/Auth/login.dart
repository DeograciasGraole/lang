import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lang/data/providers/auth_notifier.dart';
import 'package:lang/data/services/ApiService.dart';
import 'package:lang/presentation/Auth/register.dart';
import 'package:lang/presentation/dashboard/dashboard.dart';
import 'package:lang/presentation/dashboard/pages/home_dashboar_page.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierprovider);

    // Navigate to dashboard if login succeeds
    authState.whenData((user) {
      if (user != null) {
        Future.microtask(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainDashboard()),
          );
        });
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'GraoLang',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome back',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Discover limitless Choices of languages to Learn',
              style: TextStyle(fontSize: 19),
            ),
            const SizedBox(height: 24),

            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) =>
                        (value == null || !value.contains('@'))
                        ? "Enter a valid email"
                        : null,
                    onSaved: (val) => email = val ?? "",
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) => (value == null || value.length < 6)
                        ? "Password must be at least 6 chars"
                        : null,
                    onSaved: (val) => password = val ?? "",
                  ),
                  const SizedBox(height: 12),

                  // Inline error message
                  if (authState.hasError)
                    Text(
                      authState.error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 24),

                  // Sign In Button
                  GestureDetector(
                    onTap: () {
                      final isValid = _formKey.currentState!.validate();
                      FocusScope.of(context).unfocus();
                      if (isValid) {
                        _formKey.currentState!.save();
                        ref
                            .read(authNotifierprovider.notifier)
                            .login(email, password);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (_) => MainDashboard()),
                        // );
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
                        child: authState.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Create Account Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(20, 255, 255, 255),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Or sign in with
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Or Sign in with'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            // TODO: implement Google Sign In
                            try {
                              final apiService = ApiService();
                              final result = await apiService.loginWithGoogle();
                              ref
                                  .read(authNotifierprovider.notifier)
                                  .loginGoogle(email, password);
                            } catch (e) {
                              print('Error: $e');
                            }
                          },
                          icon: Image.asset(
                            'assets/images/google.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Apple
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // TODO: implement Apple Sign In
                          },
                          icon: Image.asset(
                            'assets/images/apple.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
