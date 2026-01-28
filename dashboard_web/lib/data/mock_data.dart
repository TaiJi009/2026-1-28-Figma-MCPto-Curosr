/// Mock data for PRD: 总用户数、今日订单、收入、完成率；访问量；订单列表；饼图占比
class MockData {
  static List<Map<String, String>> get kpis => [
    {'title': '总用户数', 'value': '12345', 'unit': ''},
    {'title': '今日订单', 'value': '128', 'unit': ''},
    {'title': '收入', 'value': '8888', 'unit': '¥'},
    {'title': '完成率', 'value': '94.5', 'unit': '%'},
  ];

  static List<Map<String, dynamic>> get visits7 => [
    {'label': '周一', 'value': 320},
    {'label': '周二', 'value': 410},
    {'label': '周三', 'value': 380},
    {'label': '周四', 'value': 520},
    {'label': '周五', 'value': 480},
    {'label': '周六', 'value': 390},
    {'label': '周日', 'value': 290},
  ];

  static List<Map<String, dynamic>> get orders5 => [
    {'label': 'D1', 'value': 45},
    {'label': 'D2', 'value': 62},
    {'label': 'D3', 'value': 58},
    {'label': 'D4', 'value': 71},
    {'label': 'D5', 'value': 55},
  ];

  static List<Map<String, dynamic>> get statusPie => [
    {'name': '已完成', 'value': 65.0, 'color': 0xFF4CAF50},
    {'name': '进行中', 'value': 25.0, 'color': 0xFFFF9800},
    {'name': '已取消', 'value': 10.0, 'color': 0xFFF44336},
  ];

  static List<Map<String, dynamic>> get orders => [
    {
      'id': 'ORD-1001',
      'amount': '¥128.00',
      'status': '已完成',
      'date': '2025-01-27',
    },
    {
      'id': 'ORD-1002',
      'amount': '¥256.00',
      'status': '进行中',
      'date': '2025-01-27',
    },
    {
      'id': 'ORD-1003',
      'amount': '¥88.00',
      'status': '已完成',
      'date': '2025-01-26',
    },
    {
      'id': 'ORD-1004',
      'amount': '¥1,200.00',
      'status': '已完成',
      'date': '2025-01-26',
    },
    {
      'id': 'ORD-1005',
      'amount': '¥56.00',
      'status': '已取消',
      'date': '2025-01-25',
    },
    {
      'id': 'ORD-1006',
      'amount': '¥320.00',
      'status': '进行中',
      'date': '2025-01-25',
    },
    {
      'id': 'ORD-1007',
      'amount': '¥99.00',
      'status': '已完成',
      'date': '2025-01-24',
    },
    {
      'id': 'ORD-1008',
      'amount': '¥445.00',
      'status': '已完成',
      'date': '2025-01-24',
    },
  ];
}
