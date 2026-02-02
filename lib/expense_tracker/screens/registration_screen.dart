import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/expense_tracker/screens/login_screen.dart';
import 'package:expensetracker/expense_tracker/utils/app_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isShowPassword = false;
  bool _isShowConfirmPassword = false;
  bool _isLoading = false;

  final TextEditingController _fullNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
  TextEditingController();

  /// Registration logic
  Future<void> _createUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Create user in Firebase Auth
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailTEController.text.trim(),
          password: _passwordTEController.text.trim());

      final User? user = userCredential.user;

      if (user != null) {
        // Save user info in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': _fullNameTEController.text.trim(),
          'mobileNumber': _mobileTEController.text.trim(),
          'email': _emailTEController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        if (!mounted) return;

        AppUtils.showCustomSnackBar(
          context: context,
          message: "Account successfully created",
          isSuccess: true,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      AppUtils.showCustomSnackBar(
        context: context,
        message: e.message ?? 'Registration failed',
        isSuccess: false,
      );
    } catch (e) {
      if (!mounted) return;
      AppUtils.showCustomSnackBar(
        context: context,
        message: 'Something went wrong. Try again.',
        isSuccess: false,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _fullNameTEController.dispose();
    _emailTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    _confirmPassTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Use smaller Lottie for emulator-friendly performance
                        Lottie.asset(
                          'assets/lottie/login.json',
                          width: 200,
                          repeat: false,
                          animate: true,
                        ),
                        const SizedBox(height: 12),
                        Text('Create an Account !', style: AppUtils.titleStyle),
                        const SizedBox(height: 8),
                        const Text(
                          'Start tracking your expenses and take control of your finances today.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Full Name
                        TextFormField(
                          controller: _fullNameTEController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Full Name',
                          ),
                          validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter your name'
                              : null,
                        ),
                        const SizedBox(height: 12),

                        // Email
                        TextFormField(
                          controller: _emailTEController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email),
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your email';
                            }
                            final regex =
                            RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                            if (!regex.hasMatch(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Mobile
                        TextFormField(
                          controller: _mobileTEController,
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: 'Mobile',
                            counterText: '',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your phone number';
                            }
                            final regex = RegExp(r'^01[3-9]\d{8}$');
                            if (!regex.hasMatch(value.trim())) {
                              return 'Enter a valid BD mobile number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Password
                        TextFormField(
                          controller: _passwordTEController,
                          obscureText: !_isShowPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(_isShowPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(
                                      () => _isShowPassword = !_isShowPassword),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Confirm Password
                        TextFormField(
                          controller: _confirmPassTEController,
                          obscureText: !_isShowConfirmPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(_isShowConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(() =>
                              _isShowConfirmPassword =
                              !_isShowConfirmPassword),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm your password';
                            }
                            if (value != _passwordTEController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _createUser,
                            child: _isLoading
                                ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : const Text('Sign Up'),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Already have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginScreen()),
                                );
                              },
                              child: const Text('Sign In'),
                            ),
                          ],
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
