import 'package:flutter/material.dart';
import 'package:lumin_application/Widgets/gradient_background.dart';
import 'package:lumin_application/Widgets/home/bottom_nav.dart';
import 'package:lumin_application/Widgets/home/glass_card.dart';
import 'package:lumin_application/Widgets/responsive_layout.dart';
import 'package:lumin_application/theme/app_colors.dart';

class BillPredictionPage extends StatefulWidget {
  const BillPredictionPage({super.key});

  @override
  State<BillPredictionPage> createState() => _BillPredictionPageState();
}

class _BillPredictionPageState extends State<BillPredictionPage> {
  double _billLimit = 341;
  bool _overLimitAlert = true;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: ResponsiveLayout(
        // ✅ AppBar ثابت
        showAppBar: true,
        title: 'Bill Prediction',
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.mint,
            ),
          ),
        ],

        // ✅ Bottom nav
        bottomNavigationBar: const HomeBottomNav(currentIndex: 1),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Monthly Bill Limit Card =====
            GlassCard(
              padding: const EdgeInsets.all(16),
              radius: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Bill Limit (SAR)',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.80),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Text(
                      _billLimit.round().toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.button,
                      inactiveTrackColor: Colors.white.withOpacity(0.20),
                      thumbColor: AppColors.button,
                      overlayColor: AppColors.button.withOpacity(0.15),
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                    ),
                    child: Slider(
                      min: 200,
                      max: 800,
                      value: _billLimit,
                      onChanged: (v) => setState(() => _billLimit = v),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '200 SAR',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.60),
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        '800 SAR',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.60),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.bolt_rounded,
                        size: 15,
                        color: Colors.white.withOpacity(0.65),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '≈ ${(_billLimit * 4).round()} kWh at 0.25 SAR/kWh',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.62),
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ===== Over-Limit Alert =====
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              radius: 18,
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange.withOpacity(0.95),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Over-Limit Alert',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14.5,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Notify when exceeding limit',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.62),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _overLimitAlert,
                    activeColor: AppColors.button,
                    onChanged: (v) => setState(() => _overLimitAlert = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ===== Two mini cards =====
            Row(
              children: [
                Expanded(
                  child: _miniStatCard(
                    icon: Icons.flash_on_rounded,
                    title: 'Expected Usage',
                    value: '1,920',
                    unit: 'kWh this month',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _miniStatCard(
                    icon: Icons.attach_money_rounded,
                    title: 'Expected Cost',
                    value: '480',
                    unit: 'SAR this month',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ===== Smart Recommendation =====
            GlassCard(
              padding: const EdgeInsets.all(16),
              radius: 18,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 88,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.lightbulb_rounded,
                                color: Colors.orange.withOpacity(0.95),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Smart Recommendation',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Your predicted bill is 30 SAR over the limit.\n'
                          'Consider optimizing your AC schedule between\n'
                          '2–5 PM to save up to 30 SAR monthly.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.74),
                            fontSize: 12.5,
                            height: 1.35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ===== Buttons =====
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Adjust Usage',
                  style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.18)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: Colors.white.withOpacity(0.04),
                ),
                child: Text(
                  'View All Recommendations',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.88),
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ FIX: منع overflow على الأجهزة الصغيرة (بدون ما نخرب التصميم)
  Widget _miniStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String unit,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      radius: 18,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 78), // ✅ بدل SizedBox(height)
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.mint.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.mint,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // ✅ مهم
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.72),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    unit,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.60),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
