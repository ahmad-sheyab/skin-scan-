import 'package:client/features/auth/view/pages/Validate.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/skin_scan_transparent.gif',
                width: 250,
                height: 200,
              ),
              Button(
                buttonText: 'Sign In',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                buttonText: 'Sign Up',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Validate(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
