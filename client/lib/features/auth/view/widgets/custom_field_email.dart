// ignore_for_file: public_member_api_docs, sort_constructors_first, body_might_complete_normally_nullable, unused_import

import 'package:client/features/auth/viewmodel/validator.dart';
import 'package:flutter/material.dart';

class CustomFieldEmail extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const CustomFieldEmail({
    super.key,
    required bool enabled,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    required String? Function(dynamic value) validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
      ),
      validator: (val) {},
      obscureText: isObscureText,
    );
  }
}
