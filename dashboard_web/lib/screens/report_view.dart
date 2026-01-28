import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../widgets/kpi_card.dart';
import '../widgets/filter_bar.dart';
import '../widgets/orders_table.dart';
import '../widgets/charts_section.dart';
import '../data/mock_data.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  String _statusFilter = 'all';
  String _keyword = '';
  DateTimeRange? _dateRange;

  List<Map<String, dynamic>> get _filteredOrders {
    var list = List<Map<String, dynamic>>.from(MockData.orders);
    if (_statusFilter != 'all') {
      list = list.where((o) => o['status'] == _statusFilter).toList();
    }
    if (_keyword.isNotEmpty) {
      list = list.where((o) => '${o['id']}'.contains(_keyword)).toList();
    }
    if (_dateRange != null) {
      // simplified: filter by date if we had DateTime on items
      list = list; // keep as-is for demo
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDims.paddingPage),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('数据报表', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: MockData.kpis.map((k) => SizedBox(width: 200, child: KpiCard(title: k.title, value: k.value, unit: k.unit))).toList(),
          ),
          const SizedBox(height: 24),
          FilterBar(
            status: _statusFilter,
            keyword: _keyword,
            dateRange: _dateRange,
            onStatusChanged: (v) => setState(() => _statusFilter = v),
            onKeywordChanged: (v) => setState(() => _keyword = v),
            onDateRangeChanged: (v) => setState(() => _dateRange = v),
            onQuery: () => setState(() {}),
            onReset: () => setState(() {
              _statusFilter = 'all';
              _keyword = '';
              _dateRange = null;
            }),
          ),
          const SizedBox(height: 24),
          const ChartsSection(),
          const SizedBox(height: 24),
          Text('订单列表', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          OrdersTable(orders: _filteredOrders),
        ],
      ),
    );
  }
}
