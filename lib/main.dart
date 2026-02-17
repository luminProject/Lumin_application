import 'package:flutter/material.dart';
import 'package:lumin_application/Screens/bill_predection/bill_prediction.dart';
import 'package:lumin_application/Screens/home/home_page.dart';
import 'package:lumin_application/Widgets/gradient_background.dart';
import 'package:lumin_application/Screens/login.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginPage(),

    );
  }
}
