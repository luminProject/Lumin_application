import 'package:flutter/material.dart';
import 'package:lumin_application/Screens/bill_predection/bill_prediction.dart';
import 'package:lumin_application/Screens/home/home_page.dart';
import '../../theme/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex; // 0 = Home, 1 = Bill Prediction, ...

  const HomeBottomNav({super.key, required this.currentIndex});

  void _goTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Widget _navItem({
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          color: active ? AppColors.mint : Colors.white54,
        ),
      ),
    );
  }

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ✅ 1) Home
            _navItem(
              icon: Icons.home_rounded,
              active: currentIndex == 0,
              onTap: () {
                if (currentIndex != 0) _goTo(context, const HomePage());
              },
            ),

            // ✅ 2) Bill Prediction
            _navItem(
              icon: Icons.receipt_long_rounded, // تقدرين تغيّرينها لأي أيقونة تبينها
              active: currentIndex == 1,
              onTap: () {
                if (currentIndex != 1) _goTo(context, const BillPredictionPage());
              },
            ),

            // باقي العناصر (Placeholder)
            _navItem(
              icon: Icons.link,
              active: currentIndex == 2,
              onTap: () {},
            ),
            _navItem(
              icon: Icons.link,
              active: currentIndex == 3,
              onTap: () {},
            ),
            _navItem(
              icon: Icons.link,
              active: currentIndex == 4,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
