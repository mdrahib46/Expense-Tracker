import 'package:expensetracker/expense_tracker/screens/login_screen.dart';
import 'package:expensetracker/expense_tracker/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isShowPass = false;
  final TextEditingController _fullNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
      TextEditingController();

  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/login.json',
                  fit: BoxFit.contain,
                  repeat: false,
                  width: 320,
                ),
                Text('Create an Account !', style: AppUtils.titleStyle),
                Text(
                  'Start tracking your expenses and take control of your finances today.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _fullNameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email_sharp),
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return "Enter your email...!";
                    }
                    final regexp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!regexp.hasMatch(value)) {
                      return "Enter a valid email...!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _mobileTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Mobile',
                    counterText: ' ',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your phone number';
                    }

                    final regex = RegExp(r'^(?:\+88)?01[3-9]\d{8}$');

                    if (!regex.hasMatch(value.trim())) {
                      return 'Enter a valid mobile number';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: !_isShowPass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isShowPass = !_isShowPass;
                        setState(() {});
                      },
                      icon: _isShowPass
                          ? Icon(Icons.remove_red_eye_outlined)
                          : Icon(Icons.remove_red_eye),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'Enter you password';
                    }
                    if (value.length < 6) {
                      return 'Password length should be greater then or equal to 6';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirmPassTEController,
                  obscureText: !_isShowPass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isShowPass = !_isShowPass;
                        setState(() {});
                      },
                      icon: _isShowPass
                          ? Icon(Icons.remove_red_eye_outlined)
                          : Icon(Icons.remove_red_eye),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'Enter you password !';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters !';
                    }

                    if(value != _passwordTEController.text){
                      return 'Passwords do not match...!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Sign up'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                        setState(() {});
                      },
                      child: Text('Sign In'),
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

  @override
  void dispose() {
    _fullNameTEController.dispose();
    _emailTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    _confirmPassTEController.dispose();
    super.dispose();
  }
}
