import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/view/pages/home_page.dart';
// ignore: unused_import
import 'package:client/features/auth/view/pages/login_page.dart';
// ignore: unused_import
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
