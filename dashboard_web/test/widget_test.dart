import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard_web/main.dart';

void main() {
  testWidgets('App builds', (tester) async {
    await tester.pumpWidget(const DashboardApp());
    expect(find.text('概览'), findsAtLeast(1));
  });
}
