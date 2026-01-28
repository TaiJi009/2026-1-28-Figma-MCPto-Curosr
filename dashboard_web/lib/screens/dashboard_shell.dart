import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'overview_view.dart';
import 'report_view.dart';
import 'settings_view.dart';

enum DashboardView { overview, report, settings }

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  DashboardView _current = DashboardView.overview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Row(
        children: [
          _Sidebar(
            selected: _current,
            onSelect: (v) => setState(() => _current = v),
          ),
          Expanded(
            child: Column(
              children: [
                _AppBar(view: _current),
                Expanded(
                  child: _buildBody(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_current) {
      case DashboardView.overview:
        return const OverviewView();
      case DashboardView.report:
        return const ReportView();
      case DashboardView.settings:
        return const SettingsView();
    }
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.selected, required this.onSelect});

  final DashboardView selected;
  final void Function(DashboardView) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      color: AppColors.backgroundDark,
      child: NavigationRail(
        backgroundColor: AppColors.backgroundDark,
        selectedIndex: selected.index,
        onDestinationSelected: (i) => onSelect(DashboardView.values[i]),
        leading: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Icon(Icons.dashboard_rounded, color: AppColors.primary, size: 28),
        ),
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: Text('概览'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart_rounded),
            label: Text('数据报表'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: Text('设置'),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.view});

  final DashboardView view;

  String get _breadcrumb {
    switch (view) {
      case DashboardView.overview:
        return '概览';
      case DashboardView.report:
        return '数据报表';
      case DashboardView.settings:
        return '设置';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: AppDims.paddingPage),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border(bottom: BorderSide(color: AppColors.divider.withOpacity(0.3))),
      ),
      child: Row(
        children: [
          Text('概览 / $_breadcrumb', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          const SizedBox(width: 8),
          CircleAvatar(radius: 14, backgroundColor: AppColors.primary, child: Text('U', style: TextStyle(color: AppColors.white, fontSize: 12))),
          const SizedBox(width: 8),
          Text('用户', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
