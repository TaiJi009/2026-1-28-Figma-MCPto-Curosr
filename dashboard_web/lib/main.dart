import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/dashboard_shell.dart';

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const DashboardShell(),
    );
  }
}
