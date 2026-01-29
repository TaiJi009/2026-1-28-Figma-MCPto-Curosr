import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from 'recharts';
import type { MonthlyData } from '../types';
import styles from './Charts.module.css';

interface TrendChartProps {
  data: MonthlyData[];
}

export function TrendChart({ data }: TrendChartProps) {
  const displayData = data.map((d) => ({
    ...d,
    monthLabel: d.month.replace('-', '年') + '月',
  }));

  return (
    <div className={styles.wrapper}>
      <h3 className={styles.title}>月度趋势</h3>
      <ResponsiveContainer width="100%" height={280}>
        <BarChart data={displayData} margin={{ top: 8, right: 8, left: 8, bottom: 8 }}>
          <CartesianGrid strokeDasharray="3 3" stroke="var(--nucleus-surface)" />
          <XAxis dataKey="monthLabel" tick={{ fill: 'var(--nucleus-text-muted)', fontSize: 12 }} />
          <YAxis tick={{ fill: 'var(--nucleus-text-muted)', fontSize: 12 }} tickFormatter={(v) => `¥${v}`} />
          <Tooltip
            contentStyle={{ background: 'var(--nucleus-surface)', border: '1px solid var(--nucleus-border)', borderRadius: 8 }}
            labelStyle={{ color: 'var(--nucleus-text)' }}
            formatter={(value: number) => [`¥${value.toLocaleString()}`, '']}
            labelFormatter={(label) => label}
          />
          <Legend />
          <Bar dataKey="income" name="收入" fill="rgb(74, 222, 128)" radius={[4, 4, 0, 0]} />
          <Bar dataKey="expense" name="支出" fill="var(--nucleus-error)" radius={[4, 4, 0, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
}
