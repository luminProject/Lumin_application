import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // لضمان أخذ كامل مساحة الشاشة
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          // تأكد من مطابقة اسم الصورة لما هو موجود في مجلد assets
          image: AssetImage('assets/images/bg.png'), 
          // يضمن عدم تمطط الصورة وتغطيتها لكل الأجهزة
          fit: BoxFit.cover, 
        ),
      ),
      child: child,
    );
  }
}