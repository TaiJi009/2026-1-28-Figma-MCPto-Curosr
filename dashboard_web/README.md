# Dashboard Web

演示型 Dashboard，设计规范对齐 Figma Nucleus UI（– Dark）。  
PRD 见项目根目录 [PRD-Dashboard.md](../PRD-Dashboard.md)。

## 功能

- **侧栏**：概览、数据报表、设置
- **顶栏**：面包屑、通知、用户
- **概览**：KPI 卡片、近 7 日访问示意、最近订单摘要
- **数据报表**：KPI、筛选区（状态 / 关键词 / 时间）、折线图 / 柱状图 / 饼图、订单表格
- **设置**：占位页

## 运行

```bash
cd dashboard_web
flutter pub get
flutter run -d chrome
# 或
flutter run -d web
```

构建产物：

```bash
flutter build web
# 输出在 build/web/
```

## 技术栈

- Flutter 3.x（Web）
- 主题与设计 token：`lib/app_theme.dart`（Nucleus – Dark 色板、圆角、字阶）
- 图表：fl_chart
- 字体：Inter（Google Fonts / index.html 预连接）
