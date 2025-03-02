// ignore_for_file: unused_import, use_build_context_synchronously

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_field_data.dart';
import 'package:flutter/material.dart';

class Forget2 extends StatefulWidget {
  final String email;
  const Forget2({super.key, required this.email});

  @override
  State<Forget2> createState() => _Forget2State();
}

class _Forget2State extends State<Forget2> {
  final validateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final passwordController = TextEditingController();
  final passwordConController = TextEditingController();
  bool _isPasswordConVisible = false;
  late TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    emailController =
        TextEditingController(text: widget.email); // Set the email
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    passwordConController.dispose();
    validateController.dispose();
    super.dispose();
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
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true, // Completely disable typing
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomFieldData(
                  hintText: 'Validation Code :',
                  controller: validateController,
                  enabled: true,
                ),
                Container(
                  padding: EdgeInsets.only(right: 220, top: 10),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Pallete.gradient1, Pallete.gradient2],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: Text(
                      'Enter the code you received',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // ضروري لتفعيل الـ Shader
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return ' Password cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordConController,
                  obscureText: !_isPasswordConVisible,
                  decoration: InputDecoration(
                    labelText: ' Confirm Password ',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordConVisible = !_isPasswordConVisible;
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password cannot be empty';
                    }
                    if (value != passwordController.text) {
                      return 'The two passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Button(
                  buttonText: 'Confirm',
                  onTap: () async {
                    await AuthRemoteRepository().ValidateCode(
                        email: emailController.text,
                        new_password: passwordController.text,
                        validate_code: validateController.text);
                    // ignore: unused_local_variable
                    String email = emailController.text.trim();
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
            ),
          ),
        ),
      ),
    );
  }
}
