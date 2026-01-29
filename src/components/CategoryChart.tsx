import { PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import type { CategoryData } from '../types';
import styles from './Charts.module.css';

interface CategoryChartProps {
  data: CategoryData[];
}

const COLORS = [
  'var(--nucleus-primary)',
  'var(--nucleus-primary-light)',
  '#4ade80',
  'var(--nucleus-error)',
  '#fbbf24',
  '#38bdf8',
  '#a78bfa',
  '#f472b6',
];

export function CategoryChart({ data }: CategoryChartProps) {
  const slice = data.slice(0, 12);
  const total = slice.reduce((s, d) => s + d.amount, 0);

  return (
    <div className={styles.wrapper}>
      <h3 className={styles.title}>分类占比</h3>
      <ResponsiveContainer width="100%" height={280}>
        <PieChart>
          <Pie
            data={slice}
            dataKey="amount"
            nameKey="category"
            cx="50%"
            cy="50%"
            outerRadius={90}
            label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
            labelLine={{ stroke: 'var(--nucleus-text-muted)' }}
          >
            {slice.map((_, i) => (
              <Cell key={i} fill={COLORS[i % COLORS.length]} />
            ))}
          </Pie>
          <Tooltip
            contentStyle={{ background: 'var(--nucleus-surface)', border: '1px solid var(--nucleus-border)', borderRadius: 8 }}
            formatter={(value: number) => [`¥${value.toLocaleString()}`, '']}
          />
          <Legend />
        </PieChart>
      </ResponsiveContainer>
      {total > 0 && (
        <p className={styles.total}>合计 ¥{total.toLocaleString()}</p>
      )}
    </div>
  );
}
