import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.home_rounded, color: AppColors.mint),
            Icon(Icons.link, color: Colors.white54),
            Icon(Icons.link, color: Colors.white54),
            Icon(Icons.link, color: Colors.white54),
            Icon(Icons.link, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
