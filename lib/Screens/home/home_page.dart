import 'package:flutter/material.dart';

import '../../Widgets/gradient_background.dart';
import '../../Widgets/responsive_layout.dart';
import '../../Widgets/home/header.dart';
import '../../Widgets/home/hero_house.dart';
import '../../Widgets/home/solar_impact.dart';
import '../../Widgets/home/devices_section.dart';
import '../../Widgets/home/stats_card.dart';
import '../../Widgets/home/bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final devicesHeight = (w < 360) ? 168.0 : 158.0;

    return GradientBackground(
      child: ResponsiveLayout(
        // ✅ ما نبي AppBar فوق (عشان ما يصير تكرار)
        showAppBar: false,

        // ✅ Bottom nav ثابت
        bottomNavigationBar: const HomeBottomNav(currentIndex: 0),

        // ✅ نفس padding القديم + نزّل الهيدر شوي
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ يخلي الهيدر ما يلصق فوق عند الكاميرا/الستاتس بار
              SizedBox(height: MediaQuery.of(context).padding.top * 0.25),

              const HomeHeader(),
              const SizedBox(height: 12),

              const HeroHouse(),
              const SizedBox(height: 14),

              const Text(
                'Solar Impact',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),

              const SolarImpactRow(),
              const SizedBox(height: 16),

              DevicesSection(
                height: devicesHeight,
                onSeeAll: () {},
              ),
              const SizedBox(height: 16),

              const Text(
                'Statistics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),

              const StatsCardExact(),
            ],
          ),
        ),
      ),
    );
  }
}

