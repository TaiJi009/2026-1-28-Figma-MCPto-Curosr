import styles from './Filters.module.css';

interface FiltersProps {
  years: string[];
  monthsByYear: Record<string, string[]>;
  year: string;
  month: string;
  onYearChange: (y: string) => void;
  onMonthChange: (m: string) => void;
}

export function Filters({
  years,
  monthsByYear,
  year,
  month,
  onYearChange,
  onMonthChange,
}: FiltersProps) {
  const months = year ? (monthsByYear[year] ?? []) : [];

  return (
    <div className={styles.wrapper}>
      <label className={styles.label}>
        年份
        <select
          value={year}
          onChange={(e) => {
            onYearChange(e.target.value);
            onMonthChange('');
          }}
          className={styles.select}
          aria-label="选择年份"
        >
          <option value="">全部</option>
          {years.map((y) => (
            <option key={y} value={y}>{y}</option>
          ))}
        </select>
      </label>
      <label className={styles.label}>
        月份
        <select
          value={month}
          onChange={(e) => onMonthChange(e.target.value)}
          className={styles.select}
          aria-label="选择月份"
          disabled={!year}
        >
          <option value="">全部</option>
          {months.map((m) => (
            <option key={m} value={m}>{m} 月</option>
          ))}
        </select>
      </label>
    </div>
  );
}
