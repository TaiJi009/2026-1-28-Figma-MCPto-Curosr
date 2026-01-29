import type { Transaction } from '../types';
import styles from './DataTable.module.css';

interface DataTableProps {
  rows: Transaction[];
}

export function DataTable({ rows }: DataTableProps) {
  if (rows.length === 0) return <p className={styles.empty}>暂无数据</p>;

  return (
    <div className={styles.wrapper}>
      <h3 className={styles.title}>明细</h3>
      <div className={styles.scroll}>
        <table className={styles.table}>
          <thead>
            <tr>
              <th>日期</th>
              <th>类型</th>
              <th>分类</th>
              <th className={styles.num}>金额</th>
              <th>备注</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r) => (
              <tr key={r.id}>
                <td>{r.date}</td>
                <td>
                  <span className={r.type === 'income' ? styles.income : styles.expense}>
                    {r.type === 'income' ? '收入' : '支出'}
                  </span>
                </td>
                <td>{r.category || '-'}</td>
                <td className={`${styles.num} ${r.type === 'income' ? styles.income : styles.expense}`}>
                  {r.type === 'income' ? '+' : '-'}¥{r.amount.toLocaleString()}
                </td>
                <td>{r.note || '-'}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
