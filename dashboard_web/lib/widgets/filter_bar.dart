import 'package:flutter/material.dart';
import '../app_theme.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
    required this.status,
    required this.keywordController,
    required this.dateRange,
    required this.onStatusChanged,
    required this.onKeywordChanged,
    required this.onDateRangeChanged,
    required this.onQuery,
    required this.onReset,
  });

  final String status;
  final TextEditingController keywordController;
  final DateTimeRange? dateRange;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onKeywordChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;
  final VoidCallback onQuery;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDims.paddingCard),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDims.radiusCard),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 140,
            child: DropdownButtonFormField<String>(
              value: status,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('全部状态')),
                DropdownMenuItem(value: '已完成', child: Text('已完成')),
                DropdownMenuItem(value: '进行中', child: Text('进行中')),
                DropdownMenuItem(value: '已取消', child: Text('已取消')),
              ],
              onChanged: (v) => onStatusChanged(v ?? 'all'),
            ),
          ),
          SizedBox(
            width: 180,
            child: TextField(
              controller: keywordController,
              onChanged: onKeywordChanged,
              decoration: const InputDecoration(
                hintText: '订单号/关键词',
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              final now = DateTime.now();
              final picked = await showDateRangePicker(
                context: context,
                firstDate: now.subtract(const Duration(days: 365)),
                lastDate: now,
                initialDateRange:
                    dateRange ??
                    DateTimeRange(
                      start: now.subtract(const Duration(days: 7)),
                      end: now,
                    ),
              );
              if (picked != null) onDateRangeChanged(picked);
            },
            icon: const Icon(Icons.calendar_today, size: 18),
            label: Text(
              dateRange == null
                  ? '时间范围'
                  : '${_fmt(dateRange!.start)} ~ ${_fmt(dateRange!.end)}',
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.divider),
            ),
          ),
          FilledButton(onPressed: onQuery, child: const Text('查询')),
          TextButton(onPressed: onReset, child: const Text('重置')),
        ],
      ),
    );
  }

  String _fmt(DateTime d) => '${d.month}-${d.day}';
}
