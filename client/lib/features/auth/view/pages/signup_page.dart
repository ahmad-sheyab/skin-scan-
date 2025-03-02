// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import, duplicate_ignore

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/main_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_field_data.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:fpdart/fpdart.dart' as fpdart;

class SignupPage extends StatefulWidget {
  final String email;
  const SignupPage({super.key, required this.email});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConController = TextEditingController();
  final ageController = TextEditingController();
  final roleController = TextEditingController();
  final validateController = TextEditingController();
  final genderController = TextEditingController();

  late TextEditingController emailController;
  bool _isPasswordVisible = false;
  String? selectedRole;
  String? selectedGender;

  String? selectedAge;
  DateTime? selectedDate;
  int? calculatedAge;
  bool _isPasswordConVisible = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController =
        TextEditingController(text: widget.email); // Set the email
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
    ageController.dispose();
    roleController.dispose();
    emailController.dispose();
    genderController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // تاريخ افتراضي
      firstDate: DateTime(1900), // أقدم تاريخ يمكن اختياره
      lastDate: DateTime.now(), // حتى اليوم الحالي
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      calculatedAge = DateTime.now().year - picked.year;
      if (DateTime.now().month < picked.month ||
          (DateTime.now().month == picked.month &&
              DateTime.now().day < picked.day)) {
        calculatedAge = calculatedAge! - 1;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(10.0),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Pallete.gradient1, Pallete.gradient2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Text(
              'Sign Up User',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white, // ضروري لتفعيل الـ Shader
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap Column in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
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
                CustomFieldData(
                  hintText: 'First Name',
                  controller: firstnameController,
                  enabled: true,
                ),
                const SizedBox(height: 30),
                CustomFieldData(
                  hintText: 'Last Name',
                  controller: lastnameController,
                  enabled: true,
                ),
                const SizedBox(height: 15),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: TextEditingController(text: 'User'),
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    hintText: 'User',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Gender'),
                  value: selectedGender,
                  items: ['Male', 'Female']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedGender = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    hintText: 'Select your birth date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(context),
                  controller: TextEditingController(
                    text: '$calculatedAge',
                  ),
                  validator: (value) {
                    if (calculatedAge == null) {
                      return 'Please select your birth date';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
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
                const SizedBox(
                  height: 20,
                ),
                Button(
                  buttonText: 'Sign Up',
                  onTap: () async {
                    final res = await AuthRemoteRepository().Create_User(
                        first_name: firstnameController.text,
                        last_name: lastnameController.text,
                        role: roleController.text,
                        age: ageController.text,
                        password: passwordController.text,
                        validate_code: validateController.text,
                        email: emailController.text,
                        gender: genderController.text);
                    final val = res.fold(
                      (left) => left,
                      (right) => right.toString(),
                    );

                    print(val);

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
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'Already have an account ?',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
                        TextSpan(
                            text: ' Sign in',
                            style: TextStyle(
                                color: Pallete.gradient2,
                                fontWeight: FontWeight.bold))
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
