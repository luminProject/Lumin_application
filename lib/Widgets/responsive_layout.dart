import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final String? title;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.showAppBar = true,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.transparent, // مهم لظهور الخلفية
      extendBodyBehindAppBar: true, 
      appBar: showAppBar 
          ? AppBar(
              title: Text(title ?? ""),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          // السماح بالتمرير عند ظهور لوحة المفاتيح
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 1200), // أقصى عرض للتابلت
            padding: EdgeInsets.symmetric(
              // حواف ديناميكية: 20 بكسل للجوال و 15% من العرض للأجهزة الكبيرة
              horizontal: isMobile ? 20.0 : size.width * 0.15,
              vertical: 20.0,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}