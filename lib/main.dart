import 'package:flutter/material.dart';
import 'package:musicapp_client/core/theme/theme.dart';
import 'package:musicapp_client/features/auth/view/pages/signup_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const SignupPage(),
    );
  }
}
