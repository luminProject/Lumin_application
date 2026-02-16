import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'glass_card.dart';

enum StatsRange { day, week, month, year }

class StatsCardExact extends StatefulWidget {
  const StatsCardExact({super.key});

  @override
  State<StatsCardExact> createState() => _StatsCardExactState();
}

class _StatsCardExactState extends State<StatsCardExact> {
  StatsRange _range = StatsRange.month;

  @override
  Widget build(BuildContext context) {
    final data = _buildSeries(_range);

    return GlassCard(
      radius: 20,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: _StatsTabs(
              active: _range,
              onChanged: (r) => setState(() => _range = r),
            ),
          ),
          const SizedBox(height: 10),

          const Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 18,
              runSpacing: 6,
              children: [
                _LegendDot(color: AppColors.mint, text: 'Solar Production'),
                _LegendDot(color: AppColors.cyan, text: 'Grid Import'),
              ],
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 190,
            child: LineChart(
              LineChartData(
                minX: data.minX,
                maxX: data.maxX,
                minY: 0,
                maxY: data.maxY,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: data.yInterval,
                  getDrawingHorizontalLine: (_) => FlLine(color: Colors.white10, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 46,
                      interval: data.yInterval,
                      getTitlesWidget: (v, meta) {
                        if (v == 0) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '${v.toInt()} kWh',
                            style: const TextStyle(fontSize: 10, color: AppColors.sub),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: data.xLabelInterval,
                      getTitlesWidget: (v, meta) {
                        final label = data.xLabel(v);
                        if (label == null) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            label,
                            style: const TextStyle(fontSize: 10.5, color: AppColors.sub),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  _line(color: AppColors.mint, spots: data.solar, fillOpacity: 0.18),
                  _line(color: AppColors.cyan, spots: data.grid, fillOpacity: 0.10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _line({
    required Color color,
    required List<FlSpot> spots,
    required double fillOpacity,
  }) {
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0.35,
      barWidth: 3,
      color: color,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: true, color: color.withOpacity(fillOpacity)),
      spots: spots,
    );
  }

  _SeriesPack _buildSeries(StatsRange r) {
    switch (r) {
      case StatsRange.day:
        final xs = [0, 3, 6, 9, 12, 15, 18, 21, 24];
        final solar = <FlSpot>[];
        final grid = <FlSpot>[];

        for (final x in xs) {
          solar.add(FlSpot(x.toDouble(), _solarDayProfile(x.toDouble())));
          grid.add(FlSpot(x.toDouble(), _gridDayProfile(x.toDouble())));
        }

        final maxY = _niceMaxY(_maxY(solar, grid), stepHint: 5);
        return _SeriesPack(
          minX: 0,
          maxX: 24,
          maxY: maxY,
          yInterval: (maxY / 4).clamp(4, 10).roundToDouble(),
          xLabelInterval: 6,
          solar: solar,
          grid: grid,
          xLabel: (v) => (v.toInt() % 6 == 0) ? v.toInt().toString() : null,
        );

      case StatsRange.week:
        final solarVals = const [18, 21, 16, 24, 22, 19, 23];
        final gridVals = const [12, 10, 14, 9, 11, 13, 10];
        final solar = List.generate(7, (i) => FlSpot(i.toDouble(), solarVals[i].toDouble()));
        final grid = List.generate(7, (i) => FlSpot(i.toDouble(), gridVals[i].toDouble()));

        final maxY = _niceMaxY(_maxY(solar, grid), stepHint: 10);
        const labels = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

        return _SeriesPack(
          minX: 0,
          maxX: 6,
          maxY: maxY,
          yInterval: (maxY / 4).clamp(5, 15).roundToDouble(),
          xLabelInterval: 1,
          solar: solar,
          grid: grid,
          xLabel: (v) {
            final i = v.toInt();
            if (i < 0 || i > 6) return null;
            return labels[i];
          },
        );

      case StatsRange.month:
        final xs = List.generate(11, (i) => i * 3);
        final solar = <FlSpot>[];
        final grid = <FlSpot>[];

        for (final d in xs) {
          final s = 16 + (sin(d / 5) * 4) + (d * 0.15);
          final g = 13 + (cos(d / 6) * 3) + (d * 0.05);
          solar.add(FlSpot(d.toDouble(), s));
          grid.add(FlSpot(d.toDouble(), g));
        }

        final maxY = _niceMaxY(_maxY(solar, grid), stepHint: 10);
        return _SeriesPack(
          minX: 0,
          maxX: 30,
          maxY: maxY,
          yInterval: (maxY / 4).clamp(10, 30).roundToDouble(),
          xLabelInterval: 6,
          solar: solar,
          grid: grid,
          xLabel: (v) => (v.toInt() % 6 == 0) ? ((v.toInt() == 0) ? '1' : v.toInt().toString()) : null,
        );

      case StatsRange.year:
        final solarVals = const [420, 460, 520, 610, 680, 720, 740, 700, 640, 580, 480, 430];
        final gridVals  = const [520, 500, 470, 420, 360, 320, 300, 310, 340, 390, 470, 510];
        final solar = List.generate(12, (i) => FlSpot(i.toDouble(), solarVals[i].toDouble()));
        final grid  = List.generate(12, (i) => FlSpot(i.toDouble(), gridVals[i].toDouble()));

        final maxY = _niceMaxY(_maxY(solar, grid), stepHint: 100);
        const labels = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

        return _SeriesPack(
          minX: 0,
          maxX: 11,
          maxY: maxY,
          yInterval: (maxY / 4).clamp(100, 250).roundToDouble(),
          xLabelInterval: 2,
          solar: solar,
          grid: grid,
          xLabel: (v) {
            final i = v.toInt();
            if (i < 0 || i > 11) return null;
            if (i % 2 != 0) return null;
            return labels[i];
          },
        );
    }
  }

  double _solarDayProfile(double hour) {
    final h = hour.clamp(0, 24);
    final peak = 13.0;
    final spread = 5.0;
    final val = 10 * exp(-pow((h - peak) / spread, 2));
    return (val * 0.9).clamp(0, 9.5);
  }

  double _gridDayProfile(double hour) {
    final h = hour.clamp(0, 24);
    final night = (h <= 6 || h >= 18) ? 6.0 : 3.0;
    final middayDip = 2.2 * exp(-pow((h - 13) / 4.5, 2));
    return (night - middayDip + 2.0).clamp(1.2, 8.5);
  }

  double _niceMaxY(double rawMax, {required double stepHint}) {
    final step = stepHint;
    return (rawMax / step).ceil() * step;
  }

  double _maxY(List<FlSpot> a, List<FlSpot> b) {
    double m = 0;
    for (final s in a) { if (s.y > m) m = s.y; }
    for (final s in b) { if (s.y > m) m = s.y; }
    return m;
  }
}

class _SeriesPack {
  final double minX, maxX, maxY, yInterval, xLabelInterval;
  final List<FlSpot> solar;
  final List<FlSpot> grid;
  final String? Function(double x) xLabel;

  _SeriesPack({
    required this.minX,
    required this.maxX,
    required this.maxY,
    required this.yInterval,
    required this.xLabelInterval,
    required this.solar,
    required this.grid,
    required this.xLabel,
  });
}

class _StatsTabs extends StatelessWidget {
  final StatsRange active;
  final ValueChanged<StatsRange> onChanged;

  const _StatsTabs({
    required this.active,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Widget item(String t, StatsRange r) {
      final isActive = r == active;

      return GestureDetector(
        onTap: () => onChanged(r),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? AppColors.mint : AppColors.sub,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isActive ? 44 : 0,
                decoration: BoxDecoration(
                  color: AppColors.mint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        item('Day', StatsRange.day),
        item('Week', StatsRange.week),
        item('Month', StatsRange.month),
        item('Year', StatsRange.year),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendDot({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(99),
            boxShadow: [BoxShadow(color: color.withOpacity(0.25), blurRadius: 10)],
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12, color: AppColors.sub)),
      ],
    );
  }
}
