import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../widgets/kpi_card.dart';
import '../data/mock_data.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final kpis = MockData.kpis;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDims.paddingPage),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('概览', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: kpis
                .map(
                  (k) => SizedBox(
                    width: 200,
                    child: KpiCard(
                      title: k['title']!,
                      value: k['value']!,
                      unit: k['unit']!,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 28),
          Text('近 7 日访问量', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: _ChartPlaceholder(data: MockData.visits7),
          ),
          const SizedBox(height: 28),
          Text('最近订单', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          _OrderTeaser(orders: MockData.orders.take(3).toList()),
        ],
      ),
    );
  }
}

class _ChartPlaceholder extends StatelessWidget {
  const _ChartPlaceholder({required this.data});

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDims.paddingCard),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDims.radiusCard),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((e) {
          final v = (e['value'] as num).toDouble();
          final maxV = data
              .map((x) => (x['value'] as num).toDouble())
              .reduce((a, b) => a > b ? a : b);
          final h = maxV > 0 ? (v / maxV) * 120 : 0.0;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$v', style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Container(
                    height: h.clamp(4.0, 120.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${e['label']}',
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _OrderTeaser extends StatelessWidget {
  const _OrderTeaser({required this.orders});

  final List<Map<String, dynamic>> orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDims.radiusCard),
      ),
      child: Column(
        children: orders
            .map(
              (o) => ListTile(
                title: Text(
                  '${o['id']}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  '${o['date']}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Text(
                  '${o['amount']}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
