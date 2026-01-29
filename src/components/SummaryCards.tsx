import type { Summary } from '../types';
import styles from './SummaryCards.module.css';

interface SummaryCardsProps {
  summary: Summary;
}

export function SummaryCards({ summary }: SummaryCardsProps) {
  return (
    <div className={styles.wrapper}>
      <div className={styles.card}>
        <span className={styles.label}>总收入</span>
        <span className={styles.valueIncome}>{formatMoney(summary.totalIncome)}</span>
      </div>
      <div className={styles.card}>
        <span className={styles.label}>总支出</span>
        <span className={styles.valueExpense}>{formatMoney(summary.totalExpense)}</span>
      </div>
      <div className={styles.card}>
        <span className={styles.label}>结余</span>
        <span className={summary.balance >= 0 ? styles.valueBalance : styles.valueNegative}>
          {formatMoney(summary.balance)}
        </span>
      </div>
    </div>
  );
}

function formatMoney(n: number): string {
  return new Intl.NumberFormat('zh-CN', { style: 'currency', currency: 'CNY', minimumFractionDigits: 0 }).format(n);
}
