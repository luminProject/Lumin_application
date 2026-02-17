import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'glass_card.dart';

class DeviceCard extends StatelessWidget {
  final String title;
  final String value;
  final bool active;

  // للـDevices page
  final bool running;
  final bool fullWidth;
  final VoidCallback? onMenu;
  final VoidCallback? onLink;

  const DeviceCard({
    super.key,
    required this.title,
    required this.value,
    required this.active,
    this.running = false,
    this.fullWidth = false,
    this.onMenu,
    this.onLink,
  });

  @override
  Widget build(BuildContext context) {
    final accent = active ? AppColors.mint : Colors.white54;

    // نفس الكارد يشتغل للهوم (tight) ولصفحة devices (full)
    final waveHeight = fullWidth ? 34.0 : 22.0;
    final rowGap = fullWidth ? 10.0 : 8.0;
    final titleGap = fullWidth ? 10.0 : 8.0;

    return GlassCard(
      radius: 20,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // ✅ مهم عشان ما يحاول يتمدد عمودي
        children: [
          Row(
            children: [
              InkWell(
                onTap: onLink,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: active ? AppColors.mint.withOpacity(0.18) : Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.link, color: accent, size: 18),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onMenu,
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.more_horiz, color: Colors.white54),
                ),
              ),
            ],
          ),

          SizedBox(height: rowGap),

          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: titleGap),

          // ✅ مكان الموجة/الخط ثابت، ما فيه Flexible
          active
              ? SizedBox(
                  height: waveHeight,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _WavePainter(color: AppColors.mint.withOpacity(0.95)),
                    child: const SizedBox.expand(),
                  ),
                )
              : Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white24,
                ),

          if (fullWidth) ...[
            const SizedBox(height: 8),
            Text(
              active ? (running ? 'Connected • Running' : 'Connected') : 'Disconnected',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: active ? AppColors.mint : Colors.white38,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
          ] else ...[
            const SizedBox(height: 8),
          ],

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: active ? AppColors.mint : Colors.white38,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color color;
  _WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final mid = size.height * 0.58;
    path.moveTo(0, mid);

    for (double x = 0; x <= size.width; x += 1) {
      final y = mid + sin(x / 10) * (size.height * 0.22);
      path.lineTo(x, y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
