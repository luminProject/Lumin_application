import 'package:flutter/material.dart';

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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
