// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously, body_might_complete_normally_nullable

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/Validate.dart';
import 'package:client/features/auth/view/pages/forget_password_page.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/main_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_field_email.dart';
import 'package:client/features/auth/viewmodel/validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  String? errorMessage;
  bool _isPasswordVisible = false;

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          // Wrap Column in SingleChildScrollView
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
                      'Sign In',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // ضروري لتفعيل الـ Shader
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFieldEmail(
                  hintText: 'email',
                  controller: emailController,
                  enabled: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (errorMessage != null) {
                      return errorMessage; // عرض رسالة الخطأ
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (errorMessage != null) {
                      return errorMessage; // عرض رسالة الخطأ
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200, top: 10),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordPage()),
                        );
                      },
                      child: RichText(
                          text: TextSpan(
                        text: 'Forget Password ?',
                        style: TextStyle(color: Pallete.gradient2),
                      ))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  buttonText: 'Sign In',
                  onTap: () async {
                    // ignore: unused_local_variable
                    final email = emailController.text.trim();
                    if (formKey.currentState?.validate() ?? false) {
                      try {
                        final response = await AuthRemoteRepository().login(
                            email: emailController.text,
                            password: passwordController.text);

                        if (response.statusCode == 401) {
                          setState(() {
                            errorMessage = 'Invalid password or email.';
                          });
                          formKey.currentState
                              ?.validate(); // لإعادة التحقق وعرض الرسالة
                        } else {
                          setState(() {
                            errorMessage = null;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                          );
                        }
                      } catch (error) {
                        setState(() {
                          errorMessage =
                              'An error occurred, please try again later.';
                        });
                        formKey.currentState?.validate();
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Validate()),
                    );
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'don\'t have an account ?',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
                        TextSpan(
                            text: ' Sign Up',
                            style: TextStyle(
                                color: Pallete.gradient2,
                                fontWeight: FontWeight.bold))
                      ])),
                ),
              ],
            )),
      )),
    );
  }
}
