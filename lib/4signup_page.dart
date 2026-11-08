
import 'package:flutter/material.dart';
import 'package:frontend_queueless/5login_page.dart';
import 'package:frontend_queueless/1uihelper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  static const Color primary = Color(0xFF6C4CF1);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primary),
      filled: true,
      fillColor: const Color(0xFFF8F7FC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFEAE6F5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
    );
  }


  Future<void> signUp(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      UiHelper.CustomAlertBox(context, "Enter all required fields");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/auth/register"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      debugPrint("Status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();

        final userId = data["id"];

        if (userId != null) {
          await prefs.setInt("userId", (userId as num).toInt());
        }
        await prefs.setString("userName", data["name"]);
        await prefs.setString("userEmail", data["email"]);

        if (!mounted) return;

        UiHelper.CustomAlertBox(context, "Registration successful",
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => LoginPage(),
              ),
            );
          },
        );
      } else {
        if (!mounted) return;
        UiHelper.CustomAlertBox(context, "Registration failed: ${response.body}",);
      }
    } catch (e) {
      debugPrint("Signup error: $e");
      if (!mounted) return;
      UiHelper.CustomAlertBox(context, "Unable to connect to server",);
    }
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,

      body: SizedBox( // SafeArea

        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20,),

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  style: IconButton.styleFrom(backgroundColor: const Color(0xFFF3F0FF), ),
                ),
                const SizedBox(height: 28),

                Center(
                  child: Container(height: 72, width: 72,
                    decoration: BoxDecoration(color: primary,
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: const Icon( Icons.hourglass_top_rounded,
                      size: 40, color: Colors.white,),
                  ),
                ),
                const SizedBox(height: 24),

                const Center(
                  child: Text( 'Create Account',
                    style: TextStyle(fontSize: 29,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF201B35), ),
                  ),
                ),
                const SizedBox(height: 8),

                const Center(
                  child: Text('Join QueueLess and make every minute count.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,
                      color: Color(0xFF89859A),),
                  ),
                ),
                const SizedBox(height: 32),

                const Text('Full name',
                  style: TextStyle(fontWeight: FontWeight.w600), ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.sentences,   // first letter of each word is automatically capitalized
                  decoration: inputDecoration('Enter your full name',
                    Icons.person_outline_rounded, ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text('Email address',
                  style: TextStyle(fontWeight: FontWeight.w600),),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration('Enter your email',
                    Icons.email_outlined, ),

                  validator: (value) {
                    if (value == null ||
                        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(value.trim())) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text('Password',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: inputDecoration('Create a password',
                    Icons.lock_outline_rounded,)
                      .copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text('Confirm password',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  decoration: inputDecoration(
                    'Re-enter your password',
                    Icons.lock_reset_rounded,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                // Signup button
                UiHelper.CustomButton( () {
                    if (_formKey.currentState!.validate()) {
                      signUp(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text,
                      );
                    }
                  },
                  "Sign Up",
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                      style: TextStyle(color: Color(0xFF89859A)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: const Text('Login',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
