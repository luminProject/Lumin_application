import 'dart:math';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'glass_card.dart';

class DevicesSection extends StatefulWidget {
  final VoidCallback? onSeeAll;
  final double height;

  const DevicesSection({
    super.key,
    required this.height,
    this.onSeeAll,
  });

  @override
  State<DevicesSection> createState() => _DevicesSectionState();
}

class _DevicesSectionState extends State<DevicesSection> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 4, vsync: this);

  final Map<String, List<_DeviceItem>> roomDevices = const {
    'Living Room': [
      _DeviceItem('Living Room TV', '0.0 kW', false),
      _DeviceItem('Air Conditioning', '7.20 kW', true),
      _DeviceItem('Lamp', '0.12 kW', false),
      _DeviceItem('Speaker', '0.05 kW', false),
    ],
    'Kitchen': [
      _DeviceItem('Fridge', '0.30 kW', true),
      _DeviceItem('Oven', '1.80 kW', false),
      _DeviceItem('Microwave', '1.20 kW', false),
      _DeviceItem('Dishwasher', '0.90 kW', false),
    ],
    'Bedroom': [
      _DeviceItem('AC', '2.10 kW', true),
      _DeviceItem('Heater', '0.00 kW', false),
      _DeviceItem('Desk Lamp', '0.08 kW', false),
      _DeviceItem('TV', '0.15 kW', false),
    ],
    'Bathroom': [
      _DeviceItem('Water Heater', '2.40 kW', true),
      _DeviceItem('Vent Fan', '0.06 kW', false),
      _DeviceItem('Light', '0.03 kW', false),
    ],
  };

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = roomDevices.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Devices', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const Spacer(),
            InkWell(
              onTap: widget.onSeeAll,
              borderRadius: BorderRadius.circular(10),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text('See all', style: TextStyle(color: AppColors.sub, fontSize: 12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        TabBar(
          controller: _tabs,
          isScrollable: true,
          indicatorColor: AppColors.mint,
          labelColor: AppColors.text,
          unselectedLabelColor: AppColors.sub,
          tabs: rooms.map((r) => Tab(text: r)).toList(),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: widget.height,
          child: TabBarView(
            controller: _tabs,
            children: rooms.map((roomName) {
              final devices = roomDevices[roomName] ?? const <_DeviceItem>[];
              return _RoomDevicesHorizontalList(devices: devices);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _DeviceItem {
  final String title;
  final String value;
  final bool active;
  const _DeviceItem(this.title, this.value, this.active);
}

class _RoomDevicesHorizontalList extends StatelessWidget {
  final List<_DeviceItem> devices;
  const _RoomDevicesHorizontalList({required this.devices});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 2),
      itemCount: devices.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, i) {
        final d = devices[i];
        return SizedBox(
          width: 180,
          child: _DeviceCard(title: d.title, value: d.value, active: d.active),
        );
      },
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final String title;
  final String value;
  final bool active;

  const _DeviceCard({
    required this.title,
    required this.value,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final accent = active ? AppColors.mint : Colors.white54;

    return GlassCard(
      radius: 20,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: active ? AppColors.mint.withOpacity(0.18) : Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.link, color: accent, size: 18),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz, color: Colors.white54),
            ],
          ),
          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 10),

          Expanded(
            child: active
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 34,
                      child: CustomPaint(
                        painter: _WavePainter(color: AppColors.mint.withOpacity(0.95)),
                        child: const SizedBox.expand(),
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.white24,
                    ),
                  ),
          ),

          Align(
            alignment: Alignment.bottomRight,
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
