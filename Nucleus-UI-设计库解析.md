# Nucleus UI – Mobile App UI 设计库解析

> 来源：[Figma - Nucleus-UI LITE Community](https://www.figma.com/design/OVIHrj6SJXrDQ3IT2SzJlc/Nucleus-UI--Mobile-App-UI-Component-Library-%E2%80%93-LITE--Community-?node-id=858-8369)  
> 解析节点：`858-8369`（– Dark 画布）  
> 解析方式：Figma MCP PRO `get_figma_data`（React + 深度 7）

---

## 一、设计库概览

| 项目 | 说明 |
|------|------|
| **名称** | Nucleus-UI – Mobile App UI Component Library – LITE – Community |
| **类型** | 移动端 UI 组件库（Community / LITE 版） |
| **当前画布** | **– Dark**（深色主题） |
| **顶级画板数** | 8 |
| **已处理节点数** | 2,665 |
| **建议实现栈** | React + TypeScript + TailwindCSS |

---

## 二、页面结构（画布下顶级画板）

当前画布「– Dark」下包含以下主要页面/画板：

| 序号 | 名称 | 类型 | 说明 |
|------|------|------|------|
| 1 | **Login with Mobile Number** | FRAME | 手机号登录页：大标题导航、手机号输入、主按钮、说明文案、键盘与状态栏等 |
| 2 | **Splash Screen** | FRAME | 启动页：「Millions of destinations.」标题、插图、按钮组、Home Indicator、状态栏 |
| 3 | **Login with Email and Password** | FRAME | 邮箱+密码登录：标准导航栏、浮动标签输入框、主按钮、键盘与状态栏 |
| 4 | **Verification** | FRAME | 验证码/验证流程页：状态栏、验证相关 UI |
| 5 | **Walkthrough** | ICON（作画板用） | 引导页：「Create brilliant learning pathways」、Stepper - Dots、Page Controls: Dot |
| 6+ | 其他 | - | 画布共 8 个子项，其余为图标/占位等 |

---

## 三、组件体系（Components）

设计库按命名空间划分，主要包含 **Controls**、**Bars**、**Native** 三大类。

### 3.1 Controls / 控件

| 组件名 | 说明 | 常见变体/属性 |
|--------|------|-------------------------------|
| **Controls / Buttons** | 按钮 | Type: Primary / Secondary；Size: Block；State: Default；Mode: Light / Dark；Icon: False/True；Icon Position: None/Left/Right |
| **Controls / Buttons: Group** | 按钮组 | 多个按钮横向排列（如「Get started」「Log in」） |
| **Controls / Text Fields** | 单行输入框 | 带边框、圆角、Country Code 等组合 |
| **Controls / Text Field: Floating Label** | 浮动标签输入框 | 用于邮箱、密码等表单项 |
| **Controls / Page Controls: Dot** | 分页小圆点 | 用于 Walkthrough、轮播指示器 |

**按钮交互（来自 Figma 数据）：**

- Hover：`opacity: 0.8`，`0.2s ease-in-out`
- Click：`transform: scale(0.95)`，`0.1s ease-in-out`

### 3.2 Bars / 导航与栏

| 组件名 | 说明 |
|--------|------|
| **Bars / Nav Bars: Large** | 大标题导航栏：Large Title + Caption，适合登录/首屏 |
| **Bars / Nav Bars: Standard** | 标准导航栏：Title + Left/Right Actionable（图标或文字） |

### 3.3 Native / 系统原生

| 组件名 | 说明 |
|--------|------|
| **Native / Status Bar** | 系统状态栏：时间 9:41、信号、Wi-Fi、电量等 |
| **Native / Home Indicator** | 主屏指示条（全面屏底部横条） |
| **Native / Keyboard** | 系统键盘：包含 Background、Home Indicator、数字/字母键（0–9、Return、Space、123 等） |

---

## 四、设计 Token

### 4.1 颜色（从本次导出中出现的 RGB）

| 用途 | 色值 | 说明 |
|------|------|------|
| 主色 | `rgb(107, 78, 255)` | 主按钮、焦点边框等 |
| 白色 | `rgb(255, 255, 255)` | 深色背景上的文字、图标、边框 |
| 深色背景 | `rgb(9, 10, 10)` | 主背景、Nav Bar、Status Bar 等 |
| 次要文字 | `rgb(151, 156, 158)` | 说明文案、提示文字 |
| 浅灰 | `rgb(218, 218, 218)` | 图标、分割等 |
| 黑色 | `rgb(0, 0, 0)` | 浅色模式下的文字等 |

### 4.2 字体与排版

| Token 类型 | 示例值 | 用法 |
|------------|--------|------|
| 字体 | `Inter` / `Inter-Medium` / `Inter-Bold` | 全局正文与标题 |
| 大标题 | 32px / 36px line-height | Large Title、Splash 主标题 |
| 标题/副标题 | 24px / 32px line-height | Walkthrough 标题等 |
| 正文 | 16px / 16px 或 24px line-height | 按钮文字、Caption、说明 |
| 小字 | 约 12–14px | 辅助信息（若存在） |

### 4.3 圆角与边框

- 主按钮：`border-radius: 48px`（胶囊形）
- 输入框：有 `2px` 描边、圆角（如 focus 时 `2px solid rgb(107, 78, 255)`）
- 通用圆角 token 以 `*-border-radius` 形式出现在组件内

---

## 五、无障碍与语义

- 按钮、输入框等可聚焦元素带 `ariaLabel`、`ariaRole`、`tabIndex`
- 文案节点带 `ariaLabel`，便于读屏
- 角色包含：`button`、`text`、`image` 等，适合按 React 组件实现时保留语义与可访问性

---

## 六、与开发栈的对应关系（基于 MCP 输出）

Figma MCP 本次按 **React** 优化，并启用了：

- **布局 / 样式**：TailwindCSS、语义化 CSS
- **组件**：函数组件 + Hooks、TypeScript、PascalCase 命名
- **设计相关**：Design Tokens、组件变体、交互状态、基础无障碍信息

若你在此项目中用 **React + TypeScript + Tailwind**，可把上述 **Controls / Bars / Native** 映射为：

- `Controls/` → `Button`、`ButtonGroup`、`TextField`、`FloatingLabelField`、`PageControlDot`
- `Bars/` → `NavBarLarge`、`NavBarStandard`
- `Native/` → `StatusBar`、`HomeIndicator`、`Keyboard`（或按需封装为占位/壳组件）

---

## 七、建议的后续步骤（来自 Figma MCP 工作流）

1. **STEP 3**：使用 `process_design_comments` 查看设计师注释（逻辑、状态、边界说明等）。
2. **STEP 4**：使用 `download_design_assets` 导出切图与插图。
3. **STEP 5**：使用 `check_reference` 对照 `reference.png` 做视觉核对后再开发。

完整流程：`show_frameworks` → 设计数据（本节解析来源）→ 评论 → 资源下载 → 参考图核对 → 编码实现。

---

## 八、小结

Nucleus-UI LITE 是一套以**登录、启动、引导、验证**为主的移动端 UI 库，具备：

- 清晰的 **Controls / Bars / Native** 组件命名与变体（Type、Size、State、Mode、Icon 等）
- 明确的 **深色主题** 色彩与 Inter 字体体系
- 完整的 **导航栏、输入框、按钮、状态栏、键盘、Home Indicator** 等界面模块，可直接对应到 React 组件与 Tailwind 类名进行实现与扩展。

如需对某一页（如「Login with Mobile Number」或「Splash Screen」）做逐屏、逐组件拆解或生成 React 代码，可以指定页面名称或节点 ID，我可以按同一套结构继续细化。
