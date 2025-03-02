// ignore_for_file: use_build_context_synchronously, file_names, body_might_complete_normally_nullable, unused_import, unused_local_variable

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_field_email.dart';
import 'package:flutter/material.dart';

class Validate extends StatefulWidget {
  const Validate({
    super.key,
  }); // Required constructor parameter

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? errorMessage;

  bool isExpanded = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendCode() async {
    final email = emailController.text.trim();
    if (formKey.currentState?.validate() ?? false) {
      try {
        final response =
            await AuthRemoteRepository().Validate(email: emailController.text);
        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignupPage(email: email),
            ),
          );
        }

        if (response.statusCode == 400) {
          setState(() {
            errorMessage = 'This email already exists';
          });
          formKey.currentState?.validate();
        } else {
          setState(() {
            errorMessage = null;
            isExpanded = true;
          });
        }
      } catch (error) {
        setState(() {
          errorMessage = 'An error occurred, please try again later.';
        });
        formKey.currentState?.validate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/skin_scan_transparent.gif',
                    width: 250,
                    height: 200,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Pallete.gradient1, Pallete.gradient2],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // ضروري لتفعيل الـ Shader
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                    ),
                    controller: emailController,
                    enabled: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (errorMessage != null) {
                        return errorMessage;
                      } // عرض رسالة الخطأ
                      // ignore: dead_code

                      /*   if (val.contains(' ')) {
                        return 'Email cannot contain spaces';
                      } */

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                      buttonText: 'Send Code',
                      onTap:
                          sendCode /* () async {
                      await AuthRemoteRepository()
                          .Validate(email: emailController.text);
                      String email = emailController.text.trim();
                      if (formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(email: email),
                          ),
                        );
                      }
                    }, */
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: RichText(
                        text: TextSpan(
                            text: 'Already have an account ? ?',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                          TextSpan(
                              text: ' Sign In',
                              style: TextStyle(
                                  color: Pallete.gradient2,
                                  fontWeight: FontWeight.bold))
                        ])),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
