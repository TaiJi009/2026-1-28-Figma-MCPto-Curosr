import 'package:flutter/material.dart';
import '../app_theme.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key, required this.orders});

  final List<Map<String, dynamic>> orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDims.radiusCard),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.textSecondary),
          dataTextStyle: Theme.of(context).textTheme.bodyMedium,
          columns: const [
            DataColumn(label: Text('订单号')),
            DataColumn(label: Text('金额')),
            DataColumn(label: Text('状态')),
            DataColumn(label: Text('日期')),
          ],
          rows: orders
              .map(
                (o) => DataRow(
                  cells: [
                    DataCell(Text('${o['id']}')),
                    DataCell(
                      Text(
                        '${o['amount']}',
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ),
                    DataCell(_StatusChip(status: '${o['status']}')),
                    DataCell(Text('${o['date']}')),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  Color get _color {
    switch (status) {
      case '已完成':
        return const Color(0xFF4CAF50);
      case '进行中':
        return const Color(0xFFFF9800);
      case '已取消':
        return const Color(0xFFF44336);
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppDims.radiusButton),
      ),
      child: Text(status, style: TextStyle(color: _color, fontSize: 12)),
    );
  }
}
