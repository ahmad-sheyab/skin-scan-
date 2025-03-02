// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:client/features/auth/viewmodel/validator.dart';
import 'package:flutter/material.dart';

class CustomFieldData extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const CustomFieldData({
    super.key,
    required bool enabled,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
      ),
      validator: (val) => validatordata(val),
      obscureText: isObscureText,
    );
  }
}
