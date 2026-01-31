import 'package:expensetracker/expense_tracker/screens/registration_screen.dart';
import 'package:expensetracker/expense_tracker/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isShowPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/login.json',
                  fit: BoxFit.contain,
                  repeat: false,
                  width: 320
                ),
                Text(
                  'Welcome Back !',
                  style: AppUtils.titleStyle,
                ),
                Text(
                  'Sign in to track your expenses and manage your money smarter.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email_sharp),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  obscureText: true,
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
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: Text('Sign In')),
                ),
                TextButton(onPressed: (){}, child: Text('Forgot Password ?')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?", style: TextStyle(fontWeight: FontWeight.w600),),
                    TextButton(onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegistrationScreen(),),);
                    }, child: Text('Sign Up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
