import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../app_theme.dart';
import '../data/mock_data.dart';

class ChartsSection extends StatelessWidget {
  const ChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        if (w >= 800) {
          final singleW = (w - 32) / 3;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: singleW, child: _LineChartCard()),
              const SizedBox(width: 16),
              SizedBox(width: singleW, child: _BarChartCard()),
              const SizedBox(width: 16),
              SizedBox(width: singleW, child: _PieChartCard()),
            ],
          );
        }
        return Column(
          children: [
            _LineChartCard(),
            const SizedBox(height: 16),
            _BarChartCard(),
            const SizedBox(height: 16),
            _PieChartCard(),
          ],
        );
      },
    );
  }
}

class _LineChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MockData.visits7;
    final spots = data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), (e.value['value'] as num).toDouble())).toList();
    return _Card(
      title: '近 7 日访问量',
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (_) => FlLine(color: AppColors.divider.withOpacity(0.3))),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 32, getTitlesWidget: (v, _) => Text('${v.toInt()}', style: Theme.of(context).textTheme.bodySmall)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 24, getTitlesWidget: (v, _) => Text('${data[v.toInt() % data.length]['label']}', style: Theme.of(context).textTheme.bodySmall)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: AppColors.primary,
                barWidth: 2,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(show: true, color: AppColors.primary.withOpacity(0.15)),
              ),
            ],
          ),
          duration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }
}

class _BarChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MockData.orders5;
    return _Card(
      title: '近 5 日订单量',
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (_) => FlLine(color: AppColors.divider.withOpacity(0.3))),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 32, getTitlesWidget: (v, _) => Text('${v.toInt()}', style: Theme.of(context).textTheme.bodySmall)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 24, getTitlesWidget: (v, _) => Text('${data[v.toInt() % data.length]['label']}', style: Theme.of(context).textTheme.bodySmall)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            barGroups: data.asMap().entries.map((e) => BarChartGroupData(
              x: e.key,
              barRods: [BarChartRodData(toY: (e.value['value'] as num).toDouble(), color: AppColors.primary, width: 16, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))],
              showingTooltipIndicators: const [],
            )).toList(),
          ),
          duration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }
}

class _PieChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MockData.statusPie;
    return _Card(
      title: '订单状态占比',
      child: SizedBox(
        height: 200,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 24,
                  sections: data.map((e) => PieChartSectionData(
                    value: e['value'] as double,
                    color: Color(e['color'] as int),
                    radius: 36,
                    showTitle: false,
                  )).toList(),
                ),
                duration: const Duration(milliseconds: 200),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(width: 10, height: 10, decoration: BoxDecoration(color: Color(e['color'] as int), shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text('${e['name']} ${e['value']}%', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDims.paddingCard),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDims.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
