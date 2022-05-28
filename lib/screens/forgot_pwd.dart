import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = 'ForgotPassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Receive an email to reset your password.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    labelText: 'email', prefixIcon: Icon(Icons.email)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 17),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Do enter the correct email if the page is not responding.',
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showTopSnackBar(
          context,
          CustomSnackBar.success(
              message: 'Check your email to reset your password.'));
      Navigator.pop(context);
    } catch (e) {
      showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: e.toString(),
            textStyle: TextStyle(fontSize: 15),
          ));
    }
  }
}
