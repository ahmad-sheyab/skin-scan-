// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_nullable, unused_import

import 'package:flutter/material.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_field_data.dart';
import 'package:client/features/auth/view/widgets/custom_field_email.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();
  final validateController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? errorMessage;

  bool isExpanded = false;
  bool _isPasswordVisible = false;
  bool _isPasswordConVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    validateController.dispose();
    passwordController.dispose();
    passwordConController.dispose();
    super.dispose();
  }

  Future<void> sendCode() async {
    final email = emailController.text.trim();
    if (formKey.currentState?.validate() ?? false) {
      try {
        final response =
            await AuthRemoteRepository().passValidate(email: email);

        if (response.statusCode == 400) {
          setState(() {
            errorMessage = 'This email does not exist in the system.';
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
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (errorMessage != null) {
                      return errorMessage; // عرض رسالة الخطأ
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: isExpanded ? 0 : 50,
                  child: Button(
                    buttonText: 'Send Code',
                    onTap: sendCode,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: isExpanded ? null : 0,
                  child: isExpanded
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            CustomFieldData(
                              hintText: 'Validation Code :',
                              controller: validateController,
                              enabled: true,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: passwordConController,
                              obscureText: !_isPasswordConVisible,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordConVisible =
                                          !_isPasswordConVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordConVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Button(
                              buttonText: 'Confirm',
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
