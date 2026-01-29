# 个人财务看板

基于 React + Vite 的个人财务数据看板，支持上传 Excel 解析收入/支出，展示汇总、月度趋势与分类占比。UI 风格参考 Figma Nucleus UI 设计组件库。

## 功能

- **Excel 上传**：拖拽或选择 `.xlsx` / `.xls` 文件，在浏览器内解析（数据不离开本机）
- **时间筛选**：按年、按月筛选
- **概览卡片**：总收入、总支出、结余
- **月度趋势图**：按月的收入/支出柱状图
- **分类占比图**：按分类的饼图
- **明细表**：筛选后的流水明细

数据仅保存在当前页面内存中，刷新后清空。

## Excel 格式约定

表头**必须**包含：

| 列名（中文或英文） | 说明 |
|-------------------|------|
| 日期 / date       | 格式如 `2025-01-15` 或 Excel 日期序列 |
| 金额 / amount     | 数字，支持千分位 |

建议包含：

| 列名           | 说明 |
|----------------|------|
| 类型 / type    | `收入` 或 `支出`（不填按支出处理） |
| 分类 / category| 如餐饮、交通、工资等 |
| 备注 / note    | 可选说明 |

示例：

| 日期       | 类型 | 金额   | 分类 | 备注   |
|------------|------|--------|------|--------|
| 2025-01-01 | 收入 | 10000  | 工资 | 月薪   |
| 2025-01-05 | 支出 | 80     | 餐饮 | 午餐   |

## 本地运行

```bash
# 安装依赖（需联网）
npm install

# 开发
npm run dev

# 构建
npm run build

# 预览构建结果
npm run preview
```

## 部署到 GitHub Pages

### 方式一：GitHub Actions（推荐）

1. 将本仓库推送到你的 GitHub（如 `yourname/2026-1-28-Figma-MCPto-Curosr`）。
2. 仓库设置 → Pages → Source 选择 **GitHub Actions**。
3. 推送 `main` 分支后，Actions 会自动构建并部署。
4. 访问：`https://yourname.github.io/2026-1-28-Figma-MCPto-Curosr/`。

若仓库名不同，请修改项目根目录下：

- `vite.config.ts` 中的 `base: '/你的仓库名/'`
- `package.json` 中的 `homepage: "https://你的用户名.github.io/你的仓库名/"`

### 方式二：本地使用 gh-pages 分支

1. 在 GitHub 仓库设置 → Pages → Source 选择 **Deploy from a branch**，分支选 `gh-pages`，目录选 `/ (root)`。
2. 本地执行：

```bash
npm install
npm run deploy
```

会将 `dist` 目录推送到 `gh-pages` 分支，页面地址同上。

## 技术栈

- React 18 + TypeScript
- Vite 5
- Recharts（图表）
- xlsx / SheetJS（Excel 解析）
- Nucleus UI 设计 token（Figma 解析得到的颜色与圆角等）

## 许可

MIT
